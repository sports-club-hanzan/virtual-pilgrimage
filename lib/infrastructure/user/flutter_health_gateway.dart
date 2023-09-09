import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:health/health.dart';
import 'package:logger/logger.dart';
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
        final dtStartTime = DateTime(dt.year, dt.month, dt.day);
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
    final points = _splitHealthDataPointsWithType(rawPoints);
    // 取得対象ごとに集計
    // ignore: prefer_int_literals
    final steps = points.$1.fold(0.0, _sumHealthPointValue);
    // ignore: prefer_int_literals
    final distance = points.$2.fold(0.0, _sumHealthPointValue);
    // ignore: prefer_int_literals
    final burnedCalorie = points.$3.fold(0.0, _sumHealthPointValue);

    final msg =
        'health aggregation result: [steps][$steps][distance][$distance][burnedCalorie][$burnedCalorie]';
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

  (List<HealthDataPoint>, List<HealthDataPoint>, List<HealthDataPoint>)
      _splitHealthDataPointsWithType(List<HealthDataPoint> rawPoints) {
    final List<HealthDataPoint> steps = [];
    final List<HealthDataPoint> distances = [];
    final List<HealthDataPoint> calories = [];
    for (final p in rawPoints) {
      switch (p.type) {
        case HealthDataType.STEPS:
          steps.add(p);
          break;
        case HealthDataType.DISTANCE_DELTA:
        case HealthDataType.DISTANCE_WALKING_RUNNING:
          distances.add(p);
          break;
        case HealthDataType.ACTIVE_ENERGY_BURNED:
          calories.add(p);
          break;
        // ignore: no_default_cases
        default:
          // 想定していない値が入ってきたときは開発中に気づけるようにログに出力する
          _logger.w('got unexpected Health Data Type [type][$p.type]');
          break;
      }
    }
    return (
      _getMaxSourceIdData(steps),
      _getMaxSourceIdData(distances),
      _getMaxSourceIdData(calories),
    );
  }

  /// もっとも値が大きいsourceIdに絞って値を取得する
  List<HealthDataPoint> _getMaxSourceIdData(List<HealthDataPoint> rawPoints) {
    /// 空だったら処理せず返す
    if (rawPoints.isEmpty) {
      return [];
    }
    final groupedBySourceId = <String, List<HealthDataPoint>>{};
    for (final point in rawPoints) {
      if (!groupedBySourceId.containsKey(point.sourceId)) {
        groupedBySourceId[point.sourceId] = [];
      }
      groupedBySourceId[point.sourceId]!.add(point);
    }

    final sourceIdTotals = groupedBySourceId.map((sourceId, points) {
      final cleanedPoints = _removeDuplicateDuration(points);
      // ignore: prefer_int_literals
      final totalValue = cleanedPoints.fold(0.0, _sumHealthPointValue);
      return MapEntry(sourceId, totalValue);
    });

    final maxSourceId = sourceIdTotals.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    return _removeDuplicateDuration(groupedBySourceId[maxSourceId]!);
  }

  /// 期間の値が大きくなるよう重複を排除する
  List<HealthDataPoint> _removeDuplicateDuration(List<HealthDataPoint> rawPoints) {
    rawPoints.sort((a, b) => a.dateFrom.compareTo(b.dateFrom));
    return rawPoints.fold<List<HealthDataPoint>>([], (acc, currentPoint) {
      if (acc.isEmpty) {
        acc.add(currentPoint);
        return acc;
      }

      final lastPoint = acc.last;

      if (lastPoint.dateTo.isAfter(currentPoint.dateFrom)) {
        if ((lastPoint.value as NumericHealthValue).numericValue <
            (currentPoint.value as NumericHealthValue).numericValue) {
          acc
            ..removeLast()
            ..add(currentPoint);
        }
      } else {
        acc.add(currentPoint);
      }

      return acc;
    });
  }

  /// Health 情報を取得できるか権限チェック
  Future<void> _validateUsableHealthTypes(List<HealthDataType> types) async {
    final permissions = types.map((e) => HealthDataAccess.READ).toList();
      final hasPermissions = await _healthFactory.hasPermissions(types, permissions: permissions);
      if (hasPermissions == null || !hasPermissions) {
        final requested = await _healthFactory.requestAuthorization(types, permissions: permissions);
        if (!requested) {
          const message = 'get health information error because don\'t have health permission';
          _logger.e(message);
          throw GetHealthException(message: message, status: GetHealthExceptionStatus.notAuthorized);
        }
      }
  }

  double _sumHealthPointValue(double sum, HealthDataPoint point) {
    return sum + (point.value as NumericHealthValue).numericValue;
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
