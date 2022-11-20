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
}
