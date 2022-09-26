// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_info.codegen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HealthInfo _$$_HealthInfoFromJson(Map<String, dynamic> json) =>
    _$_HealthInfo(
      yesterday:
          HealthByPeriod.fromJson(json['yesterday'] as Map<String, dynamic>),
      week: HealthByPeriod.fromJson(json['week'] as Map<String, dynamic>),
      month: HealthByPeriod.fromJson(json['month'] as Map<String, dynamic>),
      updatedAt: _FirestoreTimestampConverter.timestampToDateTime(
          json['updatedAt'] as Timestamp),
      totalSteps: json['totalSteps'] as int,
      totalDistance: json['totalDistance'] as int,
    );

Map<String, dynamic> _$$_HealthInfoToJson(_$_HealthInfo instance) =>
    <String, dynamic>{
      'yesterday': instance.yesterday.toJson(),
      'week': instance.week.toJson(),
      'month': instance.month.toJson(),
      'updatedAt':
          _FirestoreTimestampConverter.dateTimeToTimestamp(instance.updatedAt),
      'totalSteps': instance.totalSteps,
      'totalDistance': instance.totalDistance,
    };
