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
  int get id => throw _privateConstructorUsedError;
  int get nowPilgrimageId => throw _privateConstructorUsedError;
  int get lap => throw _privateConstructorUsedError;

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
  $Res call({int id, int nowPilgrimageId, int lap});
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
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nowPilgrimageId: nowPilgrimageId == freezed
          ? _value.nowPilgrimageId
          : nowPilgrimageId // ignore: cast_nullable_to_non_nullable
              as int,
      lap: lap == freezed
          ? _value.lap
          : lap // ignore: cast_nullable_to_non_nullable
              as int,
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
  $Res call({int id, int nowPilgrimageId, int lap});
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
  }) {
    return _then(_$_PilgrimageInfo(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nowPilgrimageId: nowPilgrimageId == freezed
          ? _value.nowPilgrimageId
          : nowPilgrimageId // ignore: cast_nullable_to_non_nullable
              as int,
      lap: lap == freezed
          ? _value.lap
          : lap // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_PilgrimageInfo extends _PilgrimageInfo {
  const _$_PilgrimageInfo(
      {required this.id, required this.nowPilgrimageId, required this.lap})
      : super._();

  factory _$_PilgrimageInfo.fromJson(Map<String, dynamic> json) =>
      _$$_PilgrimageInfoFromJson(json);

  @override
  final int id;
  @override
  final int nowPilgrimageId;
  @override
  final int lap;

  @override
  String toString() {
    return 'PilgrimageInfo(id: $id, nowPilgrimageId: $nowPilgrimageId, lap: $lap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PilgrimageInfo &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.nowPilgrimageId, nowPilgrimageId) &&
            const DeepCollectionEquality().equals(other.lap, lap));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(nowPilgrimageId),
      const DeepCollectionEquality().hash(lap));

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
      {required final int id,
      required final int nowPilgrimageId,
      required final int lap}) = _$_PilgrimageInfo;
  const _PilgrimageInfo._() : super._();

  factory _PilgrimageInfo.fromJson(Map<String, dynamic> json) =
      _$_PilgrimageInfo.fromJson;

  @override
  int get id;
  @override
  int get nowPilgrimageId;
  @override
  int get lap;
  @override
  @JsonKey(ignore: true)
  _$$_PilgrimageInfoCopyWith<_$_PilgrimageInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
