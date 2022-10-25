// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'home_state.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomeState {
  GoogleMapModel get googleMap => throw _privateConstructorUsedError;
  CameraPosition get initialCameraPosition =>
      throw _privateConstructorUsedError;
  Set<Marker> get markers => throw _privateConstructorUsedError;
  Set<Polyline> get polylines => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res>;
  $Res call(
      {GoogleMapModel googleMap,
      CameraPosition initialCameraPosition,
      Set<Marker> markers,
      Set<Polyline> polylines});

  $GoogleMapModelCopyWith<$Res> get googleMap;
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res> implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  final HomeState _value;
  // ignore: unused_field
  final $Res Function(HomeState) _then;

  @override
  $Res call({
    Object? googleMap = freezed,
    Object? initialCameraPosition = freezed,
    Object? markers = freezed,
    Object? polylines = freezed,
  }) {
    return _then(_value.copyWith(
      googleMap: googleMap == freezed
          ? _value.googleMap
          : googleMap // ignore: cast_nullable_to_non_nullable
              as GoogleMapModel,
      initialCameraPosition: initialCameraPosition == freezed
          ? _value.initialCameraPosition
          : initialCameraPosition // ignore: cast_nullable_to_non_nullable
              as CameraPosition,
      markers: markers == freezed
          ? _value.markers
          : markers // ignore: cast_nullable_to_non_nullable
              as Set<Marker>,
      polylines: polylines == freezed
          ? _value.polylines
          : polylines // ignore: cast_nullable_to_non_nullable
              as Set<Polyline>,
    ));
  }

  @override
  $GoogleMapModelCopyWith<$Res> get googleMap {
    return $GoogleMapModelCopyWith<$Res>(_value.googleMap, (value) {
      return _then(_value.copyWith(googleMap: value));
    });
  }
}

/// @nodoc
abstract class _$$_HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$$_HomeStateCopyWith(
          _$_HomeState value, $Res Function(_$_HomeState) then) =
      __$$_HomeStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {GoogleMapModel googleMap,
      CameraPosition initialCameraPosition,
      Set<Marker> markers,
      Set<Polyline> polylines});

  @override
  $GoogleMapModelCopyWith<$Res> get googleMap;
}

/// @nodoc
class __$$_HomeStateCopyWithImpl<$Res> extends _$HomeStateCopyWithImpl<$Res>
    implements _$$_HomeStateCopyWith<$Res> {
  __$$_HomeStateCopyWithImpl(
      _$_HomeState _value, $Res Function(_$_HomeState) _then)
      : super(_value, (v) => _then(v as _$_HomeState));

  @override
  _$_HomeState get _value => super._value as _$_HomeState;

  @override
  $Res call({
    Object? googleMap = freezed,
    Object? initialCameraPosition = freezed,
    Object? markers = freezed,
    Object? polylines = freezed,
  }) {
    return _then(_$_HomeState(
      googleMap: googleMap == freezed
          ? _value.googleMap
          : googleMap // ignore: cast_nullable_to_non_nullable
              as GoogleMapModel,
      initialCameraPosition: initialCameraPosition == freezed
          ? _value.initialCameraPosition
          : initialCameraPosition // ignore: cast_nullable_to_non_nullable
              as CameraPosition,
      markers: markers == freezed
          ? _value._markers
          : markers // ignore: cast_nullable_to_non_nullable
              as Set<Marker>,
      polylines: polylines == freezed
          ? _value._polylines
          : polylines // ignore: cast_nullable_to_non_nullable
              as Set<Polyline>,
    ));
  }
}

/// @nodoc

class _$_HomeState extends _HomeState {
  const _$_HomeState(
      {required this.googleMap,
      required this.initialCameraPosition,
      final Set<Marker> markers = const {},
      final Set<Polyline> polylines = const {}})
      : _markers = markers,
        _polylines = polylines,
        super._();

  @override
  final GoogleMapModel googleMap;
  @override
  final CameraPosition initialCameraPosition;
  final Set<Marker> _markers;
  @override
  @JsonKey()
  Set<Marker> get markers {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_markers);
  }

  final Set<Polyline> _polylines;
  @override
  @JsonKey()
  Set<Polyline> get polylines {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_polylines);
  }

  @override
  String toString() {
    return 'HomeState(googleMap: $googleMap, initialCameraPosition: $initialCameraPosition, markers: $markers, polylines: $polylines)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HomeState &&
            const DeepCollectionEquality().equals(other.googleMap, googleMap) &&
            const DeepCollectionEquality()
                .equals(other.initialCameraPosition, initialCameraPosition) &&
            const DeepCollectionEquality().equals(other._markers, _markers) &&
            const DeepCollectionEquality()
                .equals(other._polylines, _polylines));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(googleMap),
      const DeepCollectionEquality().hash(initialCameraPosition),
      const DeepCollectionEquality().hash(_markers),
      const DeepCollectionEquality().hash(_polylines));

  @JsonKey(ignore: true)
  @override
  _$$_HomeStateCopyWith<_$_HomeState> get copyWith =>
      __$$_HomeStateCopyWithImpl<_$_HomeState>(this, _$identity);
}

abstract class _HomeState extends HomeState {
  const factory _HomeState(
      {required final GoogleMapModel googleMap,
      required final CameraPosition initialCameraPosition,
      final Set<Marker> markers,
      final Set<Polyline> polylines}) = _$_HomeState;
  const _HomeState._() : super._();

  @override
  GoogleMapModel get googleMap;
  @override
  CameraPosition get initialCameraPosition;
  @override
  Set<Marker> get markers;
  @override
  Set<Polyline> get polylines;
  @override
  @JsonKey(ignore: true)
  _$$_HomeStateCopyWith<_$_HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}
