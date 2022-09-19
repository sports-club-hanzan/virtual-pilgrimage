// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_by_period.codegen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HealthByPeriod _$$_HealthByPeriodFromJson(Map<String, dynamic> json) =>
    _$_HealthByPeriod(
      steps: json['steps'] as int,
      distance: json['distance'] as int,
      burnedCalorie: json['burnedCalorie'] as int,
    );

Map<String, dynamic> _$$_HealthByPeriodToJson(_$_HealthByPeriod instance) =>
    <String, dynamic>{
      'steps': instance.steps,
      'distance': instance.distance,
      'burnedCalorie': instance.burnedCalorie,
    };
