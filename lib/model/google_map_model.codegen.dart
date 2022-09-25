import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'google_map_model.codegen.freezed.dart';

// google map の描画状態をもつモデル
@freezed
class GoogleMapModel with _$GoogleMapModel {
  factory GoogleMapModel({
    required Completer<GoogleMapController> controller,
    @Default({}) Set<Marker> markers,
    @Default({}) Set<Polyline> polylines,
  }) = _GoogleMapModel;

  const GoogleMapModel._();

  void onMapCreated(GoogleMapController controller) => this.controller.complete(controller);

  // ignore: prefer_constructors_over_static_methods
  static GoogleMapModel initialize() => GoogleMapModel(
        controller: Completer(),
        // FIXME: 適当に埋めているだけであるため、firestore or cache からお遍路の情報を引っ張ってくるようにする
        markers: {
          const Marker(
            markerId: MarkerId('霊山寺'),
            position: LatLng(34.15944444, 134.503),
            infoWindow: InfoWindow(title: '霊峰寺', snippet: '1箇所目'),
          ),
          const Marker(
            markerId: MarkerId('極楽寺'),
            position: LatLng(34.15565, 134.490347),
            infoWindow: InfoWindow(title: '極楽寺', snippet: '2箇所目'),
          ),
        },
      );
}
