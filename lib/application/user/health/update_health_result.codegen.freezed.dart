// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'update_health_result.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UpdateHealthResult {
  UpdateHealthStatus get status => throw _privateConstructorUsedError;
  VirtualPilgrimageUser? get user => throw _privateConstructorUsedError;
  Exception? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UpdateHealthResultCopyWith<UpdateHealthResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateHealthResultCopyWith<$Res> {
  factory $UpdateHealthResultCopyWith(
          UpdateHealthResult value, $Res Function(UpdateHealthResult) then) =
      _$UpdateHealthResultCopyWithImpl<$Res, UpdateHealthResult>;
  @useResult
  $Res call(
      {UpdateHealthStatus status,
      VirtualPilgrimageUser? user,
      Exception? error});

  $VirtualPilgrimageUserCopyWith<$Res>? get user;
}

/// @nodoc
class _$UpdateHealthResultCopyWithImpl<$Res, $Val extends UpdateHealthResult>
    implements $UpdateHealthResultCopyWith<$Res> {
  _$UpdateHealthResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? user = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UpdateHealthStatus,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as VirtualPilgrimageUser?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Exception?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $VirtualPilgrimageUserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $VirtualPilgrimageUserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UpdateHealthResultCopyWith<$Res>
    implements $UpdateHealthResultCopyWith<$Res> {
  factory _$$_UpdateHealthResultCopyWith(_$_UpdateHealthResult value,
          $Res Function(_$_UpdateHealthResult) then) =
      __$$_UpdateHealthResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UpdateHealthStatus status,
      VirtualPilgrimageUser? user,
      Exception? error});

  @override
  $VirtualPilgrimageUserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$_UpdateHealthResultCopyWithImpl<$Res>
    extends _$UpdateHealthResultCopyWithImpl<$Res, _$_UpdateHealthResult>
    implements _$$_UpdateHealthResultCopyWith<$Res> {
  __$$_UpdateHealthResultCopyWithImpl(
      _$_UpdateHealthResult _value, $Res Function(_$_UpdateHealthResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? user = freezed,
    Object? error = freezed,
  }) {
    return _then(_$_UpdateHealthResult(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UpdateHealthStatus,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as VirtualPilgrimageUser?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Exception?,
    ));
  }
}

/// @nodoc

class _$_UpdateHealthResult extends _UpdateHealthResult {
  const _$_UpdateHealthResult({required this.status, this.user, this.error})
      : super._();

  @override
  final UpdateHealthStatus status;
  @override
  final VirtualPilgrimageUser? user;
  @override
  final Exception? error;

  @override
  String toString() {
    return 'UpdateHealthResult(status: $status, user: $user, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UpdateHealthResult &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, user, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UpdateHealthResultCopyWith<_$_UpdateHealthResult> get copyWith =>
      __$$_UpdateHealthResultCopyWithImpl<_$_UpdateHealthResult>(
          this, _$identity);
}

abstract class _UpdateHealthResult extends UpdateHealthResult {
  const factory _UpdateHealthResult(
      {required final UpdateHealthStatus status,
      final VirtualPilgrimageUser? user,
      final Exception? error}) = _$_UpdateHealthResult;
  const _UpdateHealthResult._() : super._();

  @override
  UpdateHealthStatus get status;
  @override
  VirtualPilgrimageUser? get user;
  @override
  Exception? get error;
  @override
  @JsonKey(ignore: true)
  _$$_UpdateHealthResultCopyWith<_$_UpdateHealthResult> get copyWith =>
      throw _privateConstructorUsedError;
}
