import 'package:freezed_annotation/freezed_annotation.dart';

part 'direction_polyline_response.codegen.freezed.dart';
part 'direction_polyline_response.codegen.g.dart';

// https://developers.google.com/maps/documentation/directions/get-directions#DirectionsResponse
// 不要なパラメータは定義していない
@freezed
class DirectionPolylineResponse with _$DirectionPolylineResponse {
  @JsonSerializable(explicitToJson: true)
  factory DirectionPolylineResponse({
    required List<DirectionsRoute> routes,
    required String status,
    @JsonKey(name: 'error_message') String? errorMessage,
  }) = _DirectionPolylineResponse;

  const DirectionPolylineResponse._();

  factory DirectionPolylineResponse.fromJson(Map<String, dynamic> map) =>
      _$DirectionPolylineResponseFromJson(map);
}

@freezed
class DirectionsRoute with _$DirectionsRoute {
  @JsonSerializable(explicitToJson: true, ignoreUnannotated: true)
  factory DirectionsRoute({
    @JsonKey() required Bounds bounds,
    @JsonKey() required String copyrights,
    @JsonKey() required List<DirectionsLeg> legs,
    @JsonKey(name: 'overview_polyline') required DirectionsPolyline overviewPolyline,
    @JsonKey() required String summary,
    @JsonKey() required List<String> warnings,
    @JsonKey(name: 'waypoint_order') required List<int> waypointOrder,
  }) = _DirectionsRoute;

  const DirectionsRoute._();

  factory DirectionsRoute.fromJson(Map<String, dynamic> map) => _$DirectionsRouteFromJson(map);
}

@freezed
class Bounds with _$Bounds {
  @JsonSerializable(explicitToJson: true)
  factory Bounds({
    required LatLngLiteral northeast,
    required LatLngLiteral southwest,
  }) = _Bounds;

  const Bounds._();

  factory Bounds.fromJson(Map<String, dynamic> map) => _$BoundsFromJson(map);
}

@freezed
class LatLngLiteral with _$LatLngLiteral {
  factory LatLngLiteral({
    required double lat,
    required double lng,
  }) = _LatLngLiteral;

  const LatLngLiteral._();

  factory LatLngLiteral.fromJson(Map<String, dynamic> map) => _$LatLngLiteralFromJson(map);
}

@freezed
class DirectionsLeg with _$DirectionsLeg {
  @JsonSerializable(explicitToJson: true, ignoreUnannotated: true)
  factory DirectionsLeg({
    @JsonKey(name: 'start_address') required String startAddress,
    @JsonKey(name: 'start_location') required LatLngLiteral startLocation,
    @JsonKey(name: 'end_address') required String endAddress,
    @JsonKey(name: 'end_location') required LatLngLiteral endLocation,
    @JsonKey() required List<DirectionsStep> steps,
    @JsonKey(name: 'via_waypoint') required List<DirectionsViaWaypoint> viaWaypoint,
    @JsonKey() TextValueObject? distance,
    @JsonKey() TextValueObject? duration,
  }) = _DirectionsLeg;

  const DirectionsLeg._();

  factory DirectionsLeg.fromJson(Map<String, dynamic> map) => _$DirectionsLegFromJson(map);
}

@freezed
class DirectionsStep with _$DirectionsStep {
  @JsonSerializable(explicitToJson: true, ignoreUnannotated: true)
  factory DirectionsStep({
    @JsonKey(name: 'duration') required TextValueObject duration,
    @JsonKey(name: 'start_location') required LatLngLiteral startLocation,
    @JsonKey(name: 'end_location') required LatLngLiteral endLocation,
    @JsonKey(name: 'html_instructions') required String htmlInstructions,
    @JsonKey(name: 'polyline') required DirectionsPolyline polyline,
    @JsonKey(name: 'distance') required TextValueObject distance,
  }) = _DirectionsStep;

  const DirectionsStep._();

  factory DirectionsStep.fromJson(Map<String, dynamic> map) => _$DirectionsStepFromJson(map);
}

@freezed
class TextValueObject with _$TextValueObject {
  factory TextValueObject({
    required String text,
    required double value,
  }) = _TextValueObject;

  const TextValueObject._();

  factory TextValueObject.fromJson(Map<String, dynamic> map) => _$TextValueObjectFromJson(map);
}

@freezed
class DirectionsPolyline with _$DirectionsPolyline {
  factory DirectionsPolyline({
    required String points,
  }) = _DirectionsPolyline;

  const DirectionsPolyline._();

  factory DirectionsPolyline.fromJson(Map<String, dynamic> map) =>
      _$DirectionsPolylineFromJson(map);
}

@freezed
class DirectionsTransitStop with _$DirectionsTransitStop {
  factory DirectionsTransitStop({
    required LatLngLiteral location,
    required String name,
  }) = _DirectionsTransitStop;

  const DirectionsTransitStop._();

  factory DirectionsTransitStop.fromJson(Map<String, dynamic> map) =>
      _$DirectionsTransitStopFromJson(map);
}

@freezed
class DirectionsViaWaypoint with _$DirectionsViaWaypoint {
  factory DirectionsViaWaypoint({
    LatLngLiteral? location,
    @JsonKey(name: 'step_index') int? stepIndex,
    @JsonKey(name: 'step_interpolation') double? stepInterpolation,
  }) = _DirectionsViaWaypoint;

  const DirectionsViaWaypoint._();

  factory DirectionsViaWaypoint.fromJson(Map<String, dynamic> map) =>
      _$DirectionsViaWaypointFromJson(map);
}
