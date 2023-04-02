// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_health.codegen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserHealth _$$_UserHealthFromJson(Map<String, dynamic> json) =>
    _$_UserHealth(
      userId: json['userId'] as String,
      steps: json['steps'] as int,
      distance: json['distance'] as int,
      burnedCalorie: json['burnedCalorie'] as int,
      date: FirestoreTimestampConverter.timestampToDateTime(
          json['date'] as Timestamp),
      expiredAt: FirestoreTimestampConverter.timestampToDateTime(
          json['expiredAt'] as Timestamp),
    );

Map<String, dynamic> _$$_UserHealthToJson(_$_UserHealth instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'steps': instance.steps,
      'distance': instance.distance,
      'burnedCalorie': instance.burnedCalorie,
      'date': FirestoreTimestampConverter.dateTimeToTimestamp(instance.date),
      'expiredAt':
          FirestoreTimestampConverter.dateTimeToTimestamp(instance.expiredAt),
    };
