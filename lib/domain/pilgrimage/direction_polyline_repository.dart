import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_crashlytics_provider.dart';
import 'package:virtualpilgrimage/infrastructure/pilgrimage/direction_polyline_repository_impl.dart';
import 'package:virtualpilgrimage/logger.dart';

final directionPolylineRepositoryPresenter = Provider(
  (ref) => DirectionPolylineRepositoryImpl(
    ref.read(loggerProvider),
    ref.read(firebaseCrashlyticsProvider),
  ),
);

// Map上で2点間の最適な経路を取得するリポジトリ
abstract class DirectionPolylineRepository {
  /// 2点間の経路を導出して返す
  ///
  /// [origin] スタート地点
  /// [destination] ゴール地点
  Future<List<LatLng>> getPolylines({required LatLng origin, required LatLng destination});
}
