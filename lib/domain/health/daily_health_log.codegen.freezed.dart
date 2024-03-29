// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_health_log.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DailyHealthLog _$DailyHealthLogFromJson(Map<String, dynamic> json) {
  return _DailyHealthLog.fromJson(json);
}

/// @nodoc
mixin _$DailyHealthLog {
// ユーザID
  String get userId => throw _privateConstructorUsedError; // 歩数
  int get steps => throw _privateConstructorUsedError; // 歩行距離
  int get distance => throw _privateConstructorUsedError; // 消費カロリー
  int get burnedCalorie => throw _privateConstructorUsedError; // 記録対象日
  @JsonKey(
      fromJson: FirestoreTimestampConverter.timestampToDateTime,
      toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
  DateTime get date => throw _privateConstructorUsedError; // 有効期限
  @JsonKey(
      fromJson: FirestoreTimestampConverter.timestampToDateTime,
      toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
  DateTime get expiredAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DailyHealthLogCopyWith<DailyHealthLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyHealthLogCopyWith<$Res> {
  factory $DailyHealthLogCopyWith(
          DailyHealthLog value, $Res Function(DailyHealthLog) then) =
      _$DailyHealthLogCopyWithImpl<$Res, DailyHealthLog>;
  @useResult
  $Res call(
      {String userId,
      int steps,
      int distance,
      int burnedCalorie,
      @JsonKey(fromJson: FirestoreTimestampConverter.timestampToDateTime, toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
          DateTime date,
      @JsonKey(fromJson: FirestoreTimestampConverter.timestampToDateTime, toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
          DateTime expiredAt});
}

/// @nodoc
class _$DailyHealthLogCopyWithImpl<$Res, $Val extends DailyHealthLog>
    implements $DailyHealthLogCopyWith<$Res> {
  _$DailyHealthLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? steps = null,
    Object? distance = null,
    Object? burnedCalorie = null,
    Object? date = null,
    Object? expiredAt = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
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
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiredAt: null == expiredAt
          ? _value.expiredAt
          : expiredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DailyHealthLogCopyWith<$Res>
    implements $DailyHealthLogCopyWith<$Res> {
  factory _$$_DailyHealthLogCopyWith(
          _$_DailyHealthLog value, $Res Function(_$_DailyHealthLog) then) =
      __$$_DailyHealthLogCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      int steps,
      int distance,
      int burnedCalorie,
      @JsonKey(fromJson: FirestoreTimestampConverter.timestampToDateTime, toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
          DateTime date,
      @JsonKey(fromJson: FirestoreTimestampConverter.timestampToDateTime, toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
          DateTime expiredAt});
}

/// @nodoc
class __$$_DailyHealthLogCopyWithImpl<$Res>
    extends _$DailyHealthLogCopyWithImpl<$Res, _$_DailyHealthLog>
    implements _$$_DailyHealthLogCopyWith<$Res> {
  __$$_DailyHealthLogCopyWithImpl(
      _$_DailyHealthLog _value, $Res Function(_$_DailyHealthLog) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? steps = null,
    Object? distance = null,
    Object? burnedCalorie = null,
    Object? date = null,
    Object? expiredAt = null,
  }) {
    return _then(_$_DailyHealthLog(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
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
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiredAt: null == expiredAt
          ? _value.expiredAt
          : expiredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_DailyHealthLog extends _DailyHealthLog {
  const _$_DailyHealthLog(
      {required this.userId,
      required this.steps,
      required this.distance,
      required this.burnedCalorie,
      @JsonKey(fromJson: FirestoreTimestampConverter.timestampToDateTime, toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
          required this.date,
      @JsonKey(fromJson: FirestoreTimestampConverter.timestampToDateTime, toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
          required this.expiredAt})
      : super._();

  factory _$_DailyHealthLog.fromJson(Map<String, dynamic> json) =>
      _$$_DailyHealthLogFromJson(json);

// ユーザID
  @override
  final String userId;
// 歩数
  @override
  final int steps;
// 歩行距離
  @override
  final int distance;
// 消費カロリー
  @override
  final int burnedCalorie;
// 記録対象日
  @override
  @JsonKey(
      fromJson: FirestoreTimestampConverter.timestampToDateTime,
      toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
  final DateTime date;
// 有効期限
  @override
  @JsonKey(
      fromJson: FirestoreTimestampConverter.timestampToDateTime,
      toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
  final DateTime expiredAt;

  @override
  String toString() {
    return 'DailyHealthLog(userId: $userId, steps: $steps, distance: $distance, burnedCalorie: $burnedCalorie, date: $date, expiredAt: $expiredAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DailyHealthLog &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.steps, steps) || other.steps == steps) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.burnedCalorie, burnedCalorie) ||
                other.burnedCalorie == burnedCalorie) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.expiredAt, expiredAt) ||
                other.expiredAt == expiredAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, userId, steps, distance, burnedCalorie, date, expiredAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DailyHealthLogCopyWith<_$_DailyHealthLog> get copyWith =>
      __$$_DailyHealthLogCopyWithImpl<_$_DailyHealthLog>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DailyHealthLogToJson(
      this,
    );
  }
}

abstract class _DailyHealthLog extends DailyHealthLog {
  const factory _DailyHealthLog(
      {required final String userId,
      required final int steps,
      required final int distance,
      required final int burnedCalorie,
      @JsonKey(fromJson: FirestoreTimestampConverter.timestampToDateTime, toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
          required final DateTime date,
      @JsonKey(fromJson: FirestoreTimestampConverter.timestampToDateTime, toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
          required final DateTime expiredAt}) = _$_DailyHealthLog;
  const _DailyHealthLog._() : super._();

  factory _DailyHealthLog.fromJson(Map<String, dynamic> json) =
      _$_DailyHealthLog.fromJson;

  @override // ユーザID
  String get userId;
  @override // 歩数
  int get steps;
  @override // 歩行距離
  int get distance;
  @override // 消費カロリー
  int get burnedCalorie;
  @override // 記録対象日
  @JsonKey(
      fromJson: FirestoreTimestampConverter.timestampToDateTime,
      toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
  DateTime get date;
  @override // 有効期限
  @JsonKey(
      fromJson: FirestoreTimestampConverter.timestampToDateTime,
      toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
  DateTime get expiredAt;
  @override
  @JsonKey(ignore: true)
  _$$_DailyHealthLogCopyWith<_$_DailyHealthLog> get copyWith =>
      throw _privateConstructorUsedError;
}
