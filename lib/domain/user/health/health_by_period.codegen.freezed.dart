// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'health_by_period.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

HealthByPeriod _$HealthByPeriodFromJson(Map<String, dynamic> json) {
  return _HealthByPeriod.fromJson(json);
}

/// @nodoc
mixin _$HealthByPeriod {
// 歩数
  int get steps => throw _privateConstructorUsedError; // 距離[m]
  int get distance => throw _privateConstructorUsedError; // 消費カロリー[kcal]
  int get burnedCalorie => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HealthByPeriodCopyWith<HealthByPeriod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthByPeriodCopyWith<$Res> {
  factory $HealthByPeriodCopyWith(
          HealthByPeriod value, $Res Function(HealthByPeriod) then) =
      _$HealthByPeriodCopyWithImpl<$Res, HealthByPeriod>;
  @useResult
  $Res call({int steps, int distance, int burnedCalorie});
}

/// @nodoc
class _$HealthByPeriodCopyWithImpl<$Res, $Val extends HealthByPeriod>
    implements $HealthByPeriodCopyWith<$Res> {
  _$HealthByPeriodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? steps = null,
    Object? distance = null,
    Object? burnedCalorie = null,
  }) {
    return _then(_value.copyWith(
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as int,
      burnedCalorie: null == burnedCalorie
          ? _value.burnedCalorie
          : burnedCalorie // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HealthByPeriodCopyWith<$Res>
    implements $HealthByPeriodCopyWith<$Res> {
  factory _$$_HealthByPeriodCopyWith(
          _$_HealthByPeriod value, $Res Function(_$_HealthByPeriod) then) =
      __$$_HealthByPeriodCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int steps, int distance, int burnedCalorie});
}

/// @nodoc
class __$$_HealthByPeriodCopyWithImpl<$Res>
    extends _$HealthByPeriodCopyWithImpl<$Res, _$_HealthByPeriod>
    implements _$$_HealthByPeriodCopyWith<$Res> {
  __$$_HealthByPeriodCopyWithImpl(
      _$_HealthByPeriod _value, $Res Function(_$_HealthByPeriod) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? steps = null,
    Object? distance = null,
    Object? burnedCalorie = null,
  }) {
    return _then(_$_HealthByPeriod(
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as int,
      burnedCalorie: null == burnedCalorie
          ? _value.burnedCalorie
          : burnedCalorie // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_HealthByPeriod extends _HealthByPeriod {
  const _$_HealthByPeriod(
      {required this.steps,
      required this.distance,
      required this.burnedCalorie})
      : super._();

  factory _$_HealthByPeriod.fromJson(Map<String, dynamic> json) =>
      _$$_HealthByPeriodFromJson(json);

// 歩数
  @override
  final int steps;
// 距離[m]
  @override
  final int distance;
// 消費カロリー[kcal]
  @override
  final int burnedCalorie;

  @override
  String toString() {
    return 'HealthByPeriod(steps: $steps, distance: $distance, burnedCalorie: $burnedCalorie)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HealthByPeriod &&
            (identical(other.steps, steps) || other.steps == steps) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.burnedCalorie, burnedCalorie) ||
                other.burnedCalorie == burnedCalorie));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, steps, distance, burnedCalorie);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HealthByPeriodCopyWith<_$_HealthByPeriod> get copyWith =>
      __$$_HealthByPeriodCopyWithImpl<_$_HealthByPeriod>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HealthByPeriodToJson(
      this,
    );
  }
}

abstract class _HealthByPeriod extends HealthByPeriod {
  const factory _HealthByPeriod(
      {required final int steps,
      required final int distance,
      required final int burnedCalorie}) = _$_HealthByPeriod;
  const _HealthByPeriod._() : super._();

  factory _HealthByPeriod.fromJson(Map<String, dynamic> json) =
      _$_HealthByPeriod.fromJson;

  @override // 歩数
  int get steps;
  @override // 距離[m]
  int get distance;
  @override // 消費カロリー[kcal]
  int get burnedCalorie;
  @override
  @JsonKey(ignore: true)
  _$$_HealthByPeriodCopyWith<_$_HealthByPeriod> get copyWith =>
      throw _privateConstructorUsedError;
}
