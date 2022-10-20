import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as maps;
import 'package:permission_handler/permission_handler.dart';
import 'package:virtualpilgrimage/analytics.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/direction_polyline_repository.dart';
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
    _updateHealthUsecase = _ref.read(updateHealthUsecaseProvider);
    _directionPolylineRepository = _ref.read(directionPolylineRepositoryPresenter);
    _analytics = _ref.read(analyticsProvider);
    _crashlytics = _ref.read(firebaseCrashlyticsProvider);
    initialize();
  }

  final Ref _ref;
  late final UpdateHealthUsecase _updateHealthUsecase;
  late final DirectionPolylineRepositoryImpl _directionPolylineRepository;
  late final Analytics _analytics;
  late final FirebaseCrashlytics _crashlytics;

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

    // 以下は処理順は重要ではないため、非同期に並列で処理して UI への反映を早める
    try {
      await Future.wait(<Future<void>>[getHealth(user), updatePolyline(user)]);
      await setUserMarker(user);
    } on Exception catch (e) {
      unawaited(_crashlytics.recordError(e, null));
    }
  }

  Future<void> getHealth(VirtualPilgrimageUser user) async {
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
  Future<void> updatePolyline(VirtualPilgrimageUser user) async {
    // 現在地点から適当なお寺への経路の可視化
    final templeInfo = await _ref.read(templeRepositoryProvider).getTempleInfo(user.pilgrimage!.nowPilgrimageId);

    final lines = await _directionPolylineRepository.getPolylinesFromEncodedPoints(encodedPoints: templeInfo.encodedPoints);
    final polylines = {
      Polyline(
        polylineId: const PolylineId('id'),
        points: lines,
        color: Colors.pinkAccent,
        width: 5,
      )
    };
    state = state.copyWith(polylines: polylines);
  }

  /// ユーザ情報を利用して GoogleMap 上に描画するユーザ情報のマーカーを追加
  Future<void> setUserMarker(VirtualPilgrimageUser user) async {
    // 到着したお寺までの累積距離[m]
    num totalDistance = 0;
    if (user.pilgrimage!.nowPilgrimageId != 1) {
      // ignore: unused_local_variable
      final templeInfo = await _ref.read(templeRepositoryProvider)
          .getTempleInfo(user.pilgrimage!.nowPilgrimageId - 1);
      totalDistance = 100;
      //totalDistance = templeInfo.totalDistance;
    }
    // 到着したお寺からの経過距離[m]
    final distance = (user.health?.totalDistance ?? 0) - totalDistance;
    final position = computePosition(
        state.polylines.first.points,
        distance,
    );
    final markers = {
      ...state.markers,
      Marker(
        markerId: MarkerId(user.nickname),
        position: position,
        icon: user.userIcon,
        infoWindow: InfoWindow(title: '現在: ${user.health?.totalSteps ?? 0}歩'),
      )
    };

    state = state.copyWith(markers: markers);
  }

  /// GoogleMap の描画が完了した時に呼ばれる
  /// [controller] GoogleMap の描画に使われるインスタンス
  void onMapCreated(GoogleMapController controller) => state.onGoogleMapCreated(controller);

  /// 経路情報（リスト）から現在地を算出する
  LatLng computePosition(List<LatLng> latlngs, num meter) {
    num distance = meter;
    for(int i = 0; i < latlngs.length - 1; i++) {
      final from = maps.LatLng(latlngs[i].latitude, latlngs[i].longitude);
      final to = maps.LatLng(latlngs[i+1].latitude, latlngs[i+1].longitude);
      final num d = maps.SphericalUtil.computeDistanceBetween(from, to);
      if (distance < d) {
        // fromからtoの間にいる場合は割合で表示する
        final latlng = maps.SphericalUtil.interpolate(from, to, distance / d);
        return LatLng(latlng.latitude, latlng.longitude);
      } else {
        // fromからtoの距離をdistanceが超える場合は次の区間で計算する
        distance = distance - d;
      }
    }

    // 経路リストを超える場合は次のお寺にほぼ到着している
    return latlngs.last;
  }
}
