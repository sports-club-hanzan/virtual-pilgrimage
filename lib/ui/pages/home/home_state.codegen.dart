import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'home_state.codegen.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default({}) Set<Polyline> polylines,
  }) = _HomeState;

  const HomeState._();
}
