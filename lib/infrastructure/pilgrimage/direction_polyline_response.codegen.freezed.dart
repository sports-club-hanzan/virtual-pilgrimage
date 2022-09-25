// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'direction_polyline_response.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DirectionPolylineResponse _$DirectionPolylineResponseFromJson(
    Map<String, dynamic> json) {
  return _DirectionPolylineResponse.fromJson(json);
}

/// @nodoc
mixin _$DirectionPolylineResponse {
  List<DirectionsRoute> get routes => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'error_message')
  String? get errorMessage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DirectionPolylineResponseCopyWith<DirectionPolylineResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DirectionPolylineResponseCopyWith<$Res> {
  factory $DirectionPolylineResponseCopyWith(DirectionPolylineResponse value,
          $Res Function(DirectionPolylineResponse) then) =
      _$DirectionPolylineResponseCopyWithImpl<$Res>;
  $Res call(
      {List<DirectionsRoute> routes,
      String status,
      @JsonKey(name: 'error_message') String? errorMessage});
}

/// @nodoc
class _$DirectionPolylineResponseCopyWithImpl<$Res>
    implements $DirectionPolylineResponseCopyWith<$Res> {
  _$DirectionPolylineResponseCopyWithImpl(this._value, this._then);

  final DirectionPolylineResponse _value;
  // ignore: unused_field
  final $Res Function(DirectionPolylineResponse) _then;

  @override
  $Res call({
    Object? routes = freezed,
    Object? status = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      routes: routes == freezed
          ? _value.routes
          : routes // ignore: cast_nullable_to_non_nullable
              as List<DirectionsRoute>,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: errorMessage == freezed
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_DirectionPolylineResponseCopyWith<$Res>
    implements $DirectionPolylineResponseCopyWith<$Res> {
  factory _$$_DirectionPolylineResponseCopyWith(
          _$_DirectionPolylineResponse value,
          $Res Function(_$_DirectionPolylineResponse) then) =
      __$$_DirectionPolylineResponseCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<DirectionsRoute> routes,
      String status,
      @JsonKey(name: 'error_message') String? errorMessage});
}

/// @nodoc
class __$$_DirectionPolylineResponseCopyWithImpl<$Res>
    extends _$DirectionPolylineResponseCopyWithImpl<$Res>
    implements _$$_DirectionPolylineResponseCopyWith<$Res> {
  __$$_DirectionPolylineResponseCopyWithImpl(
      _$_DirectionPolylineResponse _value,
      $Res Function(_$_DirectionPolylineResponse) _then)
      : super(_value, (v) => _then(v as _$_DirectionPolylineResponse));

  @override
  _$_DirectionPolylineResponse get _value =>
      super._value as _$_DirectionPolylineResponse;

  @override
  $Res call({
    Object? routes = freezed,
    Object? status = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$_DirectionPolylineResponse(
      routes: routes == freezed
          ? _value._routes
          : routes // ignore: cast_nullable_to_non_nullable
              as List<DirectionsRoute>,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: errorMessage == freezed
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_DirectionPolylineResponse extends _DirectionPolylineResponse {
  _$_DirectionPolylineResponse(
      {required final List<DirectionsRoute> routes,
      required this.status,
      @JsonKey(name: 'error_message') this.errorMessage})
      : _routes = routes,
        super._();

  factory _$_DirectionPolylineResponse.fromJson(Map<String, dynamic> json) =>
      _$$_DirectionPolylineResponseFromJson(json);

  final List<DirectionsRoute> _routes;
  @override
  List<DirectionsRoute> get routes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_routes);
  }

  @override
  final String status;
  @override
  @JsonKey(name: 'error_message')
  final String? errorMessage;

  @override
  String toString() {
    return 'DirectionPolylineResponse(routes: $routes, status: $status, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DirectionPolylineResponse &&
            const DeepCollectionEquality().equals(other._routes, _routes) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.errorMessage, errorMessage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_routes),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(errorMessage));

  @JsonKey(ignore: true)
  @override
  _$$_DirectionPolylineResponseCopyWith<_$_DirectionPolylineResponse>
      get copyWith => __$$_DirectionPolylineResponseCopyWithImpl<
          _$_DirectionPolylineResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DirectionPolylineResponseToJson(
      this,
    );
  }
}

abstract class _DirectionPolylineResponse extends DirectionPolylineResponse {
  factory _DirectionPolylineResponse(
          {required final List<DirectionsRoute> routes,
          required final String status,
          @JsonKey(name: 'error_message') final String? errorMessage}) =
      _$_DirectionPolylineResponse;
  _DirectionPolylineResponse._() : super._();

  factory _DirectionPolylineResponse.fromJson(Map<String, dynamic> json) =
      _$_DirectionPolylineResponse.fromJson;

  @override
  List<DirectionsRoute> get routes;
  @override
  String get status;
  @override
  @JsonKey(name: 'error_message')
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$_DirectionPolylineResponseCopyWith<_$_DirectionPolylineResponse>
      get copyWith => throw _privateConstructorUsedError;
}

DirectionsRoute _$DirectionsRouteFromJson(Map<String, dynamic> json) {
  return _DirectionsRoute.fromJson(json);
}

/// @nodoc
mixin _$DirectionsRoute {
  @JsonKey()
  Bounds get bounds => throw _privateConstructorUsedError;
  @JsonKey()
  String get copyrights => throw _privateConstructorUsedError;
  @JsonKey()
  List<DirectionsLeg> get legs => throw _privateConstructorUsedError;
  @JsonKey(name: 'overview_polyline')
  DirectionsPolyline get overviewPolyline => throw _privateConstructorUsedError;
  @JsonKey()
  String get summary => throw _privateConstructorUsedError;
  @JsonKey()
  List<String> get warnings => throw _privateConstructorUsedError;
  @JsonKey(name: 'waypoint_order')
  List<int> get waypointOrder => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DirectionsRouteCopyWith<DirectionsRoute> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DirectionsRouteCopyWith<$Res> {
  factory $DirectionsRouteCopyWith(
          DirectionsRoute value, $Res Function(DirectionsRoute) then) =
      _$DirectionsRouteCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey() Bounds bounds,
      @JsonKey() String copyrights,
      @JsonKey() List<DirectionsLeg> legs,
      @JsonKey(name: 'overview_polyline') DirectionsPolyline overviewPolyline,
      @JsonKey() String summary,
      @JsonKey() List<String> warnings,
      @JsonKey(name: 'waypoint_order') List<int> waypointOrder});

  $BoundsCopyWith<$Res> get bounds;
  $DirectionsPolylineCopyWith<$Res> get overviewPolyline;
}

