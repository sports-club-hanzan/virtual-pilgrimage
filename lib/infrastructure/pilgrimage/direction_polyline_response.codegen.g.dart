// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direction_polyline_response.codegen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DirectionPolylineResponse _$$_DirectionPolylineResponseFromJson(
        Map<String, dynamic> json) =>
    _$_DirectionPolylineResponse(
      routes: (json['routes'] as List<dynamic>)
          .map((e) => DirectionsRoute.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
      errorMessage: json['error_message'] as String?,
    );

Map<String, dynamic> _$$_DirectionPolylineResponseToJson(
        _$_DirectionPolylineResponse instance) =>
    <String, dynamic>{
      'routes': instance.routes.map((e) => e.toJson()).toList(),
      'status': instance.status,
      'error_message': instance.errorMessage,
    };

_$_DirectionsRoute _$$_DirectionsRouteFromJson(Map<String, dynamic> json) =>
    _$_DirectionsRoute(
      bounds: Bounds.fromJson(json['bounds'] as Map<String, dynamic>),
      copyrights: json['copyrights'] as String,
      legs: (json['legs'] as List<dynamic>)
          .map((e) => DirectionsLeg.fromJson(e as Map<String, dynamic>))
          .toList(),
      overviewPolyline: DirectionsPolyline.fromJson(
          json['overview_polyline'] as Map<String, dynamic>),
      summary: json['summary'] as String,
      warnings:
          (json['warnings'] as List<dynamic>).map((e) => e as String).toList(),
      waypointOrder: (json['waypoint_order'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$$_DirectionsRouteToJson(_$_DirectionsRoute instance) =>
    <String, dynamic>{
      'bounds': instance.bounds.toJson(),
      'copyrights': instance.copyrights,
      'legs': instance.legs.map((e) => e.toJson()).toList(),
      'overview_polyline': instance.overviewPolyline.toJson(),
      'summary': instance.summary,
      'warnings': instance.warnings,
      'waypoint_order': instance.waypointOrder,
    };

_$_Bounds _$$_BoundsFromJson(Map<String, dynamic> json) => _$_Bounds(
      northeast:
          LatLngLiteral.fromJson(json['northeast'] as Map<String, dynamic>),
      southwest:
          LatLngLiteral.fromJson(json['southwest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_BoundsToJson(_$_Bounds instance) => <String, dynamic>{
      'northeast': instance.northeast.toJson(),
      'southwest': instance.southwest.toJson(),
    };

_$_LatLngLiteral _$$_LatLngLiteralFromJson(Map<String, dynamic> json) =>
    _$_LatLngLiteral(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$$_LatLngLiteralToJson(_$_LatLngLiteral instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

_$_DirectionsLeg _$$_DirectionsLegFromJson(Map<String, dynamic> json) =>
    _$_DirectionsLeg(
      startAddress: json['start_address'] as String,
      startLocation: LatLngLiteral.fromJson(
          json['start_location'] as Map<String, dynamic>),
      endAddress: json['end_address'] as String,
      endLocation:
          LatLngLiteral.fromJson(json['end_location'] as Map<String, dynamic>),
      steps: (json['steps'] as List<dynamic>)
          .map((e) => DirectionsStep.fromJson(e as Map<String, dynamic>))
          .toList(),
      viaWaypoint: (json['via_waypoint'] as List<dynamic>)
          .map((e) => DirectionsViaWaypoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      distance: json['distance'] == null
          ? null
          : TextValueObject.fromJson(json['distance'] as Map<String, dynamic>),
      duration: json['duration'] == null
          ? null
          : TextValueObject.fromJson(json['duration'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_DirectionsLegToJson(_$_DirectionsLeg instance) =>
    <String, dynamic>{
      'start_address': instance.startAddress,
      'start_location': instance.startLocation.toJson(),
      'end_address': instance.endAddress,
      'end_location': instance.endLocation.toJson(),
      'steps': instance.steps.map((e) => e.toJson()).toList(),
      'via_waypoint': instance.viaWaypoint.map((e) => e.toJson()).toList(),
      'distance': instance.distance?.toJson(),
      'duration': instance.duration?.toJson(),
    };

_$_DirectionsStep _$$_DirectionsStepFromJson(Map<String, dynamic> json) =>
    _$_DirectionsStep(
      duration:
          TextValueObject.fromJson(json['duration'] as Map<String, dynamic>),
      startLocation: LatLngLiteral.fromJson(
          json['start_location'] as Map<String, dynamic>),
      endLocation:
          LatLngLiteral.fromJson(json['end_location'] as Map<String, dynamic>),
      htmlInstructions: json['html_instructions'] as String,
      polyline:
          DirectionsPolyline.fromJson(json['polyline'] as Map<String, dynamic>),
      distance:
          TextValueObject.fromJson(json['distance'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_DirectionsStepToJson(_$_DirectionsStep instance) =>
    <String, dynamic>{
      'duration': instance.duration.toJson(),
      'start_location': instance.startLocation.toJson(),
      'end_location': instance.endLocation.toJson(),
      'html_instructions': instance.htmlInstructions,
      'polyline': instance.polyline.toJson(),
      'distance': instance.distance.toJson(),
    };

_$_TextValueObject _$$_TextValueObjectFromJson(Map<String, dynamic> json) =>
    _$_TextValueObject(
      text: json['text'] as String,
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$$_TextValueObjectToJson(_$_TextValueObject instance) =>
    <String, dynamic>{
      'text': instance.text,
      'value': instance.value,
    };

_$_DirectionsPolyline _$$_DirectionsPolylineFromJson(
        Map<String, dynamic> json) =>
    _$_DirectionsPolyline(
      points: json['points'] as String,
    );

Map<String, dynamic> _$$_DirectionsPolylineToJson(
        _$_DirectionsPolyline instance) =>
    <String, dynamic>{
      'points': instance.points,
    };

_$_DirectionsTransitStop _$$_DirectionsTransitStopFromJson(
        Map<String, dynamic> json) =>
    _$_DirectionsTransitStop(
      location:
          LatLngLiteral.fromJson(json['location'] as Map<String, dynamic>),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_DirectionsTransitStopToJson(
        _$_DirectionsTransitStop instance) =>
    <String, dynamic>{
      'location': instance.location,
      'name': instance.name,
    };

_$_DirectionsViaWaypoint _$$_DirectionsViaWaypointFromJson(
        Map<String, dynamic> json) =>
    _$_DirectionsViaWaypoint(
      location: json['location'] == null
          ? null
          : LatLngLiteral.fromJson(json['location'] as Map<String, dynamic>),
      stepIndex: json['step_index'] as int?,
      stepInterpolation: (json['step_interpolation'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_DirectionsViaWaypointToJson(
        _$_DirectionsViaWaypoint instance) =>
    <String, dynamic>{
      'location': instance.location,
      'step_index': instance.stepIndex,
      'step_interpolation': instance.stepInterpolation,
    };
