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
      distance: json['distance'] as int,
      encodedPoints: json['encodedPoints'] as String,
      knowledge: json['knowledge'] as String? ??
          'テストテストテストテトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストトテストテストストテストテストテストテスト',
      geoPoint: _geoPointFromJson(json['geoPoint'] as GeoPoint),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_TempleInfoToJson(_$_TempleInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'prefecture': instance.prefecture,
      'address': instance.address,
      'distance': instance.distance,
      'encodedPoints': instance.encodedPoints,
      'knowledge': instance.knowledge,
      'geoPoint': _geoPointToJson(instance.geoPoint),
      'images': instance.images,
    };
