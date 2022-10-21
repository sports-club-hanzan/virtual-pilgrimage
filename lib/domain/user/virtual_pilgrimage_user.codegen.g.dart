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
      email: json['email'] as String? ?? '',
      userIconUrl: json['userIconUrl'] as String? ??
          'https://maps.google.com/mapfiles/kml/shapes/info-i_maps.png',
      userStatus: json['userStatus'] == null
          ? UserStatus.temporary
          : _UserStatusConverter.intToUserStatus(json['userStatus'] as int),
      createdAt: _FirestoreTimestampConverter.timestampToDateTime(
          json['createdAt'] as Timestamp),
      updatedAt: _FirestoreTimestampConverter.timestampToDateTime(
          json['updatedAt'] as Timestamp),
      health: json['health'] == null
          ? null
          : HealthInfo.fromJson(json['health'] as Map<String, dynamic>),
      pilgrimage:
          PilgrimageInfo.fromJson(json['pilgrimage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_VirtualPilgrimageUserToJson(
        _$_VirtualPilgrimageUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'gender': _GenderConverter.genderToInt(instance.gender),
      'birthDay':
          _FirestoreTimestampConverter.dateTimeToTimestamp(instance.birthDay),
      'email': instance.email,
      'userIconUrl': instance.userIconUrl,
      'userStatus': _UserStatusConverter.userStatusToInt(instance.userStatus),
      'createdAt':
          _FirestoreTimestampConverter.dateTimeToTimestamp(instance.createdAt),
      'updatedAt':
          _FirestoreTimestampConverter.dateTimeToTimestamp(instance.updatedAt),
      'health': instance.health?.toJson(),
      'pilgrimage': instance.pilgrimage.toJson(),
    };
