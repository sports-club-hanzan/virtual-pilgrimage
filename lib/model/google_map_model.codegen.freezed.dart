// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'google_map_model.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GoogleMapModel {
  Completer<GoogleMapController> get controller =>
      throw _privateConstructorUsedError;
  Set<Marker> get markers => throw _privateConstructorUsedError;
  Set<Polyline> get polylines => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GoogleMapModelCopyWith<GoogleMapModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoogleMapModelCopyWith<$Res> {
  factory $GoogleMapModelCopyWith(
          GoogleMapModel value, $Res Function(GoogleMapModel) then) =
      _$GoogleMapModelCopyWithImpl<$Res>;
  $Res call(
      {Completer<GoogleMapController> controller,
      Set<Marker> markers,
      Set<Polyline> polylines});
}

/// @nodoc
class _$GoogleMapModelCopyWithImpl<$Res>
    implements $GoogleMapModelCopyWith<$Res> {
  _$GoogleMapModelCopyWithImpl(this._value, this._then);

  final GoogleMapModel _value;
  // ignore: unused_field
  final $Res Function(GoogleMapModel) _then;

  @override
  $Res call({
    Object? controller = freezed,
    Object? markers = freezed,
    Object? polylines = freezed,
  }) {
    return _then(_value.copyWith(
      controller: controller == freezed
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as Completer<GoogleMapController>,
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
}

/// @nodoc
abstract class _$$_GoogleMapModelCopyWith<$Res>
    implements $GoogleMapModelCopyWith<$Res> {
  factory _$$_GoogleMapModelCopyWith(
          _$_GoogleMapModel value, $Res Function(_$_GoogleMapModel) then) =
      __$$_GoogleMapModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {Completer<GoogleMapController> controller,
      Set<Marker> markers,
      Set<Polyline> polylines});
}

/// @nodoc
class __$$_GoogleMapModelCopyWithImpl<$Res>
    extends _$GoogleMapModelCopyWithImpl<$Res>
    implements _$$_GoogleMapModelCopyWith<$Res> {
  __$$_GoogleMapModelCopyWithImpl(
      _$_GoogleMapModel _value, $Res Function(_$_GoogleMapModel) _then)
      : super(_value, (v) => _then(v as _$_GoogleMapModel));

  @override
  _$_GoogleMapModel get _value => super._value as _$_GoogleMapModel;

  @override
  $Res call({
    Object? controller = freezed,
    Object? markers = freezed,
    Object? polylines = freezed,
  }) {
    return _then(_$_GoogleMapModel(
      controller: controller == freezed
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as Completer<GoogleMapController>,
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

class _$_GoogleMapModel extends _GoogleMapModel {
  _$_GoogleMapModel(
      {required this.controller,
      final Set<Marker> markers = const {},
      final Set<Polyline> polylines = const {}})
      : _markers = markers,
        _polylines = polylines,
        super._();

  @override
  final Completer<GoogleMapController> controller;
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
    return 'GoogleMapModel(controller: $controller, markers: $markers, polylines: $polylines)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GoogleMapModel &&
            const DeepCollectionEquality()
                .equals(other.controller, controller) &&
            const DeepCollectionEquality().equals(other._markers, _markers) &&
            const DeepCollectionEquality()
                .equals(other._polylines, _polylines));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(controller),
      const DeepCollectionEquality().hash(_markers),
      const DeepCollectionEquality().hash(_polylines));

  @JsonKey(ignore: true)
  @override
  _$$_GoogleMapModelCopyWith<_$_GoogleMapModel> get copyWith =>
      __$$_GoogleMapModelCopyWithImpl<_$_GoogleMapModel>(this, _$identity);
}

abstract class _GoogleMapModel extends GoogleMapModel {
  factory _GoogleMapModel(
      {required final Completer<GoogleMapController> controller,
      final Set<Marker> markers,
      final Set<Polyline> polylines}) = _$_GoogleMapModel;
  _GoogleMapModel._() : super._();

  @override
  Completer<GoogleMapController> get controller;
  @override
  Set<Marker> get markers;
  @override
  Set<Polyline> get polylines;
  @override
  @JsonKey(ignore: true)
  _$$_GoogleMapModelCopyWith<_$_GoogleMapModel> get copyWith =>
      throw _privateConstructorUsedError;
}
