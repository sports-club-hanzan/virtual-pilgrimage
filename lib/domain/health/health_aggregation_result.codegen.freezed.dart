// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'health_aggregation_result.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HealthAggregationResult {
  Map<DateTime, HealthByPeriod> get eachDay =>
      throw _privateConstructorUsedError;
  HealthByPeriod get total => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HealthAggregationResultCopyWith<HealthAggregationResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthAggregationResultCopyWith<$Res> {
  factory $HealthAggregationResultCopyWith(HealthAggregationResult value,
          $Res Function(HealthAggregationResult) then) =
      _$HealthAggregationResultCopyWithImpl<$Res, HealthAggregationResult>;
  @useResult
  $Res call({Map<DateTime, HealthByPeriod> eachDay, HealthByPeriod total});

  $HealthByPeriodCopyWith<$Res> get total;
}

/// @nodoc
class _$HealthAggregationResultCopyWithImpl<$Res,
        $Val extends HealthAggregationResult>
    implements $HealthAggregationResultCopyWith<$Res> {
  _$HealthAggregationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eachDay = null,
    Object? total = null,
  }) {
    return _then(_value.copyWith(
      eachDay: null == eachDay
          ? _value.eachDay
          : eachDay // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, HealthByPeriod>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as HealthByPeriod,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $HealthByPeriodCopyWith<$Res> get total {
    return $HealthByPeriodCopyWith<$Res>(_value.total, (value) {
      return _then(_value.copyWith(total: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_HealthAggregationResultCopyWith<$Res>
    implements $HealthAggregationResultCopyWith<$Res> {
  factory _$$_HealthAggregationResultCopyWith(_$_HealthAggregationResult value,
          $Res Function(_$_HealthAggregationResult) then) =
      __$$_HealthAggregationResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<DateTime, HealthByPeriod> eachDay, HealthByPeriod total});

  @override
  $HealthByPeriodCopyWith<$Res> get total;
}

/// @nodoc
class __$$_HealthAggregationResultCopyWithImpl<$Res>
    extends _$HealthAggregationResultCopyWithImpl<$Res,
        _$_HealthAggregationResult>
    implements _$$_HealthAggregationResultCopyWith<$Res> {
  __$$_HealthAggregationResultCopyWithImpl(_$_HealthAggregationResult _value,
      $Res Function(_$_HealthAggregationResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eachDay = null,
    Object? total = null,
  }) {
    return _then(_$_HealthAggregationResult(
      eachDay: null == eachDay
          ? _value._eachDay
          : eachDay // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, HealthByPeriod>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as HealthByPeriod,
    ));
  }
}

/// @nodoc

class _$_HealthAggregationResult extends _HealthAggregationResult {
  const _$_HealthAggregationResult(
      {required final Map<DateTime, HealthByPeriod> eachDay,
      required this.total})
      : _eachDay = eachDay,
        super._();

  final Map<DateTime, HealthByPeriod> _eachDay;
  @override
  Map<DateTime, HealthByPeriod> get eachDay {
    if (_eachDay is EqualUnmodifiableMapView) return _eachDay;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_eachDay);
  }

  @override
  final HealthByPeriod total;

  @override
  String toString() {
    return 'HealthAggregationResult(eachDay: $eachDay, total: $total)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HealthAggregationResult &&
            const DeepCollectionEquality().equals(other._eachDay, _eachDay) &&
            (identical(other.total, total) || other.total == total));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_eachDay), total);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HealthAggregationResultCopyWith<_$_HealthAggregationResult>
      get copyWith =>
          __$$_HealthAggregationResultCopyWithImpl<_$_HealthAggregationResult>(
              this, _$identity);
}

abstract class _HealthAggregationResult extends HealthAggregationResult {
  const factory _HealthAggregationResult(
      {required final Map<DateTime, HealthByPeriod> eachDay,
      required final HealthByPeriod total}) = _$_HealthAggregationResult;
  const _HealthAggregationResult._() : super._();

  @override
  Map<DateTime, HealthByPeriod> get eachDay;
  @override
  HealthByPeriod get total;
  @override
  @JsonKey(ignore: true)
  _$$_HealthAggregationResultCopyWith<_$_HealthAggregationResult>
      get copyWith => throw _privateConstructorUsedError;
}