/// @nodoc
class _$DirectionsRouteCopyWithImpl<$Res>
    implements $DirectionsRouteCopyWith<$Res> {
  _$DirectionsRouteCopyWithImpl(this._value, this._then);

  final DirectionsRoute _value;
  // ignore: unused_field
  final $Res Function(DirectionsRoute) _then;

  @override
  $Res call({
    Object? bounds = freezed,
    Object? copyrights = freezed,
    Object? legs = freezed,
    Object? overviewPolyline = freezed,
    Object? summary = freezed,
    Object? warnings = freezed,
    Object? waypointOrder = freezed,
  }) {
    return _then(_value.copyWith(
      bounds: bounds == freezed
          ? _value.bounds
          : bounds // ignore: cast_nullable_to_non_nullable
              as Bounds,
      copyrights: copyrights == freezed
          ? _value.copyrights
          : copyrights // ignore: cast_nullable_to_non_nullable
              as String,
      legs: legs == freezed
          ? _value.legs
          : legs // ignore: cast_nullable_to_non_nullable
              as List<DirectionsLeg>,
      overviewPolyline: overviewPolyline == freezed
          ? _value.overviewPolyline
          : overviewPolyline // ignore: cast_nullable_to_non_nullable
              as DirectionsPolyline,
      summary: summary == freezed
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      warnings: warnings == freezed
          ? _value.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      waypointOrder: waypointOrder == freezed
          ? _value.waypointOrder
          : waypointOrder // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }

  @override
  $BoundsCopyWith<$Res> get bounds {
    return $BoundsCopyWith<$Res>(_value.bounds, (value) {
      return _then(_value.copyWith(bounds: value));
    });
  }

  @override
  $DirectionsPolylineCopyWith<$Res> get overviewPolyline {
    return $DirectionsPolylineCopyWith<$Res>(_value.overviewPolyline, (value) {
      return _then(_value.copyWith(overviewPolyline: value));
    });
  }
}

/// @nodoc
abstract class _$$_DirectionsRouteCopyWith<$Res>
    implements $DirectionsRouteCopyWith<$Res> {
  factory _$$_DirectionsRouteCopyWith(
          _$_DirectionsRoute value, $Res Function(_$_DirectionsRoute) then) =
      __$$_DirectionsRouteCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey() Bounds bounds,
      @JsonKey() String copyrights,
      @JsonKey() List<DirectionsLeg> legs,
      @JsonKey(name: 'overview_polyline') DirectionsPolyline overviewPolyline,
      @JsonKey() String summary,
      @JsonKey() List<String> warnings,
      @JsonKey(name: 'waypoint_order') List<int> waypointOrder});

  @override
  $BoundsCopyWith<$Res> get bounds;
  @override
  $DirectionsPolylineCopyWith<$Res> get overviewPolyline;
}

/// @nodoc
class __$$_DirectionsRouteCopyWithImpl<$Res>
    extends _$DirectionsRouteCopyWithImpl<$Res>
    implements _$$_DirectionsRouteCopyWith<$Res> {
  __$$_DirectionsRouteCopyWithImpl(
      _$_DirectionsRoute _value, $Res Function(_$_DirectionsRoute) _then)
      : super(_value, (v) => _then(v as _$_DirectionsRoute));

  @override
  _$_DirectionsRoute get _value => super._value as _$_DirectionsRoute;

  @override
  $Res call({
    Object? bounds = freezed,
    Object? copyrights = freezed,
    Object? legs = freezed,
    Object? overviewPolyline = freezed,
    Object? summary = freezed,
    Object? warnings = freezed,
    Object? waypointOrder = freezed,
  }) {
    return _then(_$_DirectionsRoute(
      bounds: bounds == freezed
          ? _value.bounds
          : bounds // ignore: cast_nullable_to_non_nullable
              as Bounds,
      copyrights: copyrights == freezed
          ? _value.copyrights
          : copyrights // ignore: cast_nullable_to_non_nullable
              as String,
      legs: legs == freezed
          ? _value._legs
          : legs // ignore: cast_nullable_to_non_nullable
              as List<DirectionsLeg>,
      overviewPolyline: overviewPolyline == freezed
          ? _value.overviewPolyline
          : overviewPolyline // ignore: cast_nullable_to_non_nullable
              as DirectionsPolyline,
      summary: summary == freezed
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      warnings: warnings == freezed
          ? _value._warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      waypointOrder: waypointOrder == freezed
          ? _value._waypointOrder
          : waypointOrder // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, ignoreUnannotated: true)
class _$_DirectionsRoute extends _DirectionsRoute {
  _$_DirectionsRoute(
      {@JsonKey() required this.bounds,
      @JsonKey() required this.copyrights,
      @JsonKey() required final List<DirectionsLeg> legs,
      @JsonKey(name: 'overview_polyline') required this.overviewPolyline,
      @JsonKey() required this.summary,
      @JsonKey() required final List<String> warnings,
      @JsonKey(name: 'waypoint_order') required final List<int> waypointOrder})
      : _legs = legs,
        _warnings = warnings,
        _waypointOrder = waypointOrder,
        super._();

  factory _$_DirectionsRoute.fromJson(Map<String, dynamic> json) =>
      _$$_DirectionsRouteFromJson(json);

  @override
  @JsonKey()
  final Bounds bounds;
  @override
  @JsonKey()
  final String copyrights;
  final List<DirectionsLeg> _legs;
  @override
  @JsonKey()
  List<DirectionsLeg> get legs {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_legs);
  }

  @override
  @JsonKey(name: 'overview_polyline')
  final DirectionsPolyline overviewPolyline;
  @override
  @JsonKey()
  final String summary;
  final List<String> _warnings;
  @override
  @JsonKey()
  List<String> get warnings {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_warnings);
  }

  final List<int> _waypointOrder;
  @override
  @JsonKey(name: 'waypoint_order')
  List<int> get waypointOrder {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_waypointOrder);
  }

  @override
  String toString() {
    return 'DirectionsRoute(bounds: $bounds, copyrights: $copyrights, legs: $legs, overviewPolyline: $overviewPolyline, summary: $summary, warnings: $warnings, waypointOrder: $waypointOrder)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DirectionsRoute &&
            const DeepCollectionEquality().equals(other.bounds, bounds) &&
            const DeepCollectionEquality()
                .equals(other.copyrights, copyrights) &&
            const DeepCollectionEquality().equals(other._legs, _legs) &&
            const DeepCollectionEquality()
                .equals(other.overviewPolyline, overviewPolyline) &&
            const DeepCollectionEquality().equals(other.summary, summary) &&
            const DeepCollectionEquality().equals(other._warnings, _warnings) &&
            const DeepCollectionEquality()
                .equals(other._waypointOrder, _waypointOrder));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(bounds),
      const DeepCollectionEquality().hash(copyrights),
      const DeepCollectionEquality().hash(_legs),
      const DeepCollectionEquality().hash(overviewPolyline),
      const DeepCollectionEquality().hash(summary),
      const DeepCollectionEquality().hash(_warnings),
      const DeepCollectionEquality().hash(_waypointOrder));

  @JsonKey(ignore: true)
  @override
  _$$_DirectionsRouteCopyWith<_$_DirectionsRoute> get copyWith =>
      __$$_DirectionsRouteCopyWithImpl<_$_DirectionsRoute>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DirectionsRouteToJson(
      this,
    );
  }
}

abstract class _DirectionsRoute extends DirectionsRoute {
  factory _DirectionsRoute(
      {@JsonKey()
          required final Bounds bounds,
      @JsonKey()
          required final String copyrights,
      @JsonKey()
          required final List<DirectionsLeg> legs,
      @JsonKey(name: 'overview_polyline')
          required final DirectionsPolyline overviewPolyline,
      @JsonKey()
          required final String summary,
      @JsonKey()
          required final List<String> warnings,
      @JsonKey(name: 'waypoint_order')
          required final List<int> waypointOrder}) = _$_DirectionsRoute;
  _DirectionsRoute._() : super._();

  factory _DirectionsRoute.fromJson(Map<String, dynamic> json) =
      _$_DirectionsRoute.fromJson;

  @override
  @JsonKey()
  Bounds get bounds;
  @override
  @JsonKey()
  String get copyrights;
  @override
  @JsonKey()
  List<DirectionsLeg> get legs;
  @override
  @JsonKey(name: 'overview_polyline')
  DirectionsPolyline get overviewPolyline;
  @override
  @JsonKey()
  String get summary;
  @override
  @JsonKey()
  List<String> get warnings;
  @override
  @JsonKey(name: 'waypoint_order')
  List<int> get waypointOrder;
  @override
  @JsonKey(ignore: true)
  _$$_DirectionsRouteCopyWith<_$_DirectionsRoute> get copyWith =>
      throw _privateConstructorUsedError;
}

Bounds _$BoundsFromJson(Map<String, dynamic> json) {
  return _Bounds.fromJson(json);
}

