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
      knowledge: json['knowledge'] as String? ?? 'お寺の詳細情報',
      stampImage: json['stampImage'] as String? ??
          'https://firebasestorage.googleapis.com/v0/b/virtual-pilgrimage-dev.appspot.com/o/temples%2F1%2Fstamp.jpeg?alt=media&token=b3fe42f9-b94b-43f2-8a5d-b2f217be541f',
      geoPoint:
          _GeoPointConverter.geoPointFromJson(json['geoPoint'] as GeoPoint),
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
      'stampImage': instance.stampImage,
      'geoPoint': _GeoPointConverter.geoPointToJson(instance.geoPoint),
      'images': instance.images,
    };
