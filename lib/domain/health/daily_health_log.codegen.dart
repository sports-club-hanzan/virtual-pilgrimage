import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:virtualpilgrimage/domain/helper/firestore_timestamp_converter.dart';
import 'package:virtualpilgrimage/domain/user/health/health_by_period.codegen.dart';

part 'daily_health_log.codegen.freezed.dart';
part 'daily_health_log.codegen.g.dart';

/// 日毎のヘルスケア情報ログ
@freezed
class DailyHealthLog with _$DailyHealthLog {
  @JsonSerializable()
  const factory DailyHealthLog({
    // ユーザID
    required String userId,
    // 歩数
    required int steps,
    // 歩行距離
    required int distance,
    // 消費カロリー
    required int burnedCalorie,
    // 記録対象日
    @JsonKey(
      fromJson: FirestoreTimestampConverter.timestampToDateTime,
      toJson: FirestoreTimestampConverter.dateTimeToTimestamp,
    )
        required DateTime date,
    // 有効期限
    @JsonKey(
      fromJson: FirestoreTimestampConverter.timestampToDateTime,
      toJson: FirestoreTimestampConverter.dateTimeToTimestamp,
    )
        required DateTime expiredAt,
  }) = _DailyHealthLog;

  const DailyHealthLog._();

  factory DailyHealthLog.fromJson(Map<String, dynamic> json) => _$DailyHealthLogFromJson(json);

  /// Firestore に保存する際のドキュメントID
  String documentId() {
    return '${userId}_${DateFormat('yyyyMMdd').format(date)}';
  }

  /// 値が正しいかどうか
  bool valid() {
    return steps > 0 && distance > 0 && burnedCalorie > 0;
  }

  HealthByPeriod toHealthByPeriod() {
    return HealthByPeriod(
      steps: steps,
      distance: distance,
      burnedCalorie: burnedCalorie,
    );
  }

  /// 2つの DailyHealthLog をマージした値を返す
  DailyHealthLog merge(DailyHealthLog dailyHealthLog) {
    if (userId != dailyHealthLog.userId) {
      throw Exception('userId must be same value between two DailyHealthLog');
    }
    if (date != dailyHealthLog.date) {
      throw Exception('date must be same value between two DailyHealthLog');
    }
    return DailyHealthLog(
      userId: userId,
      steps: steps + dailyHealthLog.steps,
      distance: distance + dailyHealthLog.distance,
      burnedCalorie: burnedCalorie + dailyHealthLog.burnedCalorie,
      date: date,
      expiredAt: expiredAt,
    );
  }

  /// HealthByPeriod から DailyHealthLog を作成する
  /// [userId] ユーザID
  /// [day] ヘルスケア情報の日付
  /// [healthByPeriod] ヘルスケア情報
  // ignore: prefer_constructors_over_static_methods
  static DailyHealthLog createFromHealthByPeriod({
    required String userId,
    required DateTime day,
    required HealthByPeriod healthByPeriod,
  }) {
    return DailyHealthLog(
      userId: userId,
      steps: healthByPeriod.steps,
      distance: healthByPeriod.distance,
      burnedCalorie: healthByPeriod.burnedCalorie,
      date: day,
      // 90日間有効
      expiredAt: day.add(const Duration(days: 90)),
    );
  }
}
