// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'virtual_pilgrimage_user.codegen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VirtualPilgrimageUser _$$_VirtualPilgrimageUserFromJson(
        Map<String, dynamic> json) =>
    _$_VirtualPilgrimageUser(
      id: json['id'] as String? ?? '',
      nickname: json['nickname'] as String? ?? '',
      gender: json['gender'] == null
          ? Gender.unknown
          : _GenderConverter.intToGender(json['gender'] as int),
      birthDay: _FirestoreTimestampConverter.timestampToDateTime(
          json['birthDay'] as Timestamp),
      userIconUrl: json['userIconUrl'] as String? ?? '',
      userStatus: json['userStatus'] == null
          ? UserStatus.temporary
          : _UserStatusConverter.intToUserStatus(json['userStatus'] as int),
    );

Map<String, dynamic> _$$_VirtualPilgrimageUserToJson(
        _$_VirtualPilgrimageUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'gender': _GenderConverter.genderToInt(instance.gender),
      'birthDay':
          _FirestoreTimestampConverter.dateTimeToTimestamp(instance.birthDay),
      'userIconUrl': instance.userIconUrl,
      'userStatus': _UserStatusConverter.userStatusToInt(instance.userStatus),
    };
