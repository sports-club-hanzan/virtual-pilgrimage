import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:virtualpilgrimage/analytics.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/update_pilgrimage_progress_result.codegen.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/update_pilgrimage_progress_usecase.dart';
import 'package:virtualpilgrimage/domain/temple/temple_repository.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_crashlytics_provider.dart';
import 'package:virtualpilgrimage/logger.dart';

import 'home_state.codegen.dart';

final homeProvider = StateNotifierProvider.autoDispose<HomePresenter, HomeState>(
  HomePresenter.new,
);

class HomePresenter extends StateNotifier<HomeState> {
  HomePresenter(this._ref) : super(HomeState.initialize()) {
    _updatePilgrimageProgressUsecase = _ref.read(updatePilgrimageProgressUsecaseProvider);
    _analytics = _ref.read(analyticsProvider);
    _crashlytics = _ref.read(firebaseCrashlyticsProvider);
    _templeRepository = _ref.read(templeRepositoryProvider);
    initialize();
  }

  final Ref _ref;
  late final UpdatePilgrimageProgressUsecase _updatePilgrimageProgressUsecase;
  late final Analytics _analytics;
  late final FirebaseCrashlytics _crashlytics;
  late final TempleRepository _templeRepository;

  // 札所の数
  static const maxTempleNumber = 88;

  /// 初期化処理
  /// 初期化時にユーザのヘルスケア情報を読み取ってDBに書き込む
  Future<void> initialize() async {
    // ログインした時点でお寺の情報を取得する。初回のみこの処理で時間がかかる
    unawaited(_templeRepository.getTempleInfoAll());
    unawaited(_analytics.logEvent(eventName: AnalyticsEvent.initializeHomePageAndGetHealth));

    final loginState = _ref.read(loginStateProvider);
    final user = _ref.read(userStateProvider);
    // ログインしていない状態で Home Page に遷移してきても
    // 情報を描画できずどうしようもないので crash させる
    if (loginState != UserStatus.created || user == null) {
      final reason = 'user must be login in home page [loginState][$loginState][user][$user]';
      await _crashlytics.recordError(ArgumentError(reason), null, reason: reason);
      _crashlytics.crash();
      return;
    }

    // ヘルスケア情報取得の権限が付与されていない場合、許可を得るダイアログを開く
    // TODO(s14t284): ヘルスケア情報を取得するダイアログで許可を押す旨をUIに表示した方が良いか検討
    final activityPermission = await Permission.activityRecognition.request();
    _ref.read(loggerProvider).d(activityPermission);
    if (activityPermission.isDenied) {
      await _crashlytics.recordError(
        'now allowed to get health information [userId][${user.id}]',
        null,
      );
      await openAppSettings();
    }

    try {
      final logicResult = await _updatePilgrimageProgressUsecase.execute(user.id);
      if (logicResult.status != UpdatePilgrimageProgressResultStatus.success) {
        await _crashlytics.recordError(
          logicResult.error,
          null,
          reason: 'failed to update pilgrimage progress '
              '[status][${logicResult.status}]'
              '[logicResult][$logicResult]',
        );
      }
      // TODO(s14t284): この中に今回到達したお寺の情報が含まれているのでUIに利用したりローカルpush通知に利用したりする
      // UIに使う例：到達した札所のスタンプを押すアニメーションなど
      // ローカルpush通知：ここで実装するのではなく、バックグラウンド処理で利用する
      // ignore: avoid_print
      print(logicResult.reachedPilgrimageIdList);
      final updatedUser = logicResult.updatedUser;
      if (updatedUser != null) {
        await setMarkerAndPolylines(updatedUser, logicResult);
        _ref.read(userStateProvider.notifier).state = updatedUser;
      }
    } on Exception catch (e) {
      unawaited(_crashlytics.recordError(e, null));
    }
  }

  /// ユーザ情報を利用して GoogleMap 上に描画するユーザ情報のマーカーを追加
  Future<void> setMarkerAndPolylines(
    VirtualPilgrimageUser user,
    UpdatePilgrimageProgressResult logicResult,
  ) async {
    final nextPilgrimage = await _templeRepository
        .getTempleInfo(_nextPilgrimageNumber(user.pilgrimage.nowPilgrimageId));
    final polylines = {
      Polyline(
        polylineId: PolylineId('${nextPilgrimage.id}番札所:${nextPilgrimage.name}の経路'),
        points: logicResult.virtualPolylineLatLngs,
        color: Colors.pinkAccent,
        width: 5,
      )
    };

    Set<Marker> markers = state.markers;
    final virtualPosition = logicResult.virtualPosition;
    if (virtualPosition != null) {
      markers = {
        ...state.markers,
        Marker(
          markerId: MarkerId(user.nickname),
          position: virtualPosition,
          icon: user.userIcon,
          infoWindow: InfoWindow(title: '現在: ${user.health?.totalSteps ?? 0}歩'),
        )
      };
      // stateより先にカメラポジションを更新するアニメーションを実行
      final controller = await state.googleMap.controller.future;
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: virtualPosition, zoom: 13),
        ),
      );
    }

    // stateを更新して、markerと経路を表示
    state = state.copyWith(
      markers: markers,
      polylines: polylines,
    );
  }

  /// GoogleMap の描画が完了した時に呼ばれる
  /// [controller] GoogleMap の描画に使われるインスタンス
  void onMapCreated(GoogleMapController controller) => state.onGoogleMapCreated(controller);

  /// 次の札所の番号を返す
  /// 88箇所目に到達していたら 1 を返す
  /// [pilgrimageId] 現在の札所の番号
  int _nextPilgrimageNumber(int pilgrimageId) {
    if (pilgrimageId < maxTempleNumber) {
      return pilgrimageId + 1;
    }
    return 1;
  }
}
