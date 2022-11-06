// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sign_in_state.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SignInState {
  SignInStateContext get context => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  FormModel get emailOrNickname => throw _privateConstructorUsedError;
  FormModel get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignInStateCopyWith<SignInState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignInStateCopyWith<$Res> {
  factory $SignInStateCopyWith(
          SignInState value, $Res Function(SignInState) then) =
      _$SignInStateCopyWithImpl<$Res, SignInState>;
  @useResult
  $Res call(
      {SignInStateContext context,
      bool isLoading,
      FormModel emailOrNickname,
      FormModel password});

  $FormModelCopyWith<$Res> get emailOrNickname;
  $FormModelCopyWith<$Res> get password;
}

/// @nodoc
class _$SignInStateCopyWithImpl<$Res, $Val extends SignInState>
    implements $SignInStateCopyWith<$Res> {
  _$SignInStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? isLoading = null,
    Object? emailOrNickname = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as SignInStateContext,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      emailOrNickname: null == emailOrNickname
          ? _value.emailOrNickname
          : emailOrNickname // ignore: cast_nullable_to_non_nullable
              as FormModel,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as FormModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FormModelCopyWith<$Res> get emailOrNickname {
    return $FormModelCopyWith<$Res>(_value.emailOrNickname, (value) {
      return _then(_value.copyWith(emailOrNickname: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FormModelCopyWith<$Res> get password {
    return $FormModelCopyWith<$Res>(_value.password, (value) {
      return _then(_value.copyWith(password: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SignInStateCopyWith<$Res>
    implements $SignInStateCopyWith<$Res> {
  factory _$$_SignInStateCopyWith(
          _$_SignInState value, $Res Function(_$_SignInState) then) =
      __$$_SignInStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SignInStateContext context,
      bool isLoading,
      FormModel emailOrNickname,
      FormModel password});

  @override
  $FormModelCopyWith<$Res> get emailOrNickname;
  @override
  $FormModelCopyWith<$Res> get password;
}

/// @nodoc
class __$$_SignInStateCopyWithImpl<$Res>
    extends _$SignInStateCopyWithImpl<$Res, _$_SignInState>
    implements _$$_SignInStateCopyWith<$Res> {
  __$$_SignInStateCopyWithImpl(
      _$_SignInState _value, $Res Function(_$_SignInState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? isLoading = null,
    Object? emailOrNickname = null,
    Object? password = null,
  }) {
    return _then(_$_SignInState(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as SignInStateContext,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      emailOrNickname: null == emailOrNickname
          ? _value.emailOrNickname
          : emailOrNickname // ignore: cast_nullable_to_non_nullable
              as FormModel,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as FormModel,
    ));
  }
}

/// @nodoc

class _$_SignInState extends _SignInState {
  const _$_SignInState(
      {this.context = SignInStateContext.failed,
      this.isLoading = false,
      required this.emailOrNickname,
      required this.password})
      : super._();

  @override
  @JsonKey()
  final SignInStateContext context;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final FormModel emailOrNickname;
  @override
  final FormModel password;

  @override
  String toString() {
    return 'SignInState(context: $context, isLoading: $isLoading, emailOrNickname: $emailOrNickname, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SignInState &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.emailOrNickname, emailOrNickname) ||
                other.emailOrNickname == emailOrNickname) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, context, isLoading, emailOrNickname, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SignInStateCopyWith<_$_SignInState> get copyWith =>
      __$$_SignInStateCopyWithImpl<_$_SignInState>(this, _$identity);
}

abstract class _SignInState extends SignInState {
  const factory _SignInState(
      {final SignInStateContext context,
      final bool isLoading,
      required final FormModel emailOrNickname,
      required final FormModel password}) = _$_SignInState;
  const _SignInState._() : super._();

  @override
  SignInStateContext get context;
  @override
  bool get isLoading;
  @override
  FormModel get emailOrNickname;
  @override
  FormModel get password;
  @override
  @JsonKey(ignore: true)
  _$$_SignInStateCopyWith<_$_SignInState> get copyWith =>
      throw _privateConstructorUsedError;
}
