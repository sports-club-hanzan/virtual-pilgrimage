import 'package:health/health.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:virtualpilgrimage/domain/user/health/health_repository.dart';

class HealthRepositoryImpl implements HealthRepository {
  HealthRepositoryImpl(this._healthFactory, this._logger);

  final HealthFactory _healthFactory;
  final Logger _logger;

  /// 利用するHealth情報のタイプ
  final _types = [
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.STEPS,
    HealthDataType.DISTANCE_DELTA,
    HealthDataType.WEIGHT,
  ];

  @override
  Future<void> getHealthInfo(DateTime now) async {
    final activityRecognitionPermitStatus =
        await Permission.activityRecognition.request();
    if (activityRecognitionPermitStatus.isDenied) {
      await openAppSettings();
    }
    // Health 情報を取得できるか権限チェック
    final requested = await _healthFactory.requestAuthorization(_types);
    if (!requested) {
      _logger.w(
          "get health information error because don't have health permission");
      return;
    }

    // 昨日1日、過去一週間、過去一ヶ月間の3パターンでヘルスケア情報を取得
    final toDate = _lastTime(now.subtract(const Duration(days: 1)));
    // 昨日
    final healthOfYesterday = await _getHealthData(
      DateTime(toDate.year, toDate.month, toDate.day),
      toDate,
    );
    // 一週間
    final healthOfWeek = await _getHealthData(
      toDate
          .subtract(const Duration(days: 7))
          .add(const Duration(microseconds: 1)),
      toDate,
    );
    // 一ヶ月
    final healthOfMonth = await _getHealthData(
      _getPrevMonth(toDate).add(const Duration(microseconds: 1)),
      toDate,
    );

    _logger.d(healthOfYesterday);
  }

  Future<List<HealthDataPoint>> _getHealthData(
    DateTime from,
    DateTime to,
  ) async {
    final healthData =
        await _healthFactory.getHealthDataFromTypes(from, to, _types);
    return HealthFactory.removeDuplicates(healthData);
  }

  /// 指定日の最終時間を microsecond 単位で導出
  DateTime _lastTime(DateTime target) =>
      DateTime(target.year, target.month, target.day, 23, 59, 59, 99, 99);

  /// 指定日の一ヶ月前にあたる日付を取得
  DateTime _getPrevMonth(DateTime target) {
    final prevMonthLastDay = DateTime(target.year, target.month, 0);
    // 指定日と前月で日数が多い時方の日数を差分の日付とする
    // ex.)
    // 3/20 の場合: 28(2/28) > 20(3/20) => 28(prevMonth.day)
    // 3/30 の場合: 28(2/28) < 30(3/30) => 30(target.day)
    final prevDiff =
        target.day < prevMonthLastDay.day ? prevMonthLastDay.day : target.day;
    return target.subtract(Duration(days: prevDiff));
  }
}
