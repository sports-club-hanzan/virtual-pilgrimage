import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'temple_info.codegen.freezed.dart';
part 'temple_info.codegen.g.dart';

@freezed
class TempleInfo with _$TempleInfo {
  const factory TempleInfo({
    // ID, お寺の番号
    required int id,

    // 名前
    required String name,

    // 都道府県
    required String prefecture,

    // 住所
    required String address,

    // 次のお寺までの距離
    required int distance,

    // 次のお寺までの経路(エンコード文字列)
    required String encodedPoints,

    // お寺の座標
    @JsonKey(
      fromJson: _geoPointFromJson,
      toJson: _geoPointToJson,
    )
        required GeoPoint geoPoint,
    @Default([]) List<String> images,
  }) = _TempleInfo;

  const TempleInfo._();

  factory TempleInfo.fromJson(Map<String, dynamic> json) => _$TempleInfoFromJson(json);
}

GeoPoint _geoPointFromJson(GeoPoint json) => json;

GeoPoint _geoPointToJson(GeoPoint geoPoint) => geoPoint;
