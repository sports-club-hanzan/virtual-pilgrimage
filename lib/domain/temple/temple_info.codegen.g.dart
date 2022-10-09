// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temple_info.codegen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TempleInfo _$$_TempleInfoFromJson(Map<String, dynamic> json) =>
    _$_TempleInfo(
      id: json['id'] as int,
      name: json['name'] as String,
      prefecture: json['prefecture'] as String,
      address: json['address'] as String,
      nextDistance: json['nextDistance'] as int,
      totalSteps: json['totalSteps'] as int,
      geoPoint: _geoPointFromJson(json['geoPoint'] as GeoPoint),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => TempleImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_TempleInfoToJson(_$_TempleInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'prefecture': instance.prefecture,
      'address': instance.address,
      'nextDistance': instance.nextDistance,
      'totalSteps': instance.totalSteps,
      'geoPoint': _geoPointToJson(instance.geoPoint),
      'images': instance.images,
    };
