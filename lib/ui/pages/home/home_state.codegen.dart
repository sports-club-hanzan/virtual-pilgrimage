import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:virtualpilgrimage/ui/model/google_map_model.codegen.dart';

part 'home_state.codegen.freezed.dart';

/// MAPの中心地点の初期値
/// 四国の中心地点: https://ja.wikipedia.org/wiki/%E5%9B%9B%E5%9B%BD
const _initialCameraPosition = CameraPosition(
  target: LatLng(33.3339, 133.22565),
  zoom: 7.5,
);

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required GoogleMapModel googleMap,
    required CameraPosition initialCameraPosition,
    @Default({}) Set<Marker> markers,
    @Default({}) Set<Polyline> polylines,
    @Default(0) int animationTempleId,
  }) = _HomeState;

  const HomeState._();

  HomeState setGoogleMap(GoogleMapModel googleMap) => copyWith(googleMap: googleMap);

  void onGoogleMapCreated(GoogleMapController controller) => googleMap.onMapCreated(controller);

  // ignore: prefer_constructors_over_static_methods
  static HomeState initialize() => HomeState(
        googleMap: GoogleMapModel(controller: Completer()),
        initialCameraPosition: _initialCameraPosition,
      );

  /// MAP上のマーカー・経路を更新
  HomeState setupMarkers(Set<Marker> markers, Set<Polyline> polylines) =>
      copyWith(markers: markers, polylines: polylines);
}
