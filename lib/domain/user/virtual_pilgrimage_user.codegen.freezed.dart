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
  String get nickname =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(
      fromJson: _GenderConverter.intToGender,
      toJson: _GenderConverter.genderToInt)
  Gender get gender =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(
      fromJson: _FirestoreTimestampConverter.timestampToDateTime,
      toJson: _FirestoreTimestampConverter.dateTimeToTimestamp)
  DateTime get birthDay => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get userIconUrl => throw _privateConstructorUsedError;
  @JsonKey(
      defaultValue: null,
      nullable: true,
      fromJson: _BitmapConverter.stringToBitmap)
  BitmapDescriptor get userIcon => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: _UserStatusConverter.intToUserStatus,
      toJson: _UserStatusConverter.userStatusToInt)
  UserStatus get userStatus =>
      throw _privateConstructorUsedError; // TODO(s14t284): 以下の情報を含める
// ヘルスケアから得られる歩数などの情報
// 現在地のお遍路で巡っているお寺の情報
  String get walkCount => throw _privateConstructorUsedError;

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
      @JsonKey(defaultValue: null, nullable: true, fromJson: _BitmapConverter.stringToBitmap)
          BitmapDescriptor userIcon,
      @JsonKey(fromJson: _UserStatusConverter.intToUserStatus, toJson: _UserStatusConverter.userStatusToInt)
          UserStatus userStatus,
      String walkCount});
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
    Object? userIcon = freezed,
    Object? userStatus = freezed,
    Object? walkCount = freezed,
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
      userIcon: userIcon == freezed
          ? _value.userIcon
          : userIcon // ignore: cast_nullable_to_non_nullable
              as BitmapDescriptor,
      userStatus: userStatus == freezed
          ? _value.userStatus
          : userStatus // ignore: cast_nullable_to_non_nullable
              as UserStatus,
      walkCount: walkCount == freezed
          ? _value.walkCount
          : walkCount // ignore: cast_nullable_to_non_nullable
              as String,
    ));
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
      @JsonKey(defaultValue: null, nullable: true, fromJson: _BitmapConverter.stringToBitmap)
          BitmapDescriptor userIcon,
      @JsonKey(fromJson: _UserStatusConverter.intToUserStatus, toJson: _UserStatusConverter.userStatusToInt)
          UserStatus userStatus,
      String walkCount});
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
    Object? userIcon = freezed,
    Object? userStatus = freezed,
    Object? walkCount = freezed,
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
      userIcon: userIcon == freezed
          ? _value.userIcon
          : userIcon // ignore: cast_nullable_to_non_nullable
              as BitmapDescriptor,
      userStatus: userStatus == freezed
          ? _value.userStatus
          : userStatus // ignore: cast_nullable_to_non_nullable
              as UserStatus,
      walkCount: walkCount == freezed
          ? _value.walkCount
          : walkCount // ignore: cast_nullable_to_non_nullable
              as String,
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
      this.userIconUrl = 'https://maps.google.com/mapfiles/kml/shapes/info-i_maps.png',
      @JsonKey(defaultValue: null, nullable: true, fromJson: _BitmapConverter.stringToBitmap)
          this.userIcon = BitmapDescriptor.defaultMarker,
      @JsonKey(fromJson: _UserStatusConverter.intToUserStatus, toJson: _UserStatusConverter.userStatusToInt)
          this.userStatus = UserStatus.temporary,
      this.walkCount = '0'})
      : super._();

  factory _$_VirtualPilgrimageUser.fromJson(Map<String, dynamic> json) =>
      _$$_VirtualPilgrimageUserFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String nickname;
// ignore: invalid_annotation_target
  @override
  @JsonKey(
      fromJson: _GenderConverter.intToGender,
      toJson: _GenderConverter.genderToInt)
  final Gender gender;
// ignore: invalid_annotation_target
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
      defaultValue: null,
      nullable: true,
      fromJson: _BitmapConverter.stringToBitmap)
  final BitmapDescriptor userIcon;
  @override
  @JsonKey(
      fromJson: _UserStatusConverter.intToUserStatus,
      toJson: _UserStatusConverter.userStatusToInt)
  final UserStatus userStatus;
// TODO(s14t284): 以下の情報を含める
// ヘルスケアから得られる歩数などの情報
// 現在地のお遍路で巡っているお寺の情報
  @override
  @JsonKey()
  final String walkCount;

  @override
  String toString() {
    return 'VirtualPilgrimageUser(id: $id, nickname: $nickname, gender: $gender, birthDay: $birthDay, email: $email, userIconUrl: $userIconUrl, userIcon: $userIcon, userStatus: $userStatus, walkCount: $walkCount)';
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
            const DeepCollectionEquality().equals(other.userIcon, userIcon) &&
            const DeepCollectionEquality()
                .equals(other.userStatus, userStatus) &&
            const DeepCollectionEquality().equals(other.walkCount, walkCount));
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
      const DeepCollectionEquality().hash(userIcon),
      const DeepCollectionEquality().hash(userStatus),
      const DeepCollectionEquality().hash(walkCount));

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
      @JsonKey(defaultValue: null, nullable: true, fromJson: _BitmapConverter.stringToBitmap)
          final BitmapDescriptor userIcon,
      @JsonKey(fromJson: _UserStatusConverter.intToUserStatus, toJson: _UserStatusConverter.userStatusToInt)
          final UserStatus userStatus,
      final String walkCount}) = _$_VirtualPilgrimageUser;
  const _VirtualPilgrimageUser._() : super._();

  factory _VirtualPilgrimageUser.fromJson(Map<String, dynamic> json) =
      _$_VirtualPilgrimageUser.fromJson;

  @override
  String get id;
  @override
  String get nickname;
  @override // ignore: invalid_annotation_target
  @JsonKey(
      fromJson: _GenderConverter.intToGender,
      toJson: _GenderConverter.genderToInt)
  Gender get gender;
  @override // ignore: invalid_annotation_target
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
      defaultValue: null,
      nullable: true,
      fromJson: _BitmapConverter.stringToBitmap)
  BitmapDescriptor get userIcon;
  @override
  @JsonKey(
      fromJson: _UserStatusConverter.intToUserStatus,
      toJson: _UserStatusConverter.userStatusToInt)
  UserStatus get userStatus;
  @override // TODO(s14t284): 以下の情報を含める
// ヘルスケアから得られる歩数などの情報
// 現在地のお遍路で巡っているお寺の情報
  String get walkCount;
  @override
  @JsonKey(ignore: true)
  _$$_VirtualPilgrimageUserCopyWith<_$_VirtualPilgrimageUser> get copyWith =>
      throw _privateConstructorUsedError;
}
