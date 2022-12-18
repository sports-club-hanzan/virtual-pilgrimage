// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deleted_user.codegen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DeletedUser _$$_DeletedUserFromJson(Map<String, dynamic> json) =>
    _$_DeletedUser(
      id: json['id'] as String,
      deletedAt: FirestoreTimestampConverter.timestampToDateTime(
          json['deletedAt'] as Timestamp),
    );

Map<String, dynamic> _$$_DeletedUserToJson(_$_DeletedUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deletedAt':
          FirestoreTimestampConverter.dateTimeToTimestamp(instance.deletedAt),
    };
