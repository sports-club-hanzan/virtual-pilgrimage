import 'dart:math';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:health/health.dart';
import 'package:logger/logger.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:virtualpilgrimage/application/health/health_gateway.dart';
import 'package:virtualpilgrimage/domain/exception/get_health_exception.dart';
import 'package:virtualpilgrimage/domain/health/health_aggregation_result.codegen.dart';
import 'package:virtualpilgrimage/domain/user/health/health_by_period.codegen.dart';

/// health パッケージを利用してヘルスケア情報を集計する gateway の実装
class FlutterHealthGateway implements HealthGateway {
  FlutterHealthGateway(this._healthFactory, this._logger, this._crashlytics);

  final HealthFactory _healthFactory;
  final Logger _logger;
  final FirebaseCrashlytics _crashlytics;

  // 利用するHealth情報のタイプ
  final _healthTypes = {
    'android': [
      HealthDataType.STEPS,
      HealthDataType.DISTANCE_DELTA,
      HealthDataType.ACTIVE_ENERGY_BURNED,
    ],
    'ios': [
      HealthDataType.STEPS,
      HealthDataType.DISTANCE_WALKING_RUNNING,
      HealthDataType.ACTIVE_ENERGY_BURNED,
    ]
  };

  /// 指定した期間のみのヘルスケア情報を各OSの仕組みから取得
  ///
  /// [from] ヘルスケア情報を取得する起点となる時間
  /// [to] ヘルスケア情報を取得する終点となる時間
  @override
  Future<HealthAggregationResult> aggregateHealthByPeriod({
    required DateTime from,
    required DateTime to,
  }) async {
    final types = _healthTypes[defaultTargetPlatform.name.toLowerCase()]!;
    await _validateUsableHealthTypes(types);

    return _execute(() async {
      final Map<DateTime, HealthByPeriod> eachDay = {};
      // dt の日付 <= to の日付の間、ループを回して、日毎のヘルスケア情報を取得する
      for (var dt = from; to.isAfter(dt); dt = dt.add(const Duration(days: 1))) {
        final dtStartTime = tz.TZDateTime(tz.getLocation('Asia/Tokyo'), dt.year, dt.month, dt.day);
        // dt == from の時は時間を 00:00:00 とする
        if (dt != from) {
          dt = dtStartTime;
        }
        final health = await _getHealthData(
          dt,
          dtStartTime.add(const Duration(days: 1)).subtract(const Duration(microseconds: 1)),
          types,
        );
        eachDay[dtStartTime] = _aggregateHealthInfo(health);
      }

      var total = HealthByPeriod.getDefault();
      // 各日の合計値を集計
      eachDay.forEach((key, value) {
        total = total.merge(value);
      });
      return HealthAggregationResult(
        eachDay: eachDay,
        total: total,
      );
    });
  }

  /// 各OSごとの仕組みでヘルスケア情報を取得
  ///
  /// [from] 取得範囲の開始地点
  /// [to] 取得範囲の終了地点
  Future<List<HealthDataPoint>> _getHealthData(
    DateTime from,
    DateTime to,
    List<HealthDataType> types,
  ) async {
    DateTime trueFrom = from;
    DateTime trueTo = to;
    if (trueFrom.isAfter(trueTo)) {
      trueFrom = to;
      trueTo = from;
    }
    final healthData = await _healthFactory.getHealthDataFromTypes(trueFrom, trueTo, types);
    return HealthFactory.removeDuplicates(healthData);
  }

