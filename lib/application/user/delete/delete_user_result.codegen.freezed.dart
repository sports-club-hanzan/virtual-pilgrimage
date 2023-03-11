// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_user_result.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DeleteUserResult {
  DeleteUserStatus get status => throw _privateConstructorUsedError;
  Exception? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeleteUserResultCopyWith<DeleteUserResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeleteUserResultCopyWith<$Res> {
  factory $DeleteUserResultCopyWith(
          DeleteUserResult value, $Res Function(DeleteUserResult) then) =
      _$DeleteUserResultCopyWithImpl<$Res, DeleteUserResult>;
  @useResult
  $Res call({DeleteUserStatus status, Exception? error});
}

/// @nodoc
class _$DeleteUserResultCopyWithImpl<$Res, $Val extends DeleteUserResult>
    implements $DeleteUserResultCopyWith<$Res> {
  _$DeleteUserResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DeleteUserStatus,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Exception?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DeleteUserResultCopyWith<$Res>
    implements $DeleteUserResultCopyWith<$Res> {
  factory _$$_DeleteUserResultCopyWith(
          _$_DeleteUserResult value, $Res Function(_$_DeleteUserResult) then) =
      __$$_DeleteUserResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DeleteUserStatus status, Exception? error});
}

/// @nodoc
class __$$_DeleteUserResultCopyWithImpl<$Res>
    extends _$DeleteUserResultCopyWithImpl<$Res, _$_DeleteUserResult>
    implements _$$_DeleteUserResultCopyWith<$Res> {
  __$$_DeleteUserResultCopyWithImpl(
      _$_DeleteUserResult _value, $Res Function(_$_DeleteUserResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = freezed,
  }) {
    return _then(_$_DeleteUserResult(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DeleteUserStatus,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Exception?,
    ));
  }
}

/// @nodoc

class _$_DeleteUserResult extends _DeleteUserResult {
  const _$_DeleteUserResult({required this.status, this.error}) : super._();

  @override
  final DeleteUserStatus status;
  @override
  final Exception? error;

  @override
  String toString() {
    return 'DeleteUserResult(status: $status, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeleteUserResult &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeleteUserResultCopyWith<_$_DeleteUserResult> get copyWith =>
      __$$_DeleteUserResultCopyWithImpl<_$_DeleteUserResult>(this, _$identity);
}

abstract class _DeleteUserResult extends DeleteUserResult {
  const factory _DeleteUserResult(
      {required final DeleteUserStatus status,
      final Exception? error}) = _$_DeleteUserResult;
  const _DeleteUserResult._() : super._();

  @override
  DeleteUserStatus get status;
  @override
  Exception? get error;
  @override
  @JsonKey(ignore: true)
  _$$_DeleteUserResultCopyWith<_$_DeleteUserResult> get copyWith =>
      throw _privateConstructorUsedError;
}
