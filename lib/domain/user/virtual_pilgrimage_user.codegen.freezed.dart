// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'virtual_pilgrimage_user.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VirtualPilgrimageUser _$VirtualPilgrimageUserFromJson(
    Map<String, dynamic> json) {
  return _VirtualPilgrimageUser.fromJson(json);
}

/// @nodoc
mixin _$VirtualPilgrimageUser {
  String get id => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: _GenderConverter.intToGender,
      toJson: _GenderConverter.genderToInt)
  Gender get gender => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: _FirestoreTimestampConverter.timestampToDateTime,
      toJson: _FirestoreTimestampConverter.dateTimeToTimestamp)
  DateTime get birthDay => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get userIconUrl => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: _UserStatusConverter.intToUserStatus,
      toJson: _UserStatusConverter.userStatusToInt)
  UserStatus get userStatus => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: _FirestoreTimestampConverter.timestampToDateTime,
      toJson: _FirestoreTimestampConverter.dateTimeToTimestamp)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: _FirestoreTimestampConverter.timestampToDateTime,
      toJson: _FirestoreTimestampConverter.dateTimeToTimestamp)
  DateTime get updatedAt => throw _privateConstructorUsedError;
  HealthInfo? get health => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VirtualPilgrimageUserCopyWith<VirtualPilgrimageUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VirtualPilgrimageUserCopyWith<$Res> {
  factory $VirtualPilgrimageUserCopyWith(VirtualPilgrimageUser value,
          $Res Function(VirtualPilgrimageUser) then) =
      _$VirtualPilgrimageUserCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String nickname,
      @JsonKey(fromJson: _GenderConverter.intToGender, toJson: _GenderConverter.genderToInt)
          Gender gender,
      @JsonKey(fromJson: _FirestoreTimestampConverter.timestampToDateTime, toJson: _FirestoreTimestampConverter.dateTimeToTimestamp)
          DateTime birthDay,
      String email,
      String userIconUrl,
      @JsonKey(fromJson: _UserStatusConverter.intToUserStatus, toJson: _UserStatusConverter.userStatusToInt)
          UserStatus userStatus,
      @JsonKey(fromJson: _FirestoreTimestampConverter.timestampToDateTime, toJson: _FirestoreTimestampConverter.dateTimeToTimestamp)
          DateTime createdAt,
      @JsonKey(fromJson: _FirestoreTimestampConverter.timestampToDateTime, toJson: _FirestoreTimestampConverter.dateTimeToTimestamp)
          DateTime updatedAt,
      HealthInfo? health});

  $HealthInfoCopyWith<$Res>? get health;
}

/// @nodoc
class _$VirtualPilgrimageUserCopyWithImpl<$Res>
    implements $VirtualPilgrimageUserCopyWith<$Res> {
  _$VirtualPilgrimageUserCopyWithImpl(this._value, this._then);

  final VirtualPilgrimageUser _value;
  // ignore: unused_field
  final $Res Function(VirtualPilgrimageUser) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? nickname = freezed,
    Object? gender = freezed,
    Object? birthDay = freezed,
    Object? email = freezed,
    Object? userIconUrl = freezed,
    Object? userStatus = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? health = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender,
      birthDay: birthDay == freezed
          ? _value.birthDay
          : birthDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      userIconUrl: userIconUrl == freezed
          ? _value.userIconUrl
          : userIconUrl // ignore: cast_nullable_to_non_nullable
              as String,
      userStatus: userStatus == freezed
          ? _value.userStatus
          : userStatus // ignore: cast_nullable_to_non_nullable
              as UserStatus,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      health: health == freezed
          ? _value.health
          : health // ignore: cast_nullable_to_non_nullable
              as HealthInfo?,
    ));
  }

  @override
  $HealthInfoCopyWith<$Res>? get health {
    if (_value.health == null) {
      return null;
    }

    return $HealthInfoCopyWith<$Res>(_value.health!, (value) {
      return _then(_value.copyWith(health: value));
    });
  }
}

