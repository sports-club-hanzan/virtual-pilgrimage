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
// Firestore のid。
// 利用しない値なので、Firebase Authentication から取得できるidを詰める
  String get id => throw _privateConstructorUsedError; // 現在のお遍路の番所
// 1番札所からスタートするのでデフォルト：1
  int get nowPilgrimageId => throw _privateConstructorUsedError; // お遍路が何周目か。
// 1週目からスタートするのでデフォルト：1
  int get lap => throw _privateConstructorUsedError; // お寺に到着したかを参照するための移動距離
// 次の札所に到着したかを計算する為に保存
  double get movingDistance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PilgrimageInfoCopyWith<PilgrimageInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PilgrimageInfoCopyWith<$Res> {
  factory $PilgrimageInfoCopyWith(
          PilgrimageInfo value, $Res Function(PilgrimageInfo) then) =
      _$PilgrimageInfoCopyWithImpl<$Res>;
  $Res call({String id, int nowPilgrimageId, int lap, double movingDistance});
}

/// @nodoc
class _$PilgrimageInfoCopyWithImpl<$Res>
    implements $PilgrimageInfoCopyWith<$Res> {
  _$PilgrimageInfoCopyWithImpl(this._value, this._then);

  final PilgrimageInfo _value;
  // ignore: unused_field
  final $Res Function(PilgrimageInfo) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? nowPilgrimageId = freezed,
    Object? lap = freezed,
    Object? movingDistance = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nowPilgrimageId: nowPilgrimageId == freezed
          ? _value.nowPilgrimageId
          : nowPilgrimageId // ignore: cast_nullable_to_non_nullable
              as int,
      lap: lap == freezed
          ? _value.lap
          : lap // ignore: cast_nullable_to_non_nullable
              as int,
      movingDistance: movingDistance == freezed
          ? _value.movingDistance
          : movingDistance // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$$_PilgrimageInfoCopyWith<$Res>
    implements $PilgrimageInfoCopyWith<$Res> {
  factory _$$_PilgrimageInfoCopyWith(
          _$_PilgrimageInfo value, $Res Function(_$_PilgrimageInfo) then) =
      __$$_PilgrimageInfoCopyWithImpl<$Res>;
  @override
  $Res call({String id, int nowPilgrimageId, int lap, double movingDistance});
}

/// @nodoc
class __$$_PilgrimageInfoCopyWithImpl<$Res>
    extends _$PilgrimageInfoCopyWithImpl<$Res>
    implements _$$_PilgrimageInfoCopyWith<$Res> {
  __$$_PilgrimageInfoCopyWithImpl(
      _$_PilgrimageInfo _value, $Res Function(_$_PilgrimageInfo) _then)
      : super(_value, (v) => _then(v as _$_PilgrimageInfo));

  @override
  _$_PilgrimageInfo get _value => super._value as _$_PilgrimageInfo;

  @override
  $Res call({
    Object? id = freezed,
    Object? nowPilgrimageId = freezed,
    Object? lap = freezed,
    Object? movingDistance = freezed,
  }) {
    return _then(_$_PilgrimageInfo(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nowPilgrimageId: nowPilgrimageId == freezed
          ? _value.nowPilgrimageId
          : nowPilgrimageId // ignore: cast_nullable_to_non_nullable
              as int,
      lap: lap == freezed
          ? _value.lap
          : lap // ignore: cast_nullable_to_non_nullable
              as int,
      movingDistance: movingDistance == freezed
          ? _value.movingDistance
          : movingDistance // ignore: cast_nullable_to_non_nullable
              as double,
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
      this.movingDistance = 0})
      : super._();

  factory _$_PilgrimageInfo.fromJson(Map<String, dynamic> json) =>
      _$$_PilgrimageInfoFromJson(json);

// Firestore のid。
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
  final double movingDistance;

  @override
  String toString() {
    return 'PilgrimageInfo(id: $id, nowPilgrimageId: $nowPilgrimageId, lap: $lap, movingDistance: $movingDistance)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PilgrimageInfo &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.nowPilgrimageId, nowPilgrimageId) &&
            const DeepCollectionEquality().equals(other.lap, lap) &&
            const DeepCollectionEquality()
                .equals(other.movingDistance, movingDistance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(nowPilgrimageId),
      const DeepCollectionEquality().hash(lap),
      const DeepCollectionEquality().hash(movingDistance));

  @JsonKey(ignore: true)
  @override
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
      final double movingDistance}) = _$_PilgrimageInfo;
  const _PilgrimageInfo._() : super._();

  factory _PilgrimageInfo.fromJson(Map<String, dynamic> json) =
      _$_PilgrimageInfo.fromJson;

  @override // Firestore のid。
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
  double get movingDistance;
  @override
  @JsonKey(ignore: true)
  _$$_PilgrimageInfoCopyWith<_$_PilgrimageInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
