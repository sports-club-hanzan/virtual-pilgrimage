import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:virtualpilgrimage/analytics.dart';
import 'package:virtualpilgrimage/application/pilgrimage/update_pilgrimage_progress_result.codegen.dart';
import 'package:virtualpilgrimage/application/pilgrimage/update_pilgrimage_progress_usecase.dart';
import 'package:virtualpilgrimage/application/pilgrimage/temple_repository.dart';
import 'package:virtualpilgrimage/domain/user/health/update_health_result.dart';
import 'package:virtualpilgrimage/domain/user/health/update_health_usecase.dart';
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
    _userStateNotifier = _ref.read(userStateProvider.notifier);
    initialize();
  }

  final Ref _ref;
  late final UpdatePilgrimageProgressUsecase _updatePilgrimageProgressUsecase;
  late final Analytics _analytics;
  late final FirebaseCrashlytics _crashlytics;
  late final TempleRepository _templeRepository;
  late final StateController<VirtualPilgrimageUser?> _userStateNotifier;

  // 札所の数
  static const maxTempleNumber = 88;

  /// 初期化処理
  /// 初期化時にユーザのヘルスケア情報を読み取ってDBに書き込む
  Future<void> initialize() async {
    // ログインした時点でお寺の情報を取得する。初回のみこの処理で時間がかかる
    unawaited(_templeRepository.getTempleInfoAll());
    unawaited(_analytics.logEvent(eventName: AnalyticsEvent.initializeHomePageAndGetHealth));

    final loginState = _ref.read(loginStateProvider);
    VirtualPilgrimageUser? user = _ref.read(userStateProvider);
    // ログインしていない状態で Home Page に遷移してきても
    // 情報を描画できずどうしようもないので crash させる
    if (loginState != UserStatus.created || user == null) {
      final reason = 'user must be login in home page [loginState][$loginState][user][$user]';
      await _crashlytics.recordError(ArgumentError(reason), null, reason: reason);
      _crashlytics.crash();
      return;
    }

    // androidの場合、ヘルスケア情報取得の権限が付与されていない場合、許可を得るダイアログを開く
    // TODO(s14t284): ヘルスケア情報を取得するダイアログで許可を押す旨をUIに表示した方が良いか検討
    if (defaultTargetPlatform.name.toLowerCase() == 'android') {
      final activityPermission = await Permission.activityRecognition.request();
      _ref.read(loggerProvider).d(activityPermission);
      if (activityPermission.isDenied) {
        await _crashlytics.recordError(
          'now allowed to get health information [userId][${user.id}]',
          null,
        );
        await openAppSettings();
        return;
      }
    }

    try {
      // お遍路の進捗を確認
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
      final updatedUser = logicResult.updatedUser;
      if (updatedUser != null) {
        await setMarkerAndPolylines(updatedUser, logicResult);
        user = updatedUser;
        _userStateNotifier.state = updatedUser;
      }

      // 描画を更新しながら、ヘルスケア情報も更新する
      // 先にmapの描画を更新してバックグラウンドでヘルスケア情報を更新しておくことで、UIの変更の反映を早める
      final updateHealthResult = await _ref.read(updateHealthUsecaseProvider).execute(user);
      if (updateHealthResult.status == UpdateHealthStatus.success) {
        if (updateHealthResult.updatedUser != null) {
          _userStateNotifier.state = updateHealthResult.updatedUser;
        }
      } else {
        unawaited(_crashlytics.recordError(updateHealthResult.error, null));
      }

      // 最後に到達した札所があったら御朱印アニメーションを描画
      // 最後にこのstate更新を実行することで、MAPの動作が止まっている状態でアニメーションが実行できる
      if (logicResult.reachedPilgrimageIdList.isNotEmpty) {
        // 複数の札所にたどり着いたら最後にたどり着いた札所の御朱印を設定
        final templeId = logicResult.reachedPilgrimageIdList.last;
        state = state.copyWith(animationTempleId: templeId);
        unawaited(_analytics.logEvent(eventName: AnalyticsEvent.reachTemple));
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
          icon: user.mapIcon,
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
    state = state.setupMarkers(markers, polylines);
  }

  /// AnimationWidget の閉じるを押した時に呼ばれる
  void onAnimationClosed() {
    state = state.copyWith(animationTempleId: 0);
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