/// @nodoc
abstract class _$$_VirtualPilgrimageUserCopyWith<$Res>
    implements $VirtualPilgrimageUserCopyWith<$Res> {
  factory _$$_VirtualPilgrimageUserCopyWith(_$_VirtualPilgrimageUser value,
          $Res Function(_$_VirtualPilgrimageUser) then) =
      __$$_VirtualPilgrimageUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String nickname,
      @JsonKey(fromJson: _GenderConverter.intToGender, toJson: _GenderConverter.genderToInt)
          Gender gender,
      @JsonKey(fromJson: _FirestoreTimestampConverter.timestampToDateTime, toJson: _FirestoreTimestampConverter.dateTimeToTimestamp)
          DateTime birthDay,
      String email,
      String userIconUrl,
      @JsonKey(fromJson: _UserStatusConverter.intToUserStatus, toJson: _UserStatusConverter.userStatusToInt)
          UserStatus userStatus,
      @JsonKey(fromJson: _FirestoreTimestampConverter.timestampToDateTime, toJson: _FirestoreTimestampConverter.dateTimeToTimestamp)
          DateTime createdAt,
      @JsonKey(fromJson: _FirestoreTimestampConverter.timestampToDateTime, toJson: _FirestoreTimestampConverter.dateTimeToTimestamp)
          DateTime updatedAt,
      HealthInfo? health});

  @override
  $HealthInfoCopyWith<$Res>? get health;
}

