import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:virtualpilgrimage/analytics.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/direction_polyline_repository.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/update_pilgrimage_progress_result.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/update_pilgrimage_progress_usecase.dart';
import 'package:virtualpilgrimage/domain/temple/temple_repository.dart';
import 'package:virtualpilgrimage/domain/user/health/update_health_result.dart';
import 'package:virtualpilgrimage/domain/user/health/update_health_usecase.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_crashlytics_provider.dart';
import 'package:virtualpilgrimage/infrastructure/pilgrimage/direction_polyline_repository_impl.dart';

import 'home_state.codegen.dart';

final homeProvider = StateNotifierProvider.autoDispose<HomePresenter, HomeState>(
  HomePresenter.new,
);

class HomePresenter extends StateNotifier<HomeState> {
  HomePresenter(this._ref) : super(HomeState.initialize()) {
    _updatePilgrimageProgressUsecase = _ref.read(updatePilgrimageProgressUsecaseProvider);
    _updateHealthUsecase = _ref.read(updateHealthUsecaseProvider);
    _directionPolylineRepository = _ref.read(directionPolylineRepositoryPresenter);
    _analytics = _ref.read(analyticsProvider);
    _crashlytics = _ref.read(firebaseCrashlyticsProvider);
    _templeRepository = _ref.read(templeRepositoryProvider);
    initialize();
  }

  final Ref _ref;
  late final UpdatePilgrimageProgressUsecase _updatePilgrimageProgressUsecase;
  late final UpdateHealthUsecase _updateHealthUsecase;
  late final DirectionPolylineRepositoryImpl _directionPolylineRepository;
  late final Analytics _analytics;
  late final FirebaseCrashlytics _crashlytics;
  late final TempleRepository _templeRepository;

  /// 初期化処理
  /// 初期化時にユーザのヘルスケア情報を読み取ってDBに書き込む
  Future<void> initialize() async {
    unawaited(_analytics.logEvent(eventName: AnalyticsEvent.initializeHomePageAndGetHealth));

    final user = _ref.read(userStateProvider);
    // ログインしていない状態で Home Page に遷移してきても
    // 情報を描画できずどうしようもないので crash させる
    if (user == null) {
      const reason = 'user must be login in home page';
      await _crashlytics.recordError(ArgumentError(reason), null, reason: reason);
      _crashlytics.crash();
      return;
    }

    // ヘルスケア情報取得の権限が付与されていない場合、許可を得るダイアログを開く
    // TODO(s14t284): ヘルスケア情報を取得するダイアログで許可を押す旨をUIに表示した方が良いか検討
    if ((await Permission.activityRecognition.request()).isDenied) {
      await _crashlytics.recordError(
        'now allowed to get health information [userId][${user.id}]',
        null,
      );
      await openAppSettings();
    }

    late final UpdatePilgrimageProgressResult pilgrimageProgressResult;
    // 以下は処理順は重要ではないため、非同期に並列で処理して UI への反映を早める
    try {
      await Future.wait(<Future<void>>[
        updatePilgrimageProgress(user).then((value) => pilgrimageProgressResult = value),
        updateHealthInfo(user),
        updatePolyline(),
        setUserMarker(user),
        // ログインした時点でお寺の情報を取得する
        _templeRepository.getTempleInfoAll(),
      ]);
      // TODO(s14t284): この中に今回到達したお寺の情報が含まれているのでUIに利用したりローカルpush通知に利用したりする
      // UIに使う例：到達した札所のスタンプを押すアニメーションなど
      // ローカルpush通知：ここで実装するのではなく、バックグラウンド処理で利用する
      // ignore: avoid_print
      print(pilgrimageProgressResult.reachedPilgrimageIdList);
    } on Exception catch (e) {
      unawaited(_crashlytics.recordError(e, null));
    }
  }

  Future<UpdatePilgrimageProgressResult> updatePilgrimageProgress(
    VirtualPilgrimageUser user,
  ) async {
    final result = await _updatePilgrimageProgressUsecase.execute(user);
    if (result.status != UpdatePilgrimageProgressResultStatus.success) {
      await _crashlytics.recordError(
        result.error,
        null,
        reason: 'failed to update pilgrimage progress [status][${result.status}]',
      );
    }
    return result;
  }

  Future<void> updateHealthInfo(VirtualPilgrimageUser user) async {
    final result = await _updateHealthUsecase.execute(user);
    if (result.status != UpdateHealthStatus.success) {
      await _crashlytics.recordError(
        result.error,
        null,
        reason: 'failed to record health information [status][${result.status}]',
      );
    }
  }

  /// map 上で2点間の距離を可視化するための経路を取得するメソッド
  /// FIXME: 利用する地点が固定値になっているため機能追加に合わせて修正する
  Future<void> updatePolyline() async {
    // 現在地点から適当なお寺への経路の可視化
    final latlngs = await _directionPolylineRepository.getPolylines(
      origin: const LatLng(34.15944444, 134.503),
      destination: const LatLng(34.10, 134.467),
    );
    final polylines = {
      Polyline(
        polylineId: const PolylineId('id'),
        points: latlngs,
        color: Colors.pinkAccent,
        width: 5,
      )
    };
    state = state.setGoogleMap(state.googleMap.copyWith(polylines: polylines));
  }

  /// ユーザ情報を利用して GoogleMap 上に描画するユーザ情報のマーカーを追加
  Future<void> setUserMarker(VirtualPilgrimageUser user) async {
    final markers = {
      ...state.googleMap.markers,
      Marker(
        markerId: MarkerId(user.nickname),
        position: const LatLng(34.10, 134.467), // FIXME: 適当に固定値を入れているだけであるため修正する
        icon: user.userIcon,
        infoWindow: InfoWindow(title: '現在: ${user.health?.totalSteps ?? 0}歩'),
      )
    };
    state = state.setGoogleMap(state.googleMap.copyWith(markers: markers));
  }

  /// GoogleMap の描画が完了した時に呼ばれる
  /// [controller] GoogleMap の描画に使われるインスタンス
  void onMapCreated(GoogleMapController controller) => state.onGoogleMapCreated(controller);
}
