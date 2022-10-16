// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'registration_state.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RegistrationState {
  FormModel get nickname => throw _privateConstructorUsedError;
  FormModel get birthday => throw _privateConstructorUsedError;
  RadioButtonModel<Gender> get gender => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegistrationStateCopyWith<RegistrationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegistrationStateCopyWith<$Res> {
  factory $RegistrationStateCopyWith(
          RegistrationState value, $Res Function(RegistrationState) then) =
      _$RegistrationStateCopyWithImpl<$Res>;
  $Res call(
      {FormModel nickname,
      FormModel birthday,
      RadioButtonModel<Gender> gender});

  $FormModelCopyWith<$Res> get nickname;
  $FormModelCopyWith<$Res> get birthday;
  $RadioButtonModelCopyWith<Gender, $Res> get gender;
}

/// @nodoc
class _$RegistrationStateCopyWithImpl<$Res>
    implements $RegistrationStateCopyWith<$Res> {
  _$RegistrationStateCopyWithImpl(this._value, this._then);

  final RegistrationState _value;
  // ignore: unused_field
  final $Res Function(RegistrationState) _then;

  @override
  $Res call({
    Object? nickname = freezed,
    Object? birthday = freezed,
    Object? gender = freezed,
  }) {
    return _then(_value.copyWith(
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as FormModel,
      birthday: birthday == freezed
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as FormModel,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as RadioButtonModel<Gender>,
    ));
  }

  @override
  $FormModelCopyWith<$Res> get nickname {
    return $FormModelCopyWith<$Res>(_value.nickname, (value) {
      return _then(_value.copyWith(nickname: value));
    });
  }

  @override
  $FormModelCopyWith<$Res> get birthday {
    return $FormModelCopyWith<$Res>(_value.birthday, (value) {
      return _then(_value.copyWith(birthday: value));
    });
  }

  @override
  $RadioButtonModelCopyWith<Gender, $Res> get gender {
    return $RadioButtonModelCopyWith<Gender, $Res>(_value.gender, (value) {
      return _then(_value.copyWith(gender: value));
    });
  }
}

/// @nodoc
abstract class _$$_RegistrationStateCopyWith<$Res>
    implements $RegistrationStateCopyWith<$Res> {
  factory _$$_RegistrationStateCopyWith(_$_RegistrationState value,
          $Res Function(_$_RegistrationState) then) =
      __$$_RegistrationStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {FormModel nickname,
      FormModel birthday,
      RadioButtonModel<Gender> gender});

  @override
  $FormModelCopyWith<$Res> get nickname;
  @override
  $FormModelCopyWith<$Res> get birthday;
  @override
  $RadioButtonModelCopyWith<Gender, $Res> get gender;
}

/// @nodoc
class __$$_RegistrationStateCopyWithImpl<$Res>
    extends _$RegistrationStateCopyWithImpl<$Res>
    implements _$$_RegistrationStateCopyWith<$Res> {
  __$$_RegistrationStateCopyWithImpl(
      _$_RegistrationState _value, $Res Function(_$_RegistrationState) _then)
      : super(_value, (v) => _then(v as _$_RegistrationState));

  @override
  _$_RegistrationState get _value => super._value as _$_RegistrationState;

  @override
  $Res call({
    Object? nickname = freezed,
    Object? birthday = freezed,
    Object? gender = freezed,
  }) {
    return _then(_$_RegistrationState(
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as FormModel,
      birthday: birthday == freezed
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as FormModel,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as RadioButtonModel<Gender>,
    ));
  }
}

/// @nodoc

class _$_RegistrationState extends _RegistrationState {
  const _$_RegistrationState(
      {required this.nickname, required this.birthday, required this.gender})
      : super._();

  @override
  final FormModel nickname;
  @override
  final FormModel birthday;
  @override
  final RadioButtonModel<Gender> gender;

  @override
  String toString() {
    return 'RegistrationState(nickname: $nickname, birthday: $birthday, gender: $gender)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RegistrationState &&
            const DeepCollectionEquality().equals(other.nickname, nickname) &&
            const DeepCollectionEquality().equals(other.birthday, birthday) &&
            const DeepCollectionEquality().equals(other.gender, gender));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(nickname),
      const DeepCollectionEquality().hash(birthday),
      const DeepCollectionEquality().hash(gender));

  @JsonKey(ignore: true)
  @override
  _$$_RegistrationStateCopyWith<_$_RegistrationState> get copyWith =>
      __$$_RegistrationStateCopyWithImpl<_$_RegistrationState>(
          this, _$identity);
}

abstract class _RegistrationState extends RegistrationState {
  const factory _RegistrationState(
      {required final FormModel nickname,
      required final FormModel birthday,
      required final RadioButtonModel<Gender> gender}) = _$_RegistrationState;
  const _RegistrationState._() : super._();

  @override
  FormModel get nickname;
  @override
  FormModel get birthday;
  @override
  RadioButtonModel<Gender> get gender;
  @override
  @JsonKey(ignore: true)
  _$$_RegistrationStateCopyWith<_$_RegistrationState> get copyWith =>
      throw _privateConstructorUsedError;
}
