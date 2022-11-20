import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as toolkit;

final virtualPositionCalculatorProvider = Provider((_) => VirtualPositionCalculator());

// 経路情報（リスト）から仮想的なMap上の現在地を計算する Domain Service
class VirtualPositionCalculator {
  /// お遍路の進捗を計算
  ///
  /// [latlngs] 計算対象のユーザ情報
  /// [meter] 現在地点
  LatLng execute(List<LatLng> latlngs, num meter) {
    num distance = meter;
    for (int i = 0; i < latlngs.length - 1; i++) {
      final from = toolkit.LatLng(latlngs[i].latitude, latlngs[i].longitude);
      final to = toolkit.LatLng(latlngs[i + 1].latitude, latlngs[i + 1].longitude);
      final num d = toolkit.SphericalUtil.computeDistanceBetween(from, to);
      if (distance < d) {
        // fromからtoの間にいる場合は割合で表示する
        final latlng = toolkit.SphericalUtil.interpolate(from, to, distance / d);
        return LatLng(latlng.latitude, latlng.longitude);
      } else {
        // fromからtoの距離をdistanceが超える場合は次の区間で計算する
        distance = distance - d;
      }
    }

    // 経路リストを超える場合は次のお寺にほぼ到着している
    return latlngs.last;
  }
}
