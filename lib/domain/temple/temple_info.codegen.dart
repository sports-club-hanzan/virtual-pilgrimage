import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';

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

    // お寺のうんちく
    @Default('お寺の詳細情報')
        String knowledge,

    // スタンプの画像パス
    @Default('https://firebasestorage.googleapis.com/v0/b/virtual-pilgrimage-dev.appspot.com/o/temples%2F1%2Fstamp.jpeg?alt=media&token=b3fe42f9-b94b-43f2-8a5d-b2f217be541f')
        String stampImage,

    // お寺の座標
    @JsonKey(
      fromJson: _geoPointFromJson,
      toJson: _geoPointToJson,
    )
        required GeoPoint geoPoint,
    @Default([])
        List<String> images,
  }) = _TempleInfo;

  const TempleInfo._();

  factory TempleInfo.fromJson(Map<String, dynamic> json) => _$TempleInfoFromJson(json);

  /// お寺の座標を緯度経度に変換
  List<LatLng> decodeGeoPoint() =>
      // エンコードされた経路文字列を経路の緯度・経度のリストにして返す
      decodePolyline(encodedPoints)
          .map((ep) => LatLng(ep.first.toDouble(), ep.last.toDouble()))
          .toList();
}

GeoPoint _geoPointFromJson(GeoPoint json) => json;

GeoPoint _geoPointToJson(GeoPoint geoPoint) => geoPoint;