  /// 取得したヘルスケア情報をカテゴリごと集計して返す
  ///
  /// [rawPoints] 各OSごとの仕組みで取得したヘルスケア情報の生データ
  HealthByPeriod _aggregateHealthInfo(List<HealthDataPoint> rawPoints) {
    // 取得対象ごとに集計
    final Map<String, Map<String, num>> aggregateResult = {};
    final Map<String, DateTime> lastAggregationPair = {};
    rawPoints.sort((a, b) => b.dateFrom.compareTo(a.dateFrom));
    for (final p in rawPoints) {
      final key = '${p.sourceName}(${p.sourceId})';
      if (lastAggregationPair[key] != null) {
        // keyと最後に集計した時間が被っていたら集計をスキップ
        if (lastAggregationPair[key]!.isBefore(p.dateFrom)) {
          continue;
        }
      }
      // 集計終わりの時刻を格納
      lastAggregationPair[key] = p.dateFrom;
      final result = aggregateResult[key] ?? {'steps': 0, 'distance': 0, 'burnedCalorie': 0};
      // アプリで取り扱うヘルスケア情報はいずれも数値型なので、値を先に取得しておく
      final val = (p.value as NumericHealthValue).numericValue;
      // ignore: missing_enum_constant_in_switch
      switch (p.type) {
        // 歩数
        case HealthDataType.STEPS:
          result['steps'] = (result['steps'] ?? 0) + val;
          break;
        // 歩行距離[m]
        // Android: DISTANCE_DELTA
        // iOS: DISTANCE_WALKING_RUNNING
        // ref.  https://pub.dev/packages/health
        case HealthDataType.DISTANCE_DELTA:
        case HealthDataType.DISTANCE_WALKING_RUNNING:
          result['distance'] = (result['distance'] ?? 0) + val;
          break;
        // 消費カロリー[kcal]
        case HealthDataType.ACTIVE_ENERGY_BURNED:
          result['burnedCalorie'] = (result['burnedCalorie'] ?? 0) + val;
          break;
        // ignore: no_default_cases
        default:
          // 想定していない値が入ってきたときは開発中に気づけるようにログに出力する
          _logger.w('got unexpected Health Data Type [type][$p.type]');
          break;
      }
      // 上書き
      aggregateResult[key] = result;
    }
    // sourceId ごとに集計した結果からもっとも大きい値を参照
    num steps = 0;
    num distance = 0;
    num burnedCalorie = 0;
    for (final r in aggregateResult.values) {
      steps = max(steps, r['steps'] ?? 0);
      distance = max(distance, r['distance'] ?? 0);
      burnedCalorie = max(burnedCalorie, r['burnedCalorie'] ?? 0);
    }

    final msg =
        'health aggregation result: [steps][$steps][distance][$distance][burnedCalorie][$burnedCalorie][result][$aggregateResult]';
    _logger.i(msg);
    _crashlytics.log(msg);
    // アプリの性質上、カロリーや距離の精度は気にしなくていいため、小数点第一位で切り上げした値を利用
    // 最初から切り上げした値を加算すると誤差が大きくなるため、足し合わせる間は小数を持った状態で計算する実装としている
    return HealthByPeriod(
      steps: steps.ceil(),
      distance: distance.ceil(),
      burnedCalorie: burnedCalorie.ceil(),
    );
  }

  /// Health 情報を取得できるか権限チェック
  Future<void> _validateUsableHealthTypes(List<HealthDataType> types) async {
    final requested = await _healthFactory.requestAuthorization(types);
    if (!requested) {
      const message = 'get health information error because don\'t have health permission';
      _logger.e(message);
      throw GetHealthException(message: message, status: GetHealthExceptionStatus.notAuthorized);
    }
  }

  Future<T> _execute<T>(Future<T> Function() func) async {
    try {
      return func();
    } on HealthException catch (e) {
      throw GetHealthException(
        message: e.cause,
        status: GetHealthExceptionStatus.unknown,
        cause: e,
      );
    } on Exception catch (e) {
      throw GetHealthException(
        message: 'cause unknown error when update health info',
        status: GetHealthExceptionStatus.unknown,
        cause: e,
      );
    }
  }
}

class HealthPoint {
  HealthPoint({
    required this.value,
    required this.from,
    required this.to,
  });

  final num value;
  final DateTime from;
  final DateTime to;

  bool duplicate(HealthPoint point) {
    // どちらかの機関の開始時刻が、もう一方の機関の終了時刻よりも後の場合は重複しない
    if (from.isAfter(point.to) || point.from.isAfter(to)) {
      return false;
    }
    return true;
  }

  bool equals(HealthPoint point) {
    return value == point.value && from == point.from && to == point.to;
  }

  @override
  String toString() {
    return 'HealthPoint{value: $value, from: $from, to: $to}';
  }
}

class HealthAggregationPoint {
  HealthAggregationPoint({
    required this.value,
    required this.targetDate,
  });

  final num value;
  final DateTime targetDate;

  HealthAggregationPoint add(num value) {
    return HealthAggregationPoint(
      value: this.value + value,
      targetDate: targetDate,
    );
  }

  @override
  String toString() {
    return 'HealthAggregationPoint{value: $value, targetDate: $targetDate}';
  }
}
