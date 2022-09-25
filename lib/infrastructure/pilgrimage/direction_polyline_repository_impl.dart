import 'dart:async';
import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_crashlytics_provider.dart';
import 'package:virtualpilgrimage/infrastructure/pilgrimage/direction_polyline_response.codegen.dart';
import 'package:virtualpilgrimage/logger.dart';

final directionPolylineRepositoryPresenter = Provider(
  (ref) => DirectionPolylineRepositoryImpl(
    ref.read(loggerProvider),
    ref.read(firebaseCrashlyticsProvider),
  ),
);

// Map上で2点間の最適な経路を取得するリポジトリ
class DirectionPolylineRepositoryImpl {
  DirectionPolylineRepositoryImpl(this._logger, this._crashlytics);

  final Logger _logger;
  final FirebaseCrashlytics _crashlytics;

  // Direction API の URL
  final _authority = 'maps.googleapis.com';
  final _endpoint = 'maps/api/directions/json';

  // お遍路なので、walking モード
  // Direction API に指定するパラメータ
  final _directionMode = 'walking';

  final _apiKey = const String.fromEnvironment('DIRECTION_KEY');

  // 2つ
  Future<List<LatLng>> getPolyline(LatLng origin, LatLng destination) async {
    // TODO(s14t284): 同じレスポンスが得られるhttp通信を毎回実行するのは重いので必要に応じてキャッシュで経路を保存しておくか検討する

    final params = {
      'origin': '${origin.latitude},${origin.longitude}',
      'destination': '${destination.latitude},${destination.longitude}',
      'mode': _directionMode,
      // 以下の経路を無効化する
      // tolls – 有料道路
      // highways – ⾼速道路
      // ferries – フェリー
      'avoidHighways': 'false',
      'avoidFerries': 'false',
      'avoidTolls': 'false',
      'key': _apiKey,
    };

    final url = Uri.https(_authority, _endpoint, params);
    _logger.d('request direction api for get polyline of temples [url][$url]');
    final resp = await http.get(url).timeout(const Duration(seconds: 1));
    if (resp.statusCode != 200) {
      final m =
          'get direction polyline request error [statusCode][${resp.statusCode}][body][${resp.body}';
      _logger.e(m);
      unawaited(_crashlytics.log(m));
      return [];
    }
    final dpResp = DirectionPolylineResponse.fromJson(json.decode(resp.body));
    if (dpResp.status.toLowerCase() != 'ok' || dpResp.routes.isEmpty) {
      final m =
          'get direction polyline error [status][${dpResp.status}][errorMessage][${dpResp.errorMessage}]';
      _logger.e(m);
      unawaited(_crashlytics.log(m));
      return [];
    }

    _logger.d(dpResp);
    return decodePolyline(dpResp.routes.first.overviewPolyline.points)
        .map((e) => LatLng(e.first.toDouble(), e.last.toDouble()))
        .toList();
  }
}