/// @nodoc
class __$$_VirtualPilgrimageUserCopyWithImpl<$Res>
    extends _$VirtualPilgrimageUserCopyWithImpl<$Res>
    implements _$$_VirtualPilgrimageUserCopyWith<$Res> {
  __$$_VirtualPilgrimageUserCopyWithImpl(_$_VirtualPilgrimageUser _value,
      $Res Function(_$_VirtualPilgrimageUser) _then)
      : super(_value, (v) => _then(v as _$_VirtualPilgrimageUser));

  @override
  _$_VirtualPilgrimageUser get _value =>
      super._value as _$_VirtualPilgrimageUser;

  @override
  $Res call({
    Object? id = freezed,
    Object? nickname = freezed,
    Object? gender = freezed,
    Object? birthDay = freezed,
    Object? email = freezed,
    Object? userIconUrl = freezed,
    Object? userStatus = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? health = freezed,
  }) {
    return _then(_$_VirtualPilgrimageUser(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender,
      birthDay: birthDay == freezed
          ? _value.birthDay
          : birthDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      userIconUrl: userIconUrl == freezed
          ? _value.userIconUrl
          : userIconUrl // ignore: cast_nullable_to_non_nullable
              as String,
      userStatus: userStatus == freezed
          ? _value.userStatus
          : userStatus // ignore: cast_nullable_to_non_nullable
              as UserStatus,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      health: health == freezed
          ? _value.health
          : health // ignore: cast_nullable_to_non_nullable
              as HealthInfo?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_VirtualPilgrimageUser extends _VirtualPilgrimageUser {
  const _$_VirtualPilgrimageUser(
      {this.id = '',
      this.nickname = '',
      @JsonKey(fromJson: _GenderConverter.intToGender, toJson: _GenderConverter.genderToInt)
          this.gender = Gender.unknown,
      @JsonKey(fromJson: _FirestoreTimestampConverter.timestampToDateTime, toJson: _FirestoreTimestampConverter.dateTimeToTimestamp)
          required this.birthDay,
      this.email = '',
      this.userIconUrl = '',
      @JsonKey(fromJson: _UserStatusConverter.intToUserStatus, toJson: _UserStatusConverter.userStatusToInt)
          this.userStatus = UserStatus.temporary,
      @JsonKey(fromJson: _FirestoreTimestampConverter.timestampToDateTime, toJson: _FirestoreTimestampConverter.dateTimeToTimestamp)
          required this.createdAt,
      @JsonKey(fromJson: _FirestoreTimestampConverter.timestampToDateTime, toJson: _FirestoreTimestampConverter.dateTimeToTimestamp)
          required this.updatedAt,
      this.health})
      : super._();

  factory _$_VirtualPilgrimageUser.fromJson(Map<String, dynamic> json) =>
      _$$_VirtualPilgrimageUserFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String nickname;
  @override
  @JsonKey(
      fromJson: _GenderConverter.intToGender,
      toJson: _GenderConverter.genderToInt)
  final Gender gender;
  @override
  @JsonKey(
      fromJson: _FirestoreTimestampConverter.timestampToDateTime,
      toJson: _FirestoreTimestampConverter.dateTimeToTimestamp)
  final DateTime birthDay;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String userIconUrl;
  @override
  @JsonKey(
      fromJson: _UserStatusConverter.intToUserStatus,
      toJson: _UserStatusConverter.userStatusToInt)
  final UserStatus userStatus;
  @override
  @JsonKey(
      fromJson: _FirestoreTimestampConverter.timestampToDateTime,
      toJson: _FirestoreTimestampConverter.dateTimeToTimestamp)
  final DateTime createdAt;
  @override
  @JsonKey(
      fromJson: _FirestoreTimestampConverter.timestampToDateTime,
      toJson: _FirestoreTimestampConverter.dateTimeToTimestamp)
  final DateTime updatedAt;
  @override
  final HealthInfo? health;

  @override
  String toString() {
    return 'VirtualPilgrimageUser(id: $id, nickname: $nickname, gender: $gender, birthDay: $birthDay, email: $email, userIconUrl: $userIconUrl, userStatus: $userStatus, createdAt: $createdAt, updatedAt: $updatedAt, health: $health)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VirtualPilgrimageUser &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.nickname, nickname) &&
            const DeepCollectionEquality().equals(other.gender, gender) &&
            const DeepCollectionEquality().equals(other.birthDay, birthDay) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality()
                .equals(other.userIconUrl, userIconUrl) &&
            const DeepCollectionEquality()
                .equals(other.userStatus, userStatus) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            const DeepCollectionEquality().equals(other.health, health));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(nickname),
      const DeepCollectionEquality().hash(gender),
      const DeepCollectionEquality().hash(birthDay),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(userIconUrl),
      const DeepCollectionEquality().hash(userStatus),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt),
      const DeepCollectionEquality().hash(health));

  @JsonKey(ignore: true)
  @override
  _$$_VirtualPilgrimageUserCopyWith<_$_VirtualPilgrimageUser> get copyWith =>
      __$$_VirtualPilgrimageUserCopyWithImpl<_$_VirtualPilgrimageUser>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VirtualPilgrimageUserToJson(
      this,
    );
  }
}

abstract class _VirtualPilgrimageUser extends VirtualPilgrimageUser {
  const factory _VirtualPilgrimageUser(
      {final String id,
      final String nickname,
      @JsonKey(fromJson: _GenderConverter.intToGender, toJson: _GenderConverter.genderToInt)
          final Gender gender,
      @JsonKey(fromJson: _FirestoreTimestampConverter.timestampToDateTime, toJson: _FirestoreTimestampConverter.dateTimeToTimestamp)
          required final DateTime birthDay,
      final String email,
      final String userIconUrl,
      @JsonKey(fromJson: _UserStatusConverter.intToUserStatus, toJson: _UserStatusConverter.userStatusToInt)
          final UserStatus userStatus,
      @JsonKey(fromJson: _FirestoreTimestampConverter.timestampToDateTime, toJson: _FirestoreTimestampConverter.dateTimeToTimestamp)
          required final DateTime createdAt,
      @JsonKey(fromJson: _FirestoreTimestampConverter.timestampToDateTime, toJson: _FirestoreTimestampConverter.dateTimeToTimestamp)
          required final DateTime updatedAt,
      final HealthInfo? health}) = _$_VirtualPilgrimageUser;
  const _VirtualPilgrimageUser._() : super._();

  factory _VirtualPilgrimageUser.fromJson(Map<String, dynamic> json) =
      _$_VirtualPilgrimageUser.fromJson;

  @override
  String get id;
  @override
  String get nickname;
  @override
  @JsonKey(
      fromJson: _GenderConverter.intToGender,
      toJson: _GenderConverter.genderToInt)
  Gender get gender;
  @override
  @JsonKey(
      fromJson: _FirestoreTimestampConverter.timestampToDateTime,
      toJson: _FirestoreTimestampConverter.dateTimeToTimestamp)
  DateTime get birthDay;
  @override
  String get email;
  @override
  String get userIconUrl;
  @override
  @JsonKey(
      fromJson: _UserStatusConverter.intToUserStatus,
      toJson: _UserStatusConverter.userStatusToInt)
  UserStatus get userStatus;
  @override
  @JsonKey(
      fromJson: _FirestoreTimestampConverter.timestampToDateTime,
      toJson: _FirestoreTimestampConverter.dateTimeToTimestamp)
  DateTime get createdAt;
  @override
  @JsonKey(
      fromJson: _FirestoreTimestampConverter.timestampToDateTime,
      toJson: _FirestoreTimestampConverter.dateTimeToTimestamp)
  DateTime get updatedAt;
  @override
  HealthInfo? get health;
  @override
  @JsonKey(ignore: true)
  _$$_VirtualPilgrimageUserCopyWith<_$_VirtualPilgrimageUser> get copyWith =>
      throw _privateConstructorUsedError;
}
