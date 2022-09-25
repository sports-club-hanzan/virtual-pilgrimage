import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:virtualpilgrimage/model/google_map_model.codegen.dart';

part 'home_state.codegen.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required GoogleMapModel googleMap,
  }) = _HomeState;

  const HomeState._();

  HomeState setGoogleMap(GoogleMapModel googleMap) => copyWith(googleMap: googleMap);

  void onGoogleMapCreated(GoogleMapController controller) => googleMap.onMapCreated(controller);

  // ignore: prefer_constructors_over_static_methods
  static HomeState initialize() => HomeState(googleMap: GoogleMapModel.initialize());
}
