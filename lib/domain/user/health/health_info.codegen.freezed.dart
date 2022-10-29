// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'health_info.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

HealthInfo _$HealthInfoFromJson(Map<String, dynamic> json) {
  return _HealthInfo.fromJson(json);
}

/// @nodoc
mixin _$HealthInfo {
// 当日のヘルスケア情報
  HealthByPeriod get today => throw _privateConstructorUsedError; // 昨日のヘルスケア情報
  HealthByPeriod get yesterday =>
      throw _privateConstructorUsedError; // 昨日から一週間前までのヘルスケア情報
  HealthByPeriod get week =>
      throw _privateConstructorUsedError; // 昨日から一ヶ月前までのヘルスケア情報
  HealthByPeriod get month => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: FirestoreTimestampConverter.timestampToDateTime,
      toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
  DateTime get updatedAt => throw _privateConstructorUsedError; // 総歩数
  int get totalSteps => throw _privateConstructorUsedError; // 総歩行距離[m]
  int get totalDistance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HealthInfoCopyWith<HealthInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthInfoCopyWith<$Res> {
  factory $HealthInfoCopyWith(
          HealthInfo value, $Res Function(HealthInfo) then) =
      _$HealthInfoCopyWithImpl<$Res>;
  $Res call(
      {HealthByPeriod today,
      HealthByPeriod yesterday,
      HealthByPeriod week,
      HealthByPeriod month,
      @JsonKey(fromJson: FirestoreTimestampConverter.timestampToDateTime, toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
          DateTime updatedAt,
      int totalSteps,
      int totalDistance});

  $HealthByPeriodCopyWith<$Res> get today;
  $HealthByPeriodCopyWith<$Res> get yesterday;
  $HealthByPeriodCopyWith<$Res> get week;
  $HealthByPeriodCopyWith<$Res> get month;
}

/// @nodoc
class _$HealthInfoCopyWithImpl<$Res> implements $HealthInfoCopyWith<$Res> {
  _$HealthInfoCopyWithImpl(this._value, this._then);

  final HealthInfo _value;
  // ignore: unused_field
  final $Res Function(HealthInfo) _then;

  @override
  $Res call({
    Object? today = freezed,
    Object? yesterday = freezed,
    Object? week = freezed,
    Object? month = freezed,
    Object? updatedAt = freezed,
    Object? totalSteps = freezed,
    Object? totalDistance = freezed,
  }) {
    return _then(_value.copyWith(
      today: today == freezed
          ? _value.today
          : today // ignore: cast_nullable_to_non_nullable
              as HealthByPeriod,
      yesterday: yesterday == freezed
          ? _value.yesterday
          : yesterday // ignore: cast_nullable_to_non_nullable
              as HealthByPeriod,
      week: week == freezed
          ? _value.week
          : week // ignore: cast_nullable_to_non_nullable
              as HealthByPeriod,
      month: month == freezed
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as HealthByPeriod,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalSteps: totalSteps == freezed
          ? _value.totalSteps
          : totalSteps // ignore: cast_nullable_to_non_nullable
              as int,
      totalDistance: totalDistance == freezed
          ? _value.totalDistance
          : totalDistance // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  $HealthByPeriodCopyWith<$Res> get today {
    return $HealthByPeriodCopyWith<$Res>(_value.today, (value) {
      return _then(_value.copyWith(today: value));
    });
  }

  @override
  $HealthByPeriodCopyWith<$Res> get yesterday {
    return $HealthByPeriodCopyWith<$Res>(_value.yesterday, (value) {
      return _then(_value.copyWith(yesterday: value));
    });
  }

  @override
  $HealthByPeriodCopyWith<$Res> get week {
    return $HealthByPeriodCopyWith<$Res>(_value.week, (value) {
      return _then(_value.copyWith(week: value));
    });
  }

  @override
  $HealthByPeriodCopyWith<$Res> get month {
    return $HealthByPeriodCopyWith<$Res>(_value.month, (value) {
      return _then(_value.copyWith(month: value));
    });
  }
}

/// @nodoc
abstract class _$$_HealthInfoCopyWith<$Res>
    implements $HealthInfoCopyWith<$Res> {
  factory _$$_HealthInfoCopyWith(
          _$_HealthInfo value, $Res Function(_$_HealthInfo) then) =
      __$$_HealthInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {HealthByPeriod today,
      HealthByPeriod yesterday,
      HealthByPeriod week,
      HealthByPeriod month,
      @JsonKey(fromJson: FirestoreTimestampConverter.timestampToDateTime, toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
          DateTime updatedAt,
      int totalSteps,
      int totalDistance});

  @override
  $HealthByPeriodCopyWith<$Res> get today;
  @override
  $HealthByPeriodCopyWith<$Res> get yesterday;
  @override
  $HealthByPeriodCopyWith<$Res> get week;
  @override
  $HealthByPeriodCopyWith<$Res> get month;
}

/// @nodoc
class __$$_HealthInfoCopyWithImpl<$Res> extends _$HealthInfoCopyWithImpl<$Res>
    implements _$$_HealthInfoCopyWith<$Res> {
  __$$_HealthInfoCopyWithImpl(
      _$_HealthInfo _value, $Res Function(_$_HealthInfo) _then)
      : super(_value, (v) => _then(v as _$_HealthInfo));

  @override
  _$_HealthInfo get _value => super._value as _$_HealthInfo;

  @override
  $Res call({
    Object? today = freezed,
    Object? yesterday = freezed,
    Object? week = freezed,
    Object? month = freezed,
    Object? updatedAt = freezed,
    Object? totalSteps = freezed,
    Object? totalDistance = freezed,
  }) {
    return _then(_$_HealthInfo(
      today: today == freezed
          ? _value.today
          : today // ignore: cast_nullable_to_non_nullable
              as HealthByPeriod,
      yesterday: yesterday == freezed
          ? _value.yesterday
          : yesterday // ignore: cast_nullable_to_non_nullable
              as HealthByPeriod,
      week: week == freezed
          ? _value.week
          : week // ignore: cast_nullable_to_non_nullable
              as HealthByPeriod,
      month: month == freezed
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as HealthByPeriod,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalSteps: totalSteps == freezed
          ? _value.totalSteps
          : totalSteps // ignore: cast_nullable_to_non_nullable
              as int,
      totalDistance: totalDistance == freezed
          ? _value.totalDistance
          : totalDistance // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_HealthInfo extends _HealthInfo {
  const _$_HealthInfo(
      {required this.today,
      required this.yesterday,
      required this.week,
      required this.month,
      @JsonKey(fromJson: FirestoreTimestampConverter.timestampToDateTime, toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
          required this.updatedAt,
      required this.totalSteps,
      required this.totalDistance})
      : super._();

  factory _$_HealthInfo.fromJson(Map<String, dynamic> json) =>
      _$$_HealthInfoFromJson(json);

// 当日のヘルスケア情報
  @override
  final HealthByPeriod today;
// 昨日のヘルスケア情報
  @override
  final HealthByPeriod yesterday;
// 昨日から一週間前までのヘルスケア情報
  @override
  final HealthByPeriod week;
// 昨日から一ヶ月前までのヘルスケア情報
  @override
  final HealthByPeriod month;
  @override
  @JsonKey(
      fromJson: FirestoreTimestampConverter.timestampToDateTime,
      toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
  final DateTime updatedAt;
// 総歩数
  @override
  final int totalSteps;
// 総歩行距離[m]
  @override
  final int totalDistance;

  @override
  String toString() {
    return 'HealthInfo(today: $today, yesterday: $yesterday, week: $week, month: $month, updatedAt: $updatedAt, totalSteps: $totalSteps, totalDistance: $totalDistance)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HealthInfo &&
            const DeepCollectionEquality().equals(other.today, today) &&
            const DeepCollectionEquality().equals(other.yesterday, yesterday) &&
            const DeepCollectionEquality().equals(other.week, week) &&
            const DeepCollectionEquality().equals(other.month, month) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            const DeepCollectionEquality()
                .equals(other.totalSteps, totalSteps) &&
            const DeepCollectionEquality()
                .equals(other.totalDistance, totalDistance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(today),
      const DeepCollectionEquality().hash(yesterday),
      const DeepCollectionEquality().hash(week),
      const DeepCollectionEquality().hash(month),
      const DeepCollectionEquality().hash(updatedAt),
      const DeepCollectionEquality().hash(totalSteps),
      const DeepCollectionEquality().hash(totalDistance));

  @JsonKey(ignore: true)
  @override
  _$$_HealthInfoCopyWith<_$_HealthInfo> get copyWith =>
      __$$_HealthInfoCopyWithImpl<_$_HealthInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HealthInfoToJson(
      this,
    );
  }
}

abstract class _HealthInfo extends HealthInfo {
  const factory _HealthInfo(
      {required final HealthByPeriod today,
      required final HealthByPeriod yesterday,
      required final HealthByPeriod week,
      required final HealthByPeriod month,
      @JsonKey(fromJson: FirestoreTimestampConverter.timestampToDateTime, toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
          required final DateTime updatedAt,
      required final int totalSteps,
      required final int totalDistance}) = _$_HealthInfo;
  const _HealthInfo._() : super._();

  factory _HealthInfo.fromJson(Map<String, dynamic> json) =
      _$_HealthInfo.fromJson;

  @override // 当日のヘルスケア情報
  HealthByPeriod get today;
  @override // 昨日のヘルスケア情報
  HealthByPeriod get yesterday;
  @override // 昨日から一週間前までのヘルスケア情報
  HealthByPeriod get week;
  @override // 昨日から一ヶ月前までのヘルスケア情報
  HealthByPeriod get month;
  @override
  @JsonKey(
      fromJson: FirestoreTimestampConverter.timestampToDateTime,
      toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
  DateTime get updatedAt;
  @override // 総歩数
  int get totalSteps;
  @override // 総歩行距離[m]
  int get totalDistance;
  @override
  @JsonKey(ignore: true)
  _$$_HealthInfoCopyWith<_$_HealthInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
