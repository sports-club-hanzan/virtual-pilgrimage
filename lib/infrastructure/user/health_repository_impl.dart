import 'package:flutter/foundation.dart';
import 'package:health/health.dart';
import 'package:logger/logger.dart';
import 'package:virtualpilgrimage/application/user/health/health_repository.dart';
import 'package:virtualpilgrimage/domain/customizable_date_time.dart';
import 'package:virtualpilgrimage/domain/exception/get_health_exception.dart';
import 'package:virtualpilgrimage/domain/user/health/health_by_period.codegen.dart';
import 'package:virtualpilgrimage/domain/user/health/health_info.codegen.dart';

class HealthRepositoryImpl implements HealthRepository {
  HealthRepositoryImpl(this._healthFactory, this._logger);

  final HealthFactory _healthFactory;
  final Logger _logger;

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

  /// 歩数、歩行距離といったヘルスケア情報を各OSの仕組みから取得
  ///
  /// [targetDateTime] ヘルスケア情報を取得する起点となる時間
  /// [createdAt] ユーザの作成時刻。アプリケーションに登録されてからの情報を取得するために利用
  @override
  Future<HealthInfo> getHealthInfo({
    required DateTime targetDateTime,
    required DateTime createdAt,
  }) async {
    final types = _healthTypes[defaultTargetPlatform.name.toLowerCase()]!;
    // Health 情報を取得できるか権限チェック
    final requested = await _healthFactory.requestAuthorization(types);
    if (!requested) {
      const message = 'get health information error because don\'t have health permission';
      _logger.e(message);
      throw GetHealthException(message: message, status: GetHealthExceptionStatus.notAuthorized);
    }

    // createdAt より前の時刻は使わないように補正をかけるメソッドを定義
    // アプリを登録した時点をヘルスケア情報の集計起点とする
    DateTime fixDt(DateTime dt) => dt.compareTo(createdAt) == 1 ? dt : createdAt;

    _logger.d('collect health info start [targetDateTime][$targetDateTime]');
    try {
      // 今日、昨日1日、過去一週間、過去一ヶ月間、過去全ての3パターンでヘルスケア情報を取得
      // 今日のデータは今日の00:00:00 ~ 現在時刻までを取得
      final healthOfToday = await _getHealthData(
        DateTime(targetDateTime.year, targetDateTime.month, targetDateTime.day),
        targetDateTime,
        types,
      );

      // 昨日
      final toDate = _lastTime(targetDateTime.subtract(const Duration(days: 1)));
      final healthOfYesterday = await _getHealthData(
        DateTime(toDate.year, toDate.month, toDate.day),
        toDate,
        types,
      );
      // 一週間, 一ヶ月, 全体の集計結果はユーザを作成して24時間後に有効になる
      // 作成して24時間未満の場合、計測中という扱いにする
      // 最大で24時間以上経過しないと集計ロジックの都合上、昨日の歩数 > 一週間,一ヶ月,totalの歩数 となるため
      // この処理が必要となる
      List<HealthDataPoint> healthOfWeek = [];
      List<HealthDataPoint> healthOfMonth = [];
      List<HealthDataPoint> healthOfTotal = [];
      if (targetDateTime.difference(createdAt).compareTo(const Duration(days: 1)) == 1) {
        // 一週間
        final fromLastWeek =
            toDate.subtract(const Duration(days: 7)).add(const Duration(microseconds: 1));
        healthOfWeek = await _getHealthData(fixDt(fromLastWeek), toDate, types);
        // 一ヶ月
        final fromLastMonth = _getPrevMonth(toDate).add(const Duration(microseconds: 1));
        healthOfMonth = await _getHealthData(fixDt(fromLastMonth), toDate, types);
        // 過去全て
        healthOfTotal = await _getHealthData(createdAt, toDate, types);
      }

      final totalHealth = _aggregateHealthInfo(healthOfTotal);
      final health = HealthInfo(
        today: _aggregateHealthInfo(healthOfToday),
        yesterday: _aggregateHealthInfo(healthOfYesterday),
        week: _aggregateHealthInfo(healthOfWeek),
        month: _aggregateHealthInfo(healthOfMonth),
        updatedAt: CustomizableDateTime.current,
        totalSteps: totalHealth.steps,
        totalDistance: totalHealth.distance,
      );
      _aggregateHealthInfo(healthOfToday);
      _logger.d(health);
      return health;
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

  /// 指定した期間のみのヘルスケア情報を各OSの仕組みから取得
  ///
  /// [from] ヘルスケア情報を取得する起点となる時間
  /// [to] ヘルスケア情報を取得する終点となる時間
  @override
  Future<HealthByPeriod> getHealthByPeriod({
    required DateTime from,
    required DateTime to,
  }) async {
    final types = _healthTypes[defaultTargetPlatform.name.toLowerCase()]!;
    // Health 情報を取得できるか権限チェック
    final requested = await _healthFactory.requestAuthorization(types);
    if (!requested) {
      const message = 'get health information error because don\'t have health permission';
      _logger.e(message);
      throw GetHealthException(message: message, status: GetHealthExceptionStatus.notAuthorized);
    }

    try {
      final health = await _getHealthData(from, to, types);
      final aggregatedHealth = _aggregateHealthInfo(health);
      return aggregatedHealth;
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
    if (trueFrom.compareTo(trueTo) != -1) {
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
    num steps = 0;
    num distance = 0;
    num burnedCalorie = 0;
    for (final p in rawPoints) {
      // アプリで取り扱うヘルスケア情報はいずれも数値型なので、値を先に取得しておく
      final val = (p.value as NumericHealthValue).numericValue;
      // ignore: missing_enum_constant_in_switch
      switch (p.type) {
        // 歩数
        case HealthDataType.STEPS:
          steps += val;
          break;
        // 歩行距離[m]
        // Android: DISTANCE_DELTA
        // iOS: DISTANCE_WALKING_RUNNING
        // ref.  https://pub.dev/packages/health
        case HealthDataType.DISTANCE_DELTA:
        case HealthDataType.DISTANCE_WALKING_RUNNING:
          distance += val;
          break;
        // 消費カロリー[kcal]
        case HealthDataType.ACTIVE_ENERGY_BURNED:
          burnedCalorie += val;
          break;
        // ignore: no_default_cases
        default:
          // 想定していない値が入ってきたときは開発中に気づけるようにログに出力する
          _logger.w('got unexpected Health Data Type [type][${p.type.toString()}]');
          break;
      }
    }
    // アプリの性質上、カロリーや距離の精度は気にしなくていいため、小数点第一位で切り上げした値を利用
    // 最初から切り上げした値を加算すると誤差が大きくなるため、足し合わせる間は小数を持った状態で計算する実装としている
    return HealthByPeriod(
      steps: steps.ceil(),
      distance: distance.ceil(),
      burnedCalorie: burnedCalorie.ceil(),
    );
  }

  /// 指定日の最終時間を microsecond 単位で導出
  /// 指定日の次の日 - 1microseconds で 1microseconds だけ次の日より前の時間を取得できる
  ///
  /// [target] 最終時間を取得したい日
  DateTime _lastTime(DateTime target) => DateTime(target.year, target.month, target.day)
      .add(const Duration(days: 1))
      .subtract(const Duration(microseconds: 1));

  /// 指定日の一ヶ月前にあたる日付を取得
  ///
  /// [target] 一ヶ月前の日付を取得したい日
  DateTime _getPrevMonth(DateTime target) {
    final prevMonthLastDay = DateTime(target.year, target.month, 0);
    // 指定日と前月で日数が多い時方の日数を差分の日付とする
    // ex.)
    // 3/20 の場合: 28(2/28) > 20(3/20) => 28(prevMonth.day)
    // 3/30 の場合: 28(2/28) < 30(3/30) => 30(target.day)
    final prevDiff = target.day < prevMonthLastDay.day ? prevMonthLastDay.day : target.day;
    return target.subtract(Duration(days: prevDiff));
  }
}
