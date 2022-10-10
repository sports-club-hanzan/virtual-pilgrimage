// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pilgrimage_info.codegen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PilgrimageInfo _$$_PilgrimageInfoFromJson(Map<String, dynamic> json) =>
    _$_PilgrimageInfo(
      id: json['id'] as String,
      nowPilgrimageId: json['nowPilgrimageId'] as int? ?? 1,
      lap: json['lap'] as int? ?? 1,
      movingDistance: (json['movingDistance'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$_PilgrimageInfoToJson(_$_PilgrimageInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nowPilgrimageId': instance.nowPilgrimageId,
      'lap': instance.lap,
      'movingDistance': instance.movingDistance,
    };