/// @nodoc
mixin _$Bounds {
  LatLngLiteral get northeast => throw _privateConstructorUsedError;
  LatLngLiteral get southwest => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BoundsCopyWith<Bounds> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoundsCopyWith<$Res> {
  factory $BoundsCopyWith(Bounds value, $Res Function(Bounds) then) =
      _$BoundsCopyWithImpl<$Res>;
  $Res call({LatLngLiteral northeast, LatLngLiteral southwest});

  $LatLngLiteralCopyWith<$Res> get northeast;
  $LatLngLiteralCopyWith<$Res> get southwest;
}

/// @nodoc
class _$BoundsCopyWithImpl<$Res> implements $BoundsCopyWith<$Res> {
  _$BoundsCopyWithImpl(this._value, this._then);

  final Bounds _value;
  // ignore: unused_field
  final $Res Function(Bounds) _then;

  @override
  $Res call({
    Object? northeast = freezed,
    Object? southwest = freezed,
  }) {
    return _then(_value.copyWith(
      northeast: northeast == freezed
          ? _value.northeast
          : northeast // ignore: cast_nullable_to_non_nullable
              as LatLngLiteral,
      southwest: southwest == freezed
          ? _value.southwest
          : southwest // ignore: cast_nullable_to_non_nullable
              as LatLngLiteral,
    ));
  }

  @override
  $LatLngLiteralCopyWith<$Res> get northeast {
    return $LatLngLiteralCopyWith<$Res>(_value.northeast, (value) {
      return _then(_value.copyWith(northeast: value));
    });
  }

  @override
  $LatLngLiteralCopyWith<$Res> get southwest {
    return $LatLngLiteralCopyWith<$Res>(_value.southwest, (value) {
      return _then(_value.copyWith(southwest: value));
    });
  }
}

/// @nodoc
abstract class _$$_BoundsCopyWith<$Res> implements $BoundsCopyWith<$Res> {
  factory _$$_BoundsCopyWith(_$_Bounds value, $Res Function(_$_Bounds) then) =
      __$$_BoundsCopyWithImpl<$Res>;
  @override
  $Res call({LatLngLiteral northeast, LatLngLiteral southwest});

  @override
  $LatLngLiteralCopyWith<$Res> get northeast;
  @override
  $LatLngLiteralCopyWith<$Res> get southwest;
}

/// @nodoc
class __$$_BoundsCopyWithImpl<$Res> extends _$BoundsCopyWithImpl<$Res>
    implements _$$_BoundsCopyWith<$Res> {
  __$$_BoundsCopyWithImpl(_$_Bounds _value, $Res Function(_$_Bounds) _then)
      : super(_value, (v) => _then(v as _$_Bounds));

  @override
  _$_Bounds get _value => super._value as _$_Bounds;

  @override
  $Res call({
    Object? northeast = freezed,
    Object? southwest = freezed,
  }) {
    return _then(_$_Bounds(
      northeast: northeast == freezed
          ? _value.northeast
          : northeast // ignore: cast_nullable_to_non_nullable
              as LatLngLiteral,
      southwest: southwest == freezed
          ? _value.southwest
          : southwest // ignore: cast_nullable_to_non_nullable
              as LatLngLiteral,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_Bounds extends _Bounds {
  _$_Bounds({required this.northeast, required this.southwest}) : super._();

  factory _$_Bounds.fromJson(Map<String, dynamic> json) =>
      _$$_BoundsFromJson(json);

  @override
  final LatLngLiteral northeast;
  @override
  final LatLngLiteral southwest;

  @override
  String toString() {
    return 'Bounds(northeast: $northeast, southwest: $southwest)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Bounds &&
            const DeepCollectionEquality().equals(other.northeast, northeast) &&
            const DeepCollectionEquality().equals(other.southwest, southwest));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(northeast),
      const DeepCollectionEquality().hash(southwest));

  @JsonKey(ignore: true)
  @override
  _$$_BoundsCopyWith<_$_Bounds> get copyWith =>
      __$$_BoundsCopyWithImpl<_$_Bounds>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BoundsToJson(
      this,
    );
  }
}

abstract class _Bounds extends Bounds {
  factory _Bounds(
      {required final LatLngLiteral northeast,
      required final LatLngLiteral southwest}) = _$_Bounds;
  _Bounds._() : super._();

  factory _Bounds.fromJson(Map<String, dynamic> json) = _$_Bounds.fromJson;

  @override
  LatLngLiteral get northeast;
  @override
  LatLngLiteral get southwest;
  @override
  @JsonKey(ignore: true)
  _$$_BoundsCopyWith<_$_Bounds> get copyWith =>
      throw _privateConstructorUsedError;
}

LatLngLiteral _$LatLngLiteralFromJson(Map<String, dynamic> json) {
  return _LatLngLiteral.fromJson(json);
}

/// @nodoc
mixin _$LatLngLiteral {
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LatLngLiteralCopyWith<LatLngLiteral> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LatLngLiteralCopyWith<$Res> {
  factory $LatLngLiteralCopyWith(
          LatLngLiteral value, $Res Function(LatLngLiteral) then) =
      _$LatLngLiteralCopyWithImpl<$Res>;
  $Res call({double lat, double lng});
}

/// @nodoc
class _$LatLngLiteralCopyWithImpl<$Res>
    implements $LatLngLiteralCopyWith<$Res> {
  _$LatLngLiteralCopyWithImpl(this._value, this._then);

  final LatLngLiteral _value;
  // ignore: unused_field
  final $Res Function(LatLngLiteral) _then;

  @override
  $Res call({
    Object? lat = freezed,
    Object? lng = freezed,
  }) {
    return _then(_value.copyWith(
      lat: lat == freezed
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: lng == freezed
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$$_LatLngLiteralCopyWith<$Res>
    implements $LatLngLiteralCopyWith<$Res> {
  factory _$$_LatLngLiteralCopyWith(
          _$_LatLngLiteral value, $Res Function(_$_LatLngLiteral) then) =
      __$$_LatLngLiteralCopyWithImpl<$Res>;
  @override
  $Res call({double lat, double lng});
}

/// @nodoc
class __$$_LatLngLiteralCopyWithImpl<$Res>
    extends _$LatLngLiteralCopyWithImpl<$Res>
    implements _$$_LatLngLiteralCopyWith<$Res> {
  __$$_LatLngLiteralCopyWithImpl(
      _$_LatLngLiteral _value, $Res Function(_$_LatLngLiteral) _then)
      : super(_value, (v) => _then(v as _$_LatLngLiteral));

  @override
  _$_LatLngLiteral get _value => super._value as _$_LatLngLiteral;

  @override
  $Res call({
    Object? lat = freezed,
    Object? lng = freezed,
  }) {
    return _then(_$_LatLngLiteral(
      lat: lat == freezed
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: lng == freezed
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LatLngLiteral extends _LatLngLiteral {
  _$_LatLngLiteral({required this.lat, required this.lng}) : super._();

  factory _$_LatLngLiteral.fromJson(Map<String, dynamic> json) =>
      _$$_LatLngLiteralFromJson(json);

  @override
  final double lat;
  @override
  final double lng;

  @override
  String toString() {
    return 'LatLngLiteral(lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LatLngLiteral &&
            const DeepCollectionEquality().equals(other.lat, lat) &&
            const DeepCollectionEquality().equals(other.lng, lng));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(lat),
      const DeepCollectionEquality().hash(lng));

  @JsonKey(ignore: true)
  @override
  _$$_LatLngLiteralCopyWith<_$_LatLngLiteral> get copyWith =>
      __$$_LatLngLiteralCopyWithImpl<_$_LatLngLiteral>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LatLngLiteralToJson(
      this,
    );
  }
}

abstract class _LatLngLiteral extends LatLngLiteral {
  factory _LatLngLiteral(
      {required final double lat,
      required final double lng}) = _$_LatLngLiteral;
  _LatLngLiteral._() : super._();

  factory _LatLngLiteral.fromJson(Map<String, dynamic> json) =
      _$_LatLngLiteral.fromJson;

  @override
  double get lat;
  @override
  double get lng;
  @override
  @JsonKey(ignore: true)
  _$$_LatLngLiteralCopyWith<_$_LatLngLiteral> get copyWith =>
      throw _privateConstructorUsedError;
}

DirectionsLeg _$DirectionsLegFromJson(Map<String, dynamic> json) {
  return _DirectionsLeg.fromJson(json);
}

/// @nodoc
mixin _$DirectionsLeg {
  @JsonKey(name: 'start_address')
  String get startAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_location')
  LatLngLiteral get startLocation => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_address')
  String get endAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_location')
  LatLngLiteral get endLocation => throw _privateConstructorUsedError;
  @JsonKey()
  List<DirectionsStep> get steps => throw _privateConstructorUsedError;
  @JsonKey(name: 'via_waypoint')
  List<DirectionsViaWaypoint> get viaWaypoint =>
      throw _privateConstructorUsedError;
  @JsonKey()
  TextValueObject? get distance => throw _privateConstructorUsedError;
  @JsonKey()
  TextValueObject? get duration => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DirectionsLegCopyWith<DirectionsLeg> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DirectionsLegCopyWith<$Res> {
  factory $DirectionsLegCopyWith(
          DirectionsLeg value, $Res Function(DirectionsLeg) then) =
      _$DirectionsLegCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'start_address') String startAddress,
      @JsonKey(name: 'start_location') LatLngLiteral startLocation,
      @JsonKey(name: 'end_address') String endAddress,
      @JsonKey(name: 'end_location') LatLngLiteral endLocation,
      @JsonKey() List<DirectionsStep> steps,
      @JsonKey(name: 'via_waypoint') List<DirectionsViaWaypoint> viaWaypoint,
      @JsonKey() TextValueObject? distance,
      @JsonKey() TextValueObject? duration});

  $LatLngLiteralCopyWith<$Res> get startLocation;
  $LatLngLiteralCopyWith<$Res> get endLocation;
  $TextValueObjectCopyWith<$Res>? get distance;
  $TextValueObjectCopyWith<$Res>? get duration;
}

/// @nodoc
class _$DirectionsLegCopyWithImpl<$Res>
    implements $DirectionsLegCopyWith<$Res> {
  _$DirectionsLegCopyWithImpl(this._value, this._then);

  final DirectionsLeg _value;
  // ignore: unused_field
  final $Res Function(DirectionsLeg) _then;

  @override
  $Res call({
    Object? startAddress = freezed,
    Object? startLocation = freezed,
    Object? endAddress = freezed,
    Object? endLocation = freezed,
    Object? steps = freezed,
    Object? viaWaypoint = freezed,
    Object? distance = freezed,
    Object? duration = freezed,
  }) {
    return _then(_value.copyWith(
      startAddress: startAddress == freezed
          ? _value.startAddress
          : startAddress // ignore: cast_nullable_to_non_nullable
              as String,
      startLocation: startLocation == freezed
          ? _value.startLocation
          : startLocation // ignore: cast_nullable_to_non_nullable
              as LatLngLiteral,
      endAddress: endAddress == freezed
          ? _value.endAddress
          : endAddress // ignore: cast_nullable_to_non_nullable
              as String,
      endLocation: endLocation == freezed
          ? _value.endLocation
          : endLocation // ignore: cast_nullable_to_non_nullable
              as LatLngLiteral,
      steps: steps == freezed
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<DirectionsStep>,
      viaWaypoint: viaWaypoint == freezed
          ? _value.viaWaypoint
          : viaWaypoint // ignore: cast_nullable_to_non_nullable
              as List<DirectionsViaWaypoint>,
      distance: distance == freezed
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as TextValueObject?,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as TextValueObject?,
    ));
  }

  @override
  $LatLngLiteralCopyWith<$Res> get startLocation {
    return $LatLngLiteralCopyWith<$Res>(_value.startLocation, (value) {
      return _then(_value.copyWith(startLocation: value));
    });
  }

  @override
  $LatLngLiteralCopyWith<$Res> get endLocation {
    return $LatLngLiteralCopyWith<$Res>(_value.endLocation, (value) {
      return _then(_value.copyWith(endLocation: value));
    });
  }

  @override
  $TextValueObjectCopyWith<$Res>? get distance {
    if (_value.distance == null) {
      return null;
    }

    return $TextValueObjectCopyWith<$Res>(_value.distance!, (value) {
      return _then(_value.copyWith(distance: value));
    });
  }

  @override
  $TextValueObjectCopyWith<$Res>? get duration {
    if (_value.duration == null) {
      return null;
    }

    return $TextValueObjectCopyWith<$Res>(_value.duration!, (value) {
      return _then(_value.copyWith(duration: value));
    });
  }
}

/// @nodoc
abstract class _$$_DirectionsLegCopyWith<$Res>
    implements $DirectionsLegCopyWith<$Res> {
  factory _$$_DirectionsLegCopyWith(
          _$_DirectionsLeg value, $Res Function(_$_DirectionsLeg) then) =
      __$$_DirectionsLegCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'start_address') String startAddress,
      @JsonKey(name: 'start_location') LatLngLiteral startLocation,
      @JsonKey(name: 'end_address') String endAddress,
      @JsonKey(name: 'end_location') LatLngLiteral endLocation,
      @JsonKey() List<DirectionsStep> steps,
      @JsonKey(name: 'via_waypoint') List<DirectionsViaWaypoint> viaWaypoint,
      @JsonKey() TextValueObject? distance,
      @JsonKey() TextValueObject? duration});

  @override
  $LatLngLiteralCopyWith<$Res> get startLocation;
  @override
  $LatLngLiteralCopyWith<$Res> get endLocation;
  @override
  $TextValueObjectCopyWith<$Res>? get distance;
  @override
  $TextValueObjectCopyWith<$Res>? get duration;
}

/// @nodoc
class __$$_DirectionsLegCopyWithImpl<$Res>
    extends _$DirectionsLegCopyWithImpl<$Res>
    implements _$$_DirectionsLegCopyWith<$Res> {
  __$$_DirectionsLegCopyWithImpl(
      _$_DirectionsLeg _value, $Res Function(_$_DirectionsLeg) _then)
      : super(_value, (v) => _then(v as _$_DirectionsLeg));

  @override
  _$_DirectionsLeg get _value => super._value as _$_DirectionsLeg;

  @override
  $Res call({
    Object? startAddress = freezed,
    Object? startLocation = freezed,
    Object? endAddress = freezed,
    Object? endLocation = freezed,
    Object? steps = freezed,
    Object? viaWaypoint = freezed,
    Object? distance = freezed,
    Object? duration = freezed,
  }) {
    return _then(_$_DirectionsLeg(
      startAddress: startAddress == freezed
          ? _value.startAddress
          : startAddress // ignore: cast_nullable_to_non_nullable
              as String,
      startLocation: startLocation == freezed
          ? _value.startLocation
          : startLocation // ignore: cast_nullable_to_non_nullable
              as LatLngLiteral,
      endAddress: endAddress == freezed
          ? _value.endAddress
          : endAddress // ignore: cast_nullable_to_non_nullable
              as String,
      endLocation: endLocation == freezed
          ? _value.endLocation
          : endLocation // ignore: cast_nullable_to_non_nullable
              as LatLngLiteral,
      steps: steps == freezed
          ? _value._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<DirectionsStep>,
      viaWaypoint: viaWaypoint == freezed
          ? _value._viaWaypoint
          : viaWaypoint // ignore: cast_nullable_to_non_nullable
              as List<DirectionsViaWaypoint>,
      distance: distance == freezed
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as TextValueObject?,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as TextValueObject?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, ignoreUnannotated: true)
class _$_DirectionsLeg extends _DirectionsLeg {
  _$_DirectionsLeg(
      {@JsonKey(name: 'start_address')
          required this.startAddress,
      @JsonKey(name: 'start_location')
          required this.startLocation,
      @JsonKey(name: 'end_address')
          required this.endAddress,
      @JsonKey(name: 'end_location')
          required this.endLocation,
      @JsonKey()
          required final List<DirectionsStep> steps,
      @JsonKey(name: 'via_waypoint')
          required final List<DirectionsViaWaypoint> viaWaypoint,
      @JsonKey()
          this.distance,
      @JsonKey()
          this.duration})
      : _steps = steps,
        _viaWaypoint = viaWaypoint,
        super._();

  factory _$_DirectionsLeg.fromJson(Map<String, dynamic> json) =>
      _$$_DirectionsLegFromJson(json);

  @override
  @JsonKey(name: 'start_address')
  final String startAddress;
  @override
  @JsonKey(name: 'start_location')
  final LatLngLiteral startLocation;
  @override
  @JsonKey(name: 'end_address')
  final String endAddress;
  @override
  @JsonKey(name: 'end_location')
  final LatLngLiteral endLocation;
  final List<DirectionsStep> _steps;
  @override
  @JsonKey()
  List<DirectionsStep> get steps {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  final List<DirectionsViaWaypoint> _viaWaypoint;
  @override
  @JsonKey(name: 'via_waypoint')
  List<DirectionsViaWaypoint> get viaWaypoint {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_viaWaypoint);
  }

  @override
  @JsonKey()
  final TextValueObject? distance;
  @override
  @JsonKey()
  final TextValueObject? duration;

  @override
  String toString() {
    return 'DirectionsLeg(startAddress: $startAddress, startLocation: $startLocation, endAddress: $endAddress, endLocation: $endLocation, steps: $steps, viaWaypoint: $viaWaypoint, distance: $distance, duration: $duration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DirectionsLeg &&
            const DeepCollectionEquality()
                .equals(other.startAddress, startAddress) &&
            const DeepCollectionEquality()
                .equals(other.startLocation, startLocation) &&
            const DeepCollectionEquality()
                .equals(other.endAddress, endAddress) &&
            const DeepCollectionEquality()
                .equals(other.endLocation, endLocation) &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            const DeepCollectionEquality()
                .equals(other._viaWaypoint, _viaWaypoint) &&
            const DeepCollectionEquality().equals(other.distance, distance) &&
            const DeepCollectionEquality().equals(other.duration, duration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(startAddress),
      const DeepCollectionEquality().hash(startLocation),
      const DeepCollectionEquality().hash(endAddress),
      const DeepCollectionEquality().hash(endLocation),
      const DeepCollectionEquality().hash(_steps),
      const DeepCollectionEquality().hash(_viaWaypoint),
      const DeepCollectionEquality().hash(distance),
      const DeepCollectionEquality().hash(duration));

  @JsonKey(ignore: true)
  @override
  _$$_DirectionsLegCopyWith<_$_DirectionsLeg> get copyWith =>
      __$$_DirectionsLegCopyWithImpl<_$_DirectionsLeg>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DirectionsLegToJson(
      this,
    );
  }
}

abstract class _DirectionsLeg extends DirectionsLeg {
  factory _DirectionsLeg(
      {@JsonKey(name: 'start_address')
          required final String startAddress,
      @JsonKey(name: 'start_location')
          required final LatLngLiteral startLocation,
      @JsonKey(name: 'end_address')
          required final String endAddress,
      @JsonKey(name: 'end_location')
          required final LatLngLiteral endLocation,
      @JsonKey()
          required final List<DirectionsStep> steps,
      @JsonKey(name: 'via_waypoint')
          required final List<DirectionsViaWaypoint> viaWaypoint,
      @JsonKey()
          final TextValueObject? distance,
      @JsonKey()
          final TextValueObject? duration}) = _$_DirectionsLeg;
  _DirectionsLeg._() : super._();

  factory _DirectionsLeg.fromJson(Map<String, dynamic> json) =
      _$_DirectionsLeg.fromJson;

  @override
  @JsonKey(name: 'start_address')
  String get startAddress;
  @override
  @JsonKey(name: 'start_location')
  LatLngLiteral get startLocation;
  @override
  @JsonKey(name: 'end_address')
  String get endAddress;
  @override
  @JsonKey(name: 'end_location')
  LatLngLiteral get endLocation;
  @override
  @JsonKey()
  List<DirectionsStep> get steps;
  @override
  @JsonKey(name: 'via_waypoint')
  List<DirectionsViaWaypoint> get viaWaypoint;
  @override
  @JsonKey()
  TextValueObject? get distance;
  @override
  @JsonKey()
  TextValueObject? get duration;
  @override
  @JsonKey(ignore: true)
  _$$_DirectionsLegCopyWith<_$_DirectionsLeg> get copyWith =>
      throw _privateConstructorUsedError;
}

DirectionsStep _$DirectionsStepFromJson(Map<String, dynamic> json) {
  return _DirectionsStep.fromJson(json);
}

/// @nodoc
mixin _$DirectionsStep {
  @JsonKey(name: 'duration')
  TextValueObject get duration => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_location')
  LatLngLiteral get startLocation => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_location')
  LatLngLiteral get endLocation => throw _privateConstructorUsedError;
  @JsonKey(name: 'html_instructions')
  String get htmlInstructions => throw _privateConstructorUsedError;
  @JsonKey(name: 'polyline')
  DirectionsPolyline get polyline => throw _privateConstructorUsedError;
  @JsonKey(name: 'distance')
  TextValueObject get distance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DirectionsStepCopyWith<DirectionsStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DirectionsStepCopyWith<$Res> {
  factory $DirectionsStepCopyWith(
          DirectionsStep value, $Res Function(DirectionsStep) then) =
      _$DirectionsStepCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'duration') TextValueObject duration,
      @JsonKey(name: 'start_location') LatLngLiteral startLocation,
      @JsonKey(name: 'end_location') LatLngLiteral endLocation,
      @JsonKey(name: 'html_instructions') String htmlInstructions,
      @JsonKey(name: 'polyline') DirectionsPolyline polyline,
      @JsonKey(name: 'distance') TextValueObject distance});

  $TextValueObjectCopyWith<$Res> get duration;
  $LatLngLiteralCopyWith<$Res> get startLocation;
  $LatLngLiteralCopyWith<$Res> get endLocation;
  $DirectionsPolylineCopyWith<$Res> get polyline;
  $TextValueObjectCopyWith<$Res> get distance;
}

/// @nodoc
class _$DirectionsStepCopyWithImpl<$Res>
    implements $DirectionsStepCopyWith<$Res> {
  _$DirectionsStepCopyWithImpl(this._value, this._then);

  final DirectionsStep _value;
  // ignore: unused_field
  final $Res Function(DirectionsStep) _then;

  @override
  $Res call({
    Object? duration = freezed,
    Object? startLocation = freezed,
    Object? endLocation = freezed,
    Object? htmlInstructions = freezed,
    Object? polyline = freezed,
    Object? distance = freezed,
  }) {
    return _then(_value.copyWith(
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as TextValueObject,
      startLocation: startLocation == freezed
          ? _value.startLocation
          : startLocation // ignore: cast_nullable_to_non_nullable
              as LatLngLiteral,
      endLocation: endLocation == freezed
          ? _value.endLocation
          : endLocation // ignore: cast_nullable_to_non_nullable
              as LatLngLiteral,
      htmlInstructions: htmlInstructions == freezed
          ? _value.htmlInstructions
          : htmlInstructions // ignore: cast_nullable_to_non_nullable
              as String,
      polyline: polyline == freezed
          ? _value.polyline
          : polyline // ignore: cast_nullable_to_non_nullable
              as DirectionsPolyline,
      distance: distance == freezed
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as TextValueObject,
    ));
  }

  @override
  $TextValueObjectCopyWith<$Res> get duration {
    return $TextValueObjectCopyWith<$Res>(_value.duration, (value) {
      return _then(_value.copyWith(duration: value));
    });
  }

  @override
  $LatLngLiteralCopyWith<$Res> get startLocation {
    return $LatLngLiteralCopyWith<$Res>(_value.startLocation, (value) {
      return _then(_value.copyWith(startLocation: value));
    });
  }

  @override
  $LatLngLiteralCopyWith<$Res> get endLocation {
    return $LatLngLiteralCopyWith<$Res>(_value.endLocation, (value) {
      return _then(_value.copyWith(endLocation: value));
    });
  }

  @override
  $DirectionsPolylineCopyWith<$Res> get polyline {
    return $DirectionsPolylineCopyWith<$Res>(_value.polyline, (value) {
      return _then(_value.copyWith(polyline: value));
    });
  }

  @override
  $TextValueObjectCopyWith<$Res> get distance {
    return $TextValueObjectCopyWith<$Res>(_value.distance, (value) {
      return _then(_value.copyWith(distance: value));
    });
  }
}

/// @nodoc
abstract class _$$_DirectionsStepCopyWith<$Res>
    implements $DirectionsStepCopyWith<$Res> {
  factory _$$_DirectionsStepCopyWith(
          _$_DirectionsStep value, $Res Function(_$_DirectionsStep) then) =
      __$$_DirectionsStepCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'duration') TextValueObject duration,
      @JsonKey(name: 'start_location') LatLngLiteral startLocation,
      @JsonKey(name: 'end_location') LatLngLiteral endLocation,
      @JsonKey(name: 'html_instructions') String htmlInstructions,
      @JsonKey(name: 'polyline') DirectionsPolyline polyline,
      @JsonKey(name: 'distance') TextValueObject distance});

  @override
  $TextValueObjectCopyWith<$Res> get duration;
  @override
  $LatLngLiteralCopyWith<$Res> get startLocation;
  @override
  $LatLngLiteralCopyWith<$Res> get endLocation;
  @override
  $DirectionsPolylineCopyWith<$Res> get polyline;
  @override
  $TextValueObjectCopyWith<$Res> get distance;
}

/// @nodoc
class __$$_DirectionsStepCopyWithImpl<$Res>
    extends _$DirectionsStepCopyWithImpl<$Res>
    implements _$$_DirectionsStepCopyWith<$Res> {
  __$$_DirectionsStepCopyWithImpl(
      _$_DirectionsStep _value, $Res Function(_$_DirectionsStep) _then)
      : super(_value, (v) => _then(v as _$_DirectionsStep));

  @override
  _$_DirectionsStep get _value => super._value as _$_DirectionsStep;

  @override
  $Res call({
    Object? duration = freezed,
    Object? startLocation = freezed,
    Object? endLocation = freezed,
    Object? htmlInstructions = freezed,
    Object? polyline = freezed,
    Object? distance = freezed,
  }) {
    return _then(_$_DirectionsStep(
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as TextValueObject,
      startLocation: startLocation == freezed
          ? _value.startLocation
          : startLocation // ignore: cast_nullable_to_non_nullable
              as LatLngLiteral,
      endLocation: endLocation == freezed
          ? _value.endLocation
          : endLocation // ignore: cast_nullable_to_non_nullable
              as LatLngLiteral,
      htmlInstructions: htmlInstructions == freezed
          ? _value.htmlInstructions
          : htmlInstructions // ignore: cast_nullable_to_non_nullable
              as String,
      polyline: polyline == freezed
          ? _value.polyline
          : polyline // ignore: cast_nullable_to_non_nullable
              as DirectionsPolyline,
      distance: distance == freezed
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as TextValueObject,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, ignoreUnannotated: true)
class _$_DirectionsStep extends _DirectionsStep {
  _$_DirectionsStep(
      {@JsonKey(name: 'duration') required this.duration,
      @JsonKey(name: 'start_location') required this.startLocation,
      @JsonKey(name: 'end_location') required this.endLocation,
      @JsonKey(name: 'html_instructions') required this.htmlInstructions,
      @JsonKey(name: 'polyline') required this.polyline,
      @JsonKey(name: 'distance') required this.distance})
      : super._();

  factory _$_DirectionsStep.fromJson(Map<String, dynamic> json) =>
      _$$_DirectionsStepFromJson(json);

  @override
  @JsonKey(name: 'duration')
  final TextValueObject duration;
  @override
  @JsonKey(name: 'start_location')
  final LatLngLiteral startLocation;
  @override
  @JsonKey(name: 'end_location')
  final LatLngLiteral endLocation;
  @override
  @JsonKey(name: 'html_instructions')
  final String htmlInstructions;
  @override
  @JsonKey(name: 'polyline')
  final DirectionsPolyline polyline;
  @override
  @JsonKey(name: 'distance')
  final TextValueObject distance;

  @override
  String toString() {
    return 'DirectionsStep(duration: $duration, startLocation: $startLocation, endLocation: $endLocation, htmlInstructions: $htmlInstructions, polyline: $polyline, distance: $distance)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DirectionsStep &&
            const DeepCollectionEquality().equals(other.duration, duration) &&
            const DeepCollectionEquality()
                .equals(other.startLocation, startLocation) &&
            const DeepCollectionEquality()
                .equals(other.endLocation, endLocation) &&
            const DeepCollectionEquality()
                .equals(other.htmlInstructions, htmlInstructions) &&
            const DeepCollectionEquality().equals(other.polyline, polyline) &&
            const DeepCollectionEquality().equals(other.distance, distance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(duration),
      const DeepCollectionEquality().hash(startLocation),
      const DeepCollectionEquality().hash(endLocation),
      const DeepCollectionEquality().hash(htmlInstructions),
      const DeepCollectionEquality().hash(polyline),
      const DeepCollectionEquality().hash(distance));

  @JsonKey(ignore: true)
  @override
  _$$_DirectionsStepCopyWith<_$_DirectionsStep> get copyWith =>
      __$$_DirectionsStepCopyWithImpl<_$_DirectionsStep>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DirectionsStepToJson(
      this,
    );
  }
}

abstract class _DirectionsStep extends DirectionsStep {
  factory _DirectionsStep(
      {@JsonKey(name: 'duration')
          required final TextValueObject duration,
      @JsonKey(name: 'start_location')
          required final LatLngLiteral startLocation,
      @JsonKey(name: 'end_location')
          required final LatLngLiteral endLocation,
      @JsonKey(name: 'html_instructions')
          required final String htmlInstructions,
      @JsonKey(name: 'polyline')
          required final DirectionsPolyline polyline,
      @JsonKey(name: 'distance')
          required final TextValueObject distance}) = _$_DirectionsStep;
  _DirectionsStep._() : super._();

  factory _DirectionsStep.fromJson(Map<String, dynamic> json) =
      _$_DirectionsStep.fromJson;

  @override
  @JsonKey(name: 'duration')
  TextValueObject get duration;
  @override
  @JsonKey(name: 'start_location')
  LatLngLiteral get startLocation;
  @override
  @JsonKey(name: 'end_location')
  LatLngLiteral get endLocation;
  @override
  @JsonKey(name: 'html_instructions')
  String get htmlInstructions;
  @override
  @JsonKey(name: 'polyline')
  DirectionsPolyline get polyline;
  @override
  @JsonKey(name: 'distance')
  TextValueObject get distance;
  @override
  @JsonKey(ignore: true)
  _$$_DirectionsStepCopyWith<_$_DirectionsStep> get copyWith =>
      throw _privateConstructorUsedError;
}

TextValueObject _$TextValueObjectFromJson(Map<String, dynamic> json) {
  return _TextValueObject.fromJson(json);
}

/// @nodoc
mixin _$TextValueObject {
  String get text => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TextValueObjectCopyWith<TextValueObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TextValueObjectCopyWith<$Res> {
  factory $TextValueObjectCopyWith(
          TextValueObject value, $Res Function(TextValueObject) then) =
      _$TextValueObjectCopyWithImpl<$Res>;
  $Res call({String text, double value});
}

/// @nodoc
class _$TextValueObjectCopyWithImpl<$Res>
    implements $TextValueObjectCopyWith<$Res> {
  _$TextValueObjectCopyWithImpl(this._value, this._then);

  final TextValueObject _value;
  // ignore: unused_field
  final $Res Function(TextValueObject) _then;

  @override
  $Res call({
    Object? text = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$$_TextValueObjectCopyWith<$Res>
    implements $TextValueObjectCopyWith<$Res> {
  factory _$$_TextValueObjectCopyWith(
          _$_TextValueObject value, $Res Function(_$_TextValueObject) then) =
      __$$_TextValueObjectCopyWithImpl<$Res>;
  @override
  $Res call({String text, double value});
}

/// @nodoc
class __$$_TextValueObjectCopyWithImpl<$Res>
    extends _$TextValueObjectCopyWithImpl<$Res>
    implements _$$_TextValueObjectCopyWith<$Res> {
  __$$_TextValueObjectCopyWithImpl(
      _$_TextValueObject _value, $Res Function(_$_TextValueObject) _then)
      : super(_value, (v) => _then(v as _$_TextValueObject));

  @override
  _$_TextValueObject get _value => super._value as _$_TextValueObject;

  @override
  $Res call({
    Object? text = freezed,
    Object? value = freezed,
  }) {
    return _then(_$_TextValueObject(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TextValueObject extends _TextValueObject {
  _$_TextValueObject({required this.text, required this.value}) : super._();

  factory _$_TextValueObject.fromJson(Map<String, dynamic> json) =>
      _$$_TextValueObjectFromJson(json);

  @override
  final String text;
  @override
  final double value;

  @override
  String toString() {
    return 'TextValueObject(text: $text, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TextValueObject &&
            const DeepCollectionEquality().equals(other.text, text) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(text),
      const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  _$$_TextValueObjectCopyWith<_$_TextValueObject> get copyWith =>
      __$$_TextValueObjectCopyWithImpl<_$_TextValueObject>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TextValueObjectToJson(
      this,
    );
  }
}

abstract class _TextValueObject extends TextValueObject {
  factory _TextValueObject(
      {required final String text,
      required final double value}) = _$_TextValueObject;
  _TextValueObject._() : super._();

  factory _TextValueObject.fromJson(Map<String, dynamic> json) =
      _$_TextValueObject.fromJson;

  @override
  String get text;
  @override
  double get value;
  @override
  @JsonKey(ignore: true)
  _$$_TextValueObjectCopyWith<_$_TextValueObject> get copyWith =>
      throw _privateConstructorUsedError;
}

DirectionsPolyline _$DirectionsPolylineFromJson(Map<String, dynamic> json) {
  return _DirectionsPolyline.fromJson(json);
}

/// @nodoc
mixin _$DirectionsPolyline {
  String get points => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DirectionsPolylineCopyWith<DirectionsPolyline> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DirectionsPolylineCopyWith<$Res> {
  factory $DirectionsPolylineCopyWith(
          DirectionsPolyline value, $Res Function(DirectionsPolyline) then) =
      _$DirectionsPolylineCopyWithImpl<$Res>;
  $Res call({String points});
}

/// @nodoc
class _$DirectionsPolylineCopyWithImpl<$Res>
    implements $DirectionsPolylineCopyWith<$Res> {
  _$DirectionsPolylineCopyWithImpl(this._value, this._then);

  final DirectionsPolyline _value;
  // ignore: unused_field
  final $Res Function(DirectionsPolyline) _then;

  @override
  $Res call({
    Object? points = freezed,
  }) {
    return _then(_value.copyWith(
      points: points == freezed
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_DirectionsPolylineCopyWith<$Res>
    implements $DirectionsPolylineCopyWith<$Res> {
  factory _$$_DirectionsPolylineCopyWith(_$_DirectionsPolyline value,
          $Res Function(_$_DirectionsPolyline) then) =
      __$$_DirectionsPolylineCopyWithImpl<$Res>;
  @override
  $Res call({String points});
}

/// @nodoc
class __$$_DirectionsPolylineCopyWithImpl<$Res>
    extends _$DirectionsPolylineCopyWithImpl<$Res>
    implements _$$_DirectionsPolylineCopyWith<$Res> {
  __$$_DirectionsPolylineCopyWithImpl(
      _$_DirectionsPolyline _value, $Res Function(_$_DirectionsPolyline) _then)
      : super(_value, (v) => _then(v as _$_DirectionsPolyline));

  @override
  _$_DirectionsPolyline get _value => super._value as _$_DirectionsPolyline;

  @override
  $Res call({
    Object? points = freezed,
  }) {
    return _then(_$_DirectionsPolyline(
      points: points == freezed
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DirectionsPolyline extends _DirectionsPolyline {
  _$_DirectionsPolyline({required this.points}) : super._();

  factory _$_DirectionsPolyline.fromJson(Map<String, dynamic> json) =>
      _$$_DirectionsPolylineFromJson(json);

  @override
  final String points;

  @override
  String toString() {
    return 'DirectionsPolyline(points: $points)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DirectionsPolyline &&
            const DeepCollectionEquality().equals(other.points, points));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(points));

  @JsonKey(ignore: true)
  @override
  _$$_DirectionsPolylineCopyWith<_$_DirectionsPolyline> get copyWith =>
      __$$_DirectionsPolylineCopyWithImpl<_$_DirectionsPolyline>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DirectionsPolylineToJson(
      this,
    );
  }
}

abstract class _DirectionsPolyline extends DirectionsPolyline {
  factory _DirectionsPolyline({required final String points}) =
      _$_DirectionsPolyline;
  _DirectionsPolyline._() : super._();

  factory _DirectionsPolyline.fromJson(Map<String, dynamic> json) =
      _$_DirectionsPolyline.fromJson;

  @override
  String get points;
  @override
  @JsonKey(ignore: true)
  _$$_DirectionsPolylineCopyWith<_$_DirectionsPolyline> get copyWith =>
      throw _privateConstructorUsedError;
}

DirectionsTransitStop _$DirectionsTransitStopFromJson(
    Map<String, dynamic> json) {
  return _DirectionsTransitStop.fromJson(json);
}

/// @nodoc
mixin _$DirectionsTransitStop {
  LatLngLiteral get location => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DirectionsTransitStopCopyWith<DirectionsTransitStop> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DirectionsTransitStopCopyWith<$Res> {
  factory $DirectionsTransitStopCopyWith(DirectionsTransitStop value,
          $Res Function(DirectionsTransitStop) then) =
      _$DirectionsTransitStopCopyWithImpl<$Res>;
  $Res call({LatLngLiteral location, String name});

  $LatLngLiteralCopyWith<$Res> get location;
}

/// @nodoc
class _$DirectionsTransitStopCopyWithImpl<$Res>
    implements $DirectionsTransitStopCopyWith<$Res> {
  _$DirectionsTransitStopCopyWithImpl(this._value, this._then);

  final DirectionsTransitStop _value;
  // ignore: unused_field
  final $Res Function(DirectionsTransitStop) _then;

  @override
  $Res call({
    Object? location = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LatLngLiteral,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $LatLngLiteralCopyWith<$Res> get location {
    return $LatLngLiteralCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value));
    });
  }
}

/// @nodoc
abstract class _$$_DirectionsTransitStopCopyWith<$Res>
    implements $DirectionsTransitStopCopyWith<$Res> {
  factory _$$_DirectionsTransitStopCopyWith(_$_DirectionsTransitStop value,
          $Res Function(_$_DirectionsTransitStop) then) =
      __$$_DirectionsTransitStopCopyWithImpl<$Res>;
  @override
  $Res call({LatLngLiteral location, String name});

  @override
  $LatLngLiteralCopyWith<$Res> get location;
}

/// @nodoc
class __$$_DirectionsTransitStopCopyWithImpl<$Res>
    extends _$DirectionsTransitStopCopyWithImpl<$Res>
    implements _$$_DirectionsTransitStopCopyWith<$Res> {
  __$$_DirectionsTransitStopCopyWithImpl(_$_DirectionsTransitStop _value,
      $Res Function(_$_DirectionsTransitStop) _then)
      : super(_value, (v) => _then(v as _$_DirectionsTransitStop));

  @override
  _$_DirectionsTransitStop get _value =>
      super._value as _$_DirectionsTransitStop;

  @override
  $Res call({
    Object? location = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_DirectionsTransitStop(
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LatLngLiteral,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DirectionsTransitStop extends _DirectionsTransitStop {
  _$_DirectionsTransitStop({required this.location, required this.name})
      : super._();

  factory _$_DirectionsTransitStop.fromJson(Map<String, dynamic> json) =>
      _$$_DirectionsTransitStopFromJson(json);

  @override
  final LatLngLiteral location;
  @override
  final String name;

  @override
  String toString() {
    return 'DirectionsTransitStop(location: $location, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DirectionsTransitStop &&
            const DeepCollectionEquality().equals(other.location, location) &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(location),
      const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  _$$_DirectionsTransitStopCopyWith<_$_DirectionsTransitStop> get copyWith =>
      __$$_DirectionsTransitStopCopyWithImpl<_$_DirectionsTransitStop>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DirectionsTransitStopToJson(
      this,
    );
  }
}

abstract class _DirectionsTransitStop extends DirectionsTransitStop {
  factory _DirectionsTransitStop(
      {required final LatLngLiteral location,
      required final String name}) = _$_DirectionsTransitStop;
  _DirectionsTransitStop._() : super._();

  factory _DirectionsTransitStop.fromJson(Map<String, dynamic> json) =
      _$_DirectionsTransitStop.fromJson;

  @override
  LatLngLiteral get location;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_DirectionsTransitStopCopyWith<_$_DirectionsTransitStop> get copyWith =>
      throw _privateConstructorUsedError;
}

DirectionsViaWaypoint _$DirectionsViaWaypointFromJson(
    Map<String, dynamic> json) {
  return _DirectionsViaWaypoint.fromJson(json);
}

/// @nodoc
mixin _$DirectionsViaWaypoint {
  LatLngLiteral? get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'step_index')
  int? get stepIndex => throw _privateConstructorUsedError;
  @JsonKey(name: 'step_interpolation')
  double? get stepInterpolation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DirectionsViaWaypointCopyWith<DirectionsViaWaypoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DirectionsViaWaypointCopyWith<$Res> {
  factory $DirectionsViaWaypointCopyWith(DirectionsViaWaypoint value,
          $Res Function(DirectionsViaWaypoint) then) =
      _$DirectionsViaWaypointCopyWithImpl<$Res>;
  $Res call(
      {LatLngLiteral? location,
      @JsonKey(name: 'step_index') int? stepIndex,
      @JsonKey(name: 'step_interpolation') double? stepInterpolation});

  $LatLngLiteralCopyWith<$Res>? get location;
}

/// @nodoc
class _$DirectionsViaWaypointCopyWithImpl<$Res>
    implements $DirectionsViaWaypointCopyWith<$Res> {
  _$DirectionsViaWaypointCopyWithImpl(this._value, this._then);

  final DirectionsViaWaypoint _value;
  // ignore: unused_field
  final $Res Function(DirectionsViaWaypoint) _then;

  @override
  $Res call({
    Object? location = freezed,
    Object? stepIndex = freezed,
    Object? stepInterpolation = freezed,
  }) {
    return _then(_value.copyWith(
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LatLngLiteral?,
      stepIndex: stepIndex == freezed
          ? _value.stepIndex
          : stepIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      stepInterpolation: stepInterpolation == freezed
          ? _value.stepInterpolation
          : stepInterpolation // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }

  @override
  $LatLngLiteralCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $LatLngLiteralCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value));
    });
  }
}

/// @nodoc
abstract class _$$_DirectionsViaWaypointCopyWith<$Res>
    implements $DirectionsViaWaypointCopyWith<$Res> {
  factory _$$_DirectionsViaWaypointCopyWith(_$_DirectionsViaWaypoint value,
          $Res Function(_$_DirectionsViaWaypoint) then) =
      __$$_DirectionsViaWaypointCopyWithImpl<$Res>;
  @override
  $Res call(
      {LatLngLiteral? location,
      @JsonKey(name: 'step_index') int? stepIndex,
      @JsonKey(name: 'step_interpolation') double? stepInterpolation});

  @override
  $LatLngLiteralCopyWith<$Res>? get location;
}

/// @nodoc
class __$$_DirectionsViaWaypointCopyWithImpl<$Res>
    extends _$DirectionsViaWaypointCopyWithImpl<$Res>
    implements _$$_DirectionsViaWaypointCopyWith<$Res> {
  __$$_DirectionsViaWaypointCopyWithImpl(_$_DirectionsViaWaypoint _value,
      $Res Function(_$_DirectionsViaWaypoint) _then)
      : super(_value, (v) => _then(v as _$_DirectionsViaWaypoint));

  @override
  _$_DirectionsViaWaypoint get _value =>
      super._value as _$_DirectionsViaWaypoint;

  @override
  $Res call({
    Object? location = freezed,
    Object? stepIndex = freezed,
    Object? stepInterpolation = freezed,
  }) {
    return _then(_$_DirectionsViaWaypoint(
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LatLngLiteral?,
      stepIndex: stepIndex == freezed
          ? _value.stepIndex
          : stepIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      stepInterpolation: stepInterpolation == freezed
          ? _value.stepInterpolation
          : stepInterpolation // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DirectionsViaWaypoint extends _DirectionsViaWaypoint {
  _$_DirectionsViaWaypoint(
      {this.location,
      @JsonKey(name: 'step_index') this.stepIndex,
      @JsonKey(name: 'step_interpolation') this.stepInterpolation})
      : super._();

  factory _$_DirectionsViaWaypoint.fromJson(Map<String, dynamic> json) =>
      _$$_DirectionsViaWaypointFromJson(json);

  @override
  final LatLngLiteral? location;
  @override
  @JsonKey(name: 'step_index')
  final int? stepIndex;
  @override
  @JsonKey(name: 'step_interpolation')
  final double? stepInterpolation;

  @override
  String toString() {
    return 'DirectionsViaWaypoint(location: $location, stepIndex: $stepIndex, stepInterpolation: $stepInterpolation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DirectionsViaWaypoint &&
            const DeepCollectionEquality().equals(other.location, location) &&
            const DeepCollectionEquality().equals(other.stepIndex, stepIndex) &&
            const DeepCollectionEquality()
                .equals(other.stepInterpolation, stepInterpolation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(location),
      const DeepCollectionEquality().hash(stepIndex),
      const DeepCollectionEquality().hash(stepInterpolation));

  @JsonKey(ignore: true)
  @override
  _$$_DirectionsViaWaypointCopyWith<_$_DirectionsViaWaypoint> get copyWith =>
      __$$_DirectionsViaWaypointCopyWithImpl<_$_DirectionsViaWaypoint>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DirectionsViaWaypointToJson(
      this,
    );
  }
}

abstract class _DirectionsViaWaypoint extends DirectionsViaWaypoint {
  factory _DirectionsViaWaypoint(
      {final LatLngLiteral? location,
      @JsonKey(name: 'step_index')
          final int? stepIndex,
      @JsonKey(name: 'step_interpolation')
          final double? stepInterpolation}) = _$_DirectionsViaWaypoint;
  _DirectionsViaWaypoint._() : super._();

  factory _DirectionsViaWaypoint.fromJson(Map<String, dynamic> json) =
      _$_DirectionsViaWaypoint.fromJson;

  @override
  LatLngLiteral? get location;
  @override
  @JsonKey(name: 'step_index')
  int? get stepIndex;
  @override
  @JsonKey(name: 'step_interpolation')
  double? get stepInterpolation;
  @override
  @JsonKey(ignore: true)
  _$$_DirectionsViaWaypointCopyWith<_$_DirectionsViaWaypoint> get copyWith =>
      throw _privateConstructorUsedError;
}
