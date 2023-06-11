// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
  DateTime get updatedAt =>
      throw _privateConstructorUsedError; // [deprecated] 総歩数
  int get totalSteps =>
      throw _privateConstructorUsedError; // [deprecated] 総歩行距離[m]
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
      _$HealthInfoCopyWithImpl<$Res, HealthInfo>;
  @useResult
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
class _$HealthInfoCopyWithImpl<$Res, $Val extends HealthInfo>
    implements $HealthInfoCopyWith<$Res> {
  _$HealthInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? today = null,
    Object? yesterday = null,
    Object? week = null,
    Object? month = null,
    Object? updatedAt = null,
    Object? totalSteps = null,
    Object? totalDistance = null,
  }) {
    return _then(_value.copyWith(
      today: null == today
          ? _value.today
          : today // ignore: cast_nullable_to_non_nullable
              as HealthByPeriod,
      yesterday: null == yesterday
          ? _value.yesterday
          : yesterday // ignore: cast_nullable_to_non_nullable
              as HealthByPeriod,
      week: null == week
          ? _value.week
          : week // ignore: cast_nullable_to_non_nullable
              as HealthByPeriod,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as HealthByPeriod,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalSteps: null == totalSteps
          ? _value.totalSteps
          : totalSteps // ignore: cast_nullable_to_non_nullable
              as int,
      totalDistance: null == totalDistance
          ? _value.totalDistance
          : totalDistance // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $HealthByPeriodCopyWith<$Res> get today {
    return $HealthByPeriodCopyWith<$Res>(_value.today, (value) {
      return _then(_value.copyWith(today: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $HealthByPeriodCopyWith<$Res> get yesterday {
    return $HealthByPeriodCopyWith<$Res>(_value.yesterday, (value) {
      return _then(_value.copyWith(yesterday: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $HealthByPeriodCopyWith<$Res> get week {
    return $HealthByPeriodCopyWith<$Res>(_value.week, (value) {
      return _then(_value.copyWith(week: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $HealthByPeriodCopyWith<$Res> get month {
    return $HealthByPeriodCopyWith<$Res>(_value.month, (value) {
      return _then(_value.copyWith(month: value) as $Val);
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
  @useResult
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
class __$$_HealthInfoCopyWithImpl<$Res>
    extends _$HealthInfoCopyWithImpl<$Res, _$_HealthInfo>
    implements _$$_HealthInfoCopyWith<$Res> {
  __$$_HealthInfoCopyWithImpl(
      _$_HealthInfo _value, $Res Function(_$_HealthInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? today = null,
    Object? yesterday = null,
    Object? week = null,
    Object? month = null,
    Object? updatedAt = null,
    Object? totalSteps = null,
    Object? totalDistance = null,
  }) {
    return _then(_$_HealthInfo(
      today: null == today
          ? _value.today
          : today // ignore: cast_nullable_to_non_nullable
              as HealthByPeriod,
      yesterday: null == yesterday
          ? _value.yesterday
          : yesterday // ignore: cast_nullable_to_non_nullable
              as HealthByPeriod,
      week: null == week
          ? _value.week
          : week // ignore: cast_nullable_to_non_nullable
              as HealthByPeriod,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as HealthByPeriod,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalSteps: null == totalSteps
          ? _value.totalSteps
          : totalSteps // ignore: cast_nullable_to_non_nullable
              as int,
      totalDistance: null == totalDistance
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
// [deprecated] 総歩数
  @override
  final int totalSteps;
// [deprecated] 総歩行距離[m]
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
            (identical(other.today, today) || other.today == today) &&
            (identical(other.yesterday, yesterday) ||
                other.yesterday == yesterday) &&
            (identical(other.week, week) || other.week == week) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.totalSteps, totalSteps) ||
                other.totalSteps == totalSteps) &&
            (identical(other.totalDistance, totalDistance) ||
                other.totalDistance == totalDistance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, today, yesterday, week, month,
      updatedAt, totalSteps, totalDistance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
  @override // [deprecated] 総歩数
  int get totalSteps;
  @override // [deprecated] 総歩行距離[m]
  int get totalDistance;
  @override
  @JsonKey(ignore: true)
  _$$_HealthInfoCopyWith<_$_HealthInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

RecentlyHealthInfo _$RecentlyHealthInfoFromJson(Map<String, dynamic> json) {
  return _RecentlyHealthInfo.fromJson(json);
}

/// @nodoc
mixin _$RecentlyHealthInfo {
// 当日のヘルスケア情報
  HealthByPeriod get today => throw _privateConstructorUsedError; // 昨日のヘルスケア情報
  HealthByPeriod get yesterday => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecentlyHealthInfoCopyWith<RecentlyHealthInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentlyHealthInfoCopyWith<$Res> {
  factory $RecentlyHealthInfoCopyWith(
          RecentlyHealthInfo value, $Res Function(RecentlyHealthInfo) then) =
      _$RecentlyHealthInfoCopyWithImpl<$Res, RecentlyHealthInfo>;
  @useResult
  $Res call({HealthByPeriod today, HealthByPeriod yesterday});

  $HealthByPeriodCopyWith<$Res> get today;
  $HealthByPeriodCopyWith<$Res> get yesterday;
}

/// @nodoc
class _$RecentlyHealthInfoCopyWithImpl<$Res, $Val extends RecentlyHealthInfo>
    implements $RecentlyHealthInfoCopyWith<$Res> {
  _$RecentlyHealthInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? today = null,
    Object? yesterday = null,
  }) {
    return _then(_value.copyWith(
      today: null == today
          ? _value.today
          : today // ignore: cast_nullable_to_non_nullable
              as HealthByPeriod,
      yesterday: null == yesterday
          ? _value.yesterday
          : yesterday // ignore: cast_nullable_to_non_nullable
              as HealthByPeriod,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $HealthByPeriodCopyWith<$Res> get today {
    return $HealthByPeriodCopyWith<$Res>(_value.today, (value) {
      return _then(_value.copyWith(today: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $HealthByPeriodCopyWith<$Res> get yesterday {
    return $HealthByPeriodCopyWith<$Res>(_value.yesterday, (value) {
      return _then(_value.copyWith(yesterday: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_RecentlyHealthInfoCopyWith<$Res>
    implements $RecentlyHealthInfoCopyWith<$Res> {
  factory _$$_RecentlyHealthInfoCopyWith(_$_RecentlyHealthInfo value,
          $Res Function(_$_RecentlyHealthInfo) then) =
      __$$_RecentlyHealthInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({HealthByPeriod today, HealthByPeriod yesterday});

  @override
  $HealthByPeriodCopyWith<$Res> get today;
  @override
  $HealthByPeriodCopyWith<$Res> get yesterday;
}

/// @nodoc
class __$$_RecentlyHealthInfoCopyWithImpl<$Res>
    extends _$RecentlyHealthInfoCopyWithImpl<$Res, _$_RecentlyHealthInfo>
    implements _$$_RecentlyHealthInfoCopyWith<$Res> {
  __$$_RecentlyHealthInfoCopyWithImpl(
      _$_RecentlyHealthInfo _value, $Res Function(_$_RecentlyHealthInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? today = null,
    Object? yesterday = null,
  }) {
    return _then(_$_RecentlyHealthInfo(
      today: null == today
          ? _value.today
          : today // ignore: cast_nullable_to_non_nullable
              as HealthByPeriod,
      yesterday: null == yesterday
          ? _value.yesterday
          : yesterday // ignore: cast_nullable_to_non_nullable
              as HealthByPeriod,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_RecentlyHealthInfo extends _RecentlyHealthInfo {
  const _$_RecentlyHealthInfo({required this.today, required this.yesterday})
      : super._();

  factory _$_RecentlyHealthInfo.fromJson(Map<String, dynamic> json) =>
      _$$_RecentlyHealthInfoFromJson(json);

// 当日のヘルスケア情報
  @override
  final HealthByPeriod today;
// 昨日のヘルスケア情報
  @override
  final HealthByPeriod yesterday;

  @override
  String toString() {
    return 'RecentlyHealthInfo(today: $today, yesterday: $yesterday)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecentlyHealthInfo &&
            (identical(other.today, today) || other.today == today) &&
            (identical(other.yesterday, yesterday) ||
                other.yesterday == yesterday));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, today, yesterday);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecentlyHealthInfoCopyWith<_$_RecentlyHealthInfo> get copyWith =>
      __$$_RecentlyHealthInfoCopyWithImpl<_$_RecentlyHealthInfo>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RecentlyHealthInfoToJson(
      this,
    );
  }
}

abstract class _RecentlyHealthInfo extends RecentlyHealthInfo {
  const factory _RecentlyHealthInfo(
      {required final HealthByPeriod today,
      required final HealthByPeriod yesterday}) = _$_RecentlyHealthInfo;
  const _RecentlyHealthInfo._() : super._();

  factory _RecentlyHealthInfo.fromJson(Map<String, dynamic> json) =
      _$_RecentlyHealthInfo.fromJson;

  @override // 当日のヘルスケア情報
  HealthByPeriod get today;
  @override // 昨日のヘルスケア情報
  HealthByPeriod get yesterday;
  @override
  @JsonKey(ignore: true)
  _$$_RecentlyHealthInfoCopyWith<_$_RecentlyHealthInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
