// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'deleted_user.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DeletedUser _$DeletedUserFromJson(Map<String, dynamic> json) {
  return _DeletedUser.fromJson(json);
}

/// @nodoc
mixin _$DeletedUser {
/**
     * 削除対象のユーザID
     */
  String get id => throw _privateConstructorUsedError;
  /**
     * 削除日時
     */
  @JsonKey(
      fromJson: FirestoreTimestampConverter.timestampToDateTime,
      toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
  DateTime get deletedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeletedUserCopyWith<DeletedUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeletedUserCopyWith<$Res> {
  factory $DeletedUserCopyWith(
          DeletedUser value, $Res Function(DeletedUser) then) =
      _$DeletedUserCopyWithImpl<$Res, DeletedUser>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(fromJson: FirestoreTimestampConverter.timestampToDateTime, toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
          DateTime deletedAt});
}

/// @nodoc
class _$DeletedUserCopyWithImpl<$Res, $Val extends DeletedUser>
    implements $DeletedUserCopyWith<$Res> {
  _$DeletedUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deletedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      deletedAt: null == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DeletedUserCopyWith<$Res>
    implements $DeletedUserCopyWith<$Res> {
  factory _$$_DeletedUserCopyWith(
          _$_DeletedUser value, $Res Function(_$_DeletedUser) then) =
      __$$_DeletedUserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(fromJson: FirestoreTimestampConverter.timestampToDateTime, toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
          DateTime deletedAt});
}

/// @nodoc
class __$$_DeletedUserCopyWithImpl<$Res>
    extends _$DeletedUserCopyWithImpl<$Res, _$_DeletedUser>
    implements _$$_DeletedUserCopyWith<$Res> {
  __$$_DeletedUserCopyWithImpl(
      _$_DeletedUser _value, $Res Function(_$_DeletedUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deletedAt = null,
  }) {
    return _then(_$_DeletedUser(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      deletedAt: null == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_DeletedUser extends _DeletedUser {
  const _$_DeletedUser(
      {required this.id,
      @JsonKey(fromJson: FirestoreTimestampConverter.timestampToDateTime, toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
          required this.deletedAt})
      : super._();

  factory _$_DeletedUser.fromJson(Map<String, dynamic> json) =>
      _$$_DeletedUserFromJson(json);

/**
     * 削除対象のユーザID
     */
  @override
  final String id;
/**
     * 削除日時
     */
  @override
  @JsonKey(
      fromJson: FirestoreTimestampConverter.timestampToDateTime,
      toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
  final DateTime deletedAt;

  @override
  String toString() {
    return 'DeletedUser(id: $id, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeletedUser &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, deletedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeletedUserCopyWith<_$_DeletedUser> get copyWith =>
      __$$_DeletedUserCopyWithImpl<_$_DeletedUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DeletedUserToJson(
      this,
    );
  }
}

abstract class _DeletedUser extends DeletedUser {
  const factory _DeletedUser(
      {required final String id,
      @JsonKey(fromJson: FirestoreTimestampConverter.timestampToDateTime, toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
          required final DateTime deletedAt}) = _$_DeletedUser;
  const _DeletedUser._() : super._();

  factory _DeletedUser.fromJson(Map<String, dynamic> json) =
      _$_DeletedUser.fromJson;

  @override
  /**
     * 削除対象のユーザID
     */
  String get id;
  @override
  /**
     * 削除日時
     */
  @JsonKey(
      fromJson: FirestoreTimestampConverter.timestampToDateTime,
      toJson: FirestoreTimestampConverter.dateTimeToTimestamp)
  DateTime get deletedAt;
  @override
  @JsonKey(ignore: true)
  _$$_DeletedUserCopyWith<_$_DeletedUser> get copyWith =>
      throw _privateConstructorUsedError;
}
