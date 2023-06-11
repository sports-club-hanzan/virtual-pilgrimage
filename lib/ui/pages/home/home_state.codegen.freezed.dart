// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
  int get animationTempleId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call(
      {GoogleMapModel googleMap,
      CameraPosition initialCameraPosition,
      Set<Marker> markers,
      Set<Polyline> polylines,
      int animationTempleId});

  $GoogleMapModelCopyWith<$Res> get googleMap;
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? googleMap = null,
    Object? initialCameraPosition = null,
    Object? markers = null,
    Object? polylines = null,
    Object? animationTempleId = null,
  }) {
    return _then(_value.copyWith(
      googleMap: null == googleMap
          ? _value.googleMap
          : googleMap // ignore: cast_nullable_to_non_nullable
              as GoogleMapModel,
      initialCameraPosition: null == initialCameraPosition
          ? _value.initialCameraPosition
          : initialCameraPosition // ignore: cast_nullable_to_non_nullable
              as CameraPosition,
      markers: null == markers
          ? _value.markers
          : markers // ignore: cast_nullable_to_non_nullable
              as Set<Marker>,
      polylines: null == polylines
          ? _value.polylines
          : polylines // ignore: cast_nullable_to_non_nullable
              as Set<Polyline>,
      animationTempleId: null == animationTempleId
          ? _value.animationTempleId
          : animationTempleId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GoogleMapModelCopyWith<$Res> get googleMap {
    return $GoogleMapModelCopyWith<$Res>(_value.googleMap, (value) {
      return _then(_value.copyWith(googleMap: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$$_HomeStateCopyWith(
          _$_HomeState value, $Res Function(_$_HomeState) then) =
      __$$_HomeStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {GoogleMapModel googleMap,
      CameraPosition initialCameraPosition,
      Set<Marker> markers,
      Set<Polyline> polylines,
      int animationTempleId});

  @override
  $GoogleMapModelCopyWith<$Res> get googleMap;
}

/// @nodoc
class __$$_HomeStateCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$_HomeState>
    implements _$$_HomeStateCopyWith<$Res> {
  __$$_HomeStateCopyWithImpl(
      _$_HomeState _value, $Res Function(_$_HomeState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? googleMap = null,
    Object? initialCameraPosition = null,
    Object? markers = null,
    Object? polylines = null,
    Object? animationTempleId = null,
  }) {
    return _then(_$_HomeState(
      googleMap: null == googleMap
          ? _value.googleMap
          : googleMap // ignore: cast_nullable_to_non_nullable
              as GoogleMapModel,
      initialCameraPosition: null == initialCameraPosition
          ? _value.initialCameraPosition
          : initialCameraPosition // ignore: cast_nullable_to_non_nullable
              as CameraPosition,
      markers: null == markers
          ? _value._markers
          : markers // ignore: cast_nullable_to_non_nullable
              as Set<Marker>,
      polylines: null == polylines
          ? _value._polylines
          : polylines // ignore: cast_nullable_to_non_nullable
              as Set<Polyline>,
      animationTempleId: null == animationTempleId
          ? _value.animationTempleId
          : animationTempleId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_HomeState extends _HomeState {
  const _$_HomeState(
      {required this.googleMap,
      required this.initialCameraPosition,
      final Set<Marker> markers = const {},
      final Set<Polyline> polylines = const {},
      this.animationTempleId = 0})
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
    if (_markers is EqualUnmodifiableSetView) return _markers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_markers);
  }

  final Set<Polyline> _polylines;
  @override
  @JsonKey()
  Set<Polyline> get polylines {
    if (_polylines is EqualUnmodifiableSetView) return _polylines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_polylines);
  }

  @override
  @JsonKey()
  final int animationTempleId;

  @override
  String toString() {
    return 'HomeState(googleMap: $googleMap, initialCameraPosition: $initialCameraPosition, markers: $markers, polylines: $polylines, animationTempleId: $animationTempleId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HomeState &&
            (identical(other.googleMap, googleMap) ||
                other.googleMap == googleMap) &&
            (identical(other.initialCameraPosition, initialCameraPosition) ||
                other.initialCameraPosition == initialCameraPosition) &&
            const DeepCollectionEquality().equals(other._markers, _markers) &&
            const DeepCollectionEquality()
                .equals(other._polylines, _polylines) &&
            (identical(other.animationTempleId, animationTempleId) ||
                other.animationTempleId == animationTempleId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      googleMap,
      initialCameraPosition,
      const DeepCollectionEquality().hash(_markers),
      const DeepCollectionEquality().hash(_polylines),
      animationTempleId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HomeStateCopyWith<_$_HomeState> get copyWith =>
      __$$_HomeStateCopyWithImpl<_$_HomeState>(this, _$identity);
}

abstract class _HomeState extends HomeState {
  const factory _HomeState(
      {required final GoogleMapModel googleMap,
      required final CameraPosition initialCameraPosition,
      final Set<Marker> markers,
      final Set<Polyline> polylines,
      final int animationTempleId}) = _$_HomeState;
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
  int get animationTempleId;
  @override
  @JsonKey(ignore: true)
  _$$_HomeStateCopyWith<_$_HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}
