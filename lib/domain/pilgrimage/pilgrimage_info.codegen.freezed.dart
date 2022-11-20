// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'pilgrimage_info.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PilgrimageInfo _$PilgrimageInfoFromJson(Map<String, dynamic> json) {
  return _PilgrimageInfo.fromJson(json);
}

/// @nodoc
mixin _$PilgrimageInfo {
// Firestore のid
// 利用しない値なので、Firebase Authentication から取得できるidを詰める
  String get id => throw _privateConstructorUsedError; // 現在のお遍路の番所
// 1番札所からスタートするのでデフォルト：1
  int get nowPilgrimageId => throw _privateConstructorUsedError; // お遍路が何周目か。
// 1週目からスタートするのでデフォルト：1
  int get lap => throw _privateConstructorUsedError; // お寺に到着したかを参照するための移動距離
// 次の札所に到着したかを計算する為に保存
  int get movingDistance =>
      throw _privateConstructorUsedError; // 最後にお遍路の進捗状況を更新した時刻
  @JsonKey(
      fromJson: FirestoreTimestampConverter.timestampToDateTime,
      toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PilgrimageInfoCopyWith<PilgrimageInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PilgrimageInfoCopyWith<$Res> {
  factory $PilgrimageInfoCopyWith(
          PilgrimageInfo value, $Res Function(PilgrimageInfo) then) =
      _$PilgrimageInfoCopyWithImpl<$Res, PilgrimageInfo>;
  @useResult
  $Res call(
      {String id,
      int nowPilgrimageId,
      int lap,
      int movingDistance,
      @JsonKey(fromJson: FirestoreTimestampConverter.timestampToDateTime, toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
          DateTime updatedAt});
}

/// @nodoc
class _$PilgrimageInfoCopyWithImpl<$Res, $Val extends PilgrimageInfo>
    implements $PilgrimageInfoCopyWith<$Res> {
  _$PilgrimageInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nowPilgrimageId = null,
    Object? lap = null,
    Object? movingDistance = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nowPilgrimageId: null == nowPilgrimageId
          ? _value.nowPilgrimageId
          : nowPilgrimageId // ignore: cast_nullable_to_non_nullable
              as int,
      lap: null == lap
          ? _value.lap
          : lap // ignore: cast_nullable_to_non_nullable
              as int,
      movingDistance: null == movingDistance
          ? _value.movingDistance
          : movingDistance // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PilgrimageInfoCopyWith<$Res>
    implements $PilgrimageInfoCopyWith<$Res> {
  factory _$$_PilgrimageInfoCopyWith(
          _$_PilgrimageInfo value, $Res Function(_$_PilgrimageInfo) then) =
      __$$_PilgrimageInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int nowPilgrimageId,
      int lap,
      int movingDistance,
      @JsonKey(fromJson: FirestoreTimestampConverter.timestampToDateTime, toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
          DateTime updatedAt});
}

/// @nodoc
class __$$_PilgrimageInfoCopyWithImpl<$Res>
    extends _$PilgrimageInfoCopyWithImpl<$Res, _$_PilgrimageInfo>
    implements _$$_PilgrimageInfoCopyWith<$Res> {
  __$$_PilgrimageInfoCopyWithImpl(
      _$_PilgrimageInfo _value, $Res Function(_$_PilgrimageInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nowPilgrimageId = null,
    Object? lap = null,
    Object? movingDistance = null,
    Object? updatedAt = null,
  }) {
    return _then(_$_PilgrimageInfo(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nowPilgrimageId: null == nowPilgrimageId
          ? _value.nowPilgrimageId
          : nowPilgrimageId // ignore: cast_nullable_to_non_nullable
              as int,
      lap: null == lap
          ? _value.lap
          : lap // ignore: cast_nullable_to_non_nullable
              as int,
      movingDistance: null == movingDistance
          ? _value.movingDistance
          : movingDistance // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PilgrimageInfo extends _PilgrimageInfo {
  const _$_PilgrimageInfo(
      {required this.id,
      this.nowPilgrimageId = 1,
      this.lap = 1,
      this.movingDistance = 0,
      @JsonKey(fromJson: FirestoreTimestampConverter.timestampToDateTime, toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
          required this.updatedAt})
      : super._();

  factory _$_PilgrimageInfo.fromJson(Map<String, dynamic> json) =>
      _$$_PilgrimageInfoFromJson(json);

// Firestore のid
// 利用しない値なので、Firebase Authentication から取得できるidを詰める
  @override
  final String id;
// 現在のお遍路の番所
// 1番札所からスタートするのでデフォルト：1
  @override
  @JsonKey()
  final int nowPilgrimageId;
// お遍路が何周目か。
// 1週目からスタートするのでデフォルト：1
  @override
  @JsonKey()
  final int lap;
// お寺に到着したかを参照するための移動距離
// 次の札所に到着したかを計算する為に保存
  @override
  @JsonKey()
  final int movingDistance;
// 最後にお遍路の進捗状況を更新した時刻
  @override
  @JsonKey(
      fromJson: FirestoreTimestampConverter.timestampToDateTime,
      toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
  final DateTime updatedAt;

  @override
  String toString() {
    return 'PilgrimageInfo(id: $id, nowPilgrimageId: $nowPilgrimageId, lap: $lap, movingDistance: $movingDistance, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PilgrimageInfo &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nowPilgrimageId, nowPilgrimageId) ||
                other.nowPilgrimageId == nowPilgrimageId) &&
            (identical(other.lap, lap) || other.lap == lap) &&
            (identical(other.movingDistance, movingDistance) ||
                other.movingDistance == movingDistance) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, nowPilgrimageId, lap, movingDistance, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PilgrimageInfoCopyWith<_$_PilgrimageInfo> get copyWith =>
      __$$_PilgrimageInfoCopyWithImpl<_$_PilgrimageInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PilgrimageInfoToJson(
      this,
    );
  }
}

abstract class _PilgrimageInfo extends PilgrimageInfo {
  const factory _PilgrimageInfo(
      {required final String id,
      final int nowPilgrimageId,
      final int lap,
      final int movingDistance,
      @JsonKey(fromJson: FirestoreTimestampConverter.timestampToDateTime, toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
          required final DateTime updatedAt}) = _$_PilgrimageInfo;
  const _PilgrimageInfo._() : super._();

  factory _PilgrimageInfo.fromJson(Map<String, dynamic> json) =
      _$_PilgrimageInfo.fromJson;

  @override // Firestore のid
// 利用しない値なので、Firebase Authentication から取得できるidを詰める
  String get id;
  @override // 現在のお遍路の番所
// 1番札所からスタートするのでデフォルト：1
  int get nowPilgrimageId;
  @override // お遍路が何周目か。
// 1週目からスタートするのでデフォルト：1
  int get lap;
  @override // お寺に到着したかを参照するための移動距離
// 次の札所に到着したかを計算する為に保存
  int get movingDistance;
  @override // 最後にお遍路の進捗状況を更新した時刻
  @JsonKey(
      fromJson: FirestoreTimestampConverter.timestampToDateTime,
      toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_PilgrimageInfoCopyWith<_$_PilgrimageInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
