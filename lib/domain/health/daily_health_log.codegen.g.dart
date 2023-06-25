// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_health_log.codegen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DailyHealthLog _$$_DailyHealthLogFromJson(Map<String, dynamic> json) =>
    _$_DailyHealthLog(
      userId: json['userId'] as String,
      steps: json['steps'] as int,
      distance: json['distance'] as int,
      burnedCalorie: json['burnedCalorie'] as int,
      date: FirestoreTimestampConverter.timestampToDateTime(
          json['date'] as Timestamp),
      expiredAt: FirestoreTimestampConverter.timestampToDateTime(
          json['expiredAt'] as Timestamp),
    );

Map<String, dynamic> _$$_DailyHealthLogToJson(_$_DailyHealthLog instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'steps': instance.steps,
      'distance': instance.distance,
      'burnedCalorie': instance.burnedCalorie,
      'date': FirestoreTimestampConverter.dateTimeToTimestamp(instance.date),
      'expiredAt':
          FirestoreTimestampConverter.dateTimeToTimestamp(instance.expiredAt),
    };
