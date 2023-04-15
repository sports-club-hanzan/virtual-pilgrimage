import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:virtualpilgrimage/domain/customizable_date_time.dart';
import 'package:virtualpilgrimage/domain/helper/firestore_timestamp_converter.dart';
import 'package:virtualpilgrimage/domain/user/health/health_by_period.codegen.dart';

part 'user_health.codegen.freezed.dart';
part 'user_health.codegen.g.dart';

@freezed
class UserHealth with _$UserHealth {
  @JsonSerializable()
  const factory UserHealth({
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
  }) = _UserHealth;

  const UserHealth._();

  factory UserHealth.fromJson(Map<String, dynamic> json) => _$UserHealthFromJson(json);

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

  /// 2つの UserHealth をマージした値を返す
  UserHealth merge(UserHealth userHealth) {
    if (userId != userHealth.userId) {
      throw Exception('userId must be same value between two UserHealth');
    }
    if (date != userHealth.date) {
      throw Exception('date must be same value between two UserHealth');
    }
    return UserHealth(
      userId: userId,
      steps: steps + userHealth.steps,
      distance: distance + userHealth.distance,
      burnedCalorie: burnedCalorie + userHealth.burnedCalorie,
      date: date,
      expiredAt: expiredAt,
    );
  }

  /// HealthByPeriod から UserHealth を作成する
  // ignore: prefer_constructors_over_static_methods
  static UserHealth createFromHealthByPeriod(String userId, HealthByPeriod healthByPeriod) {
    final now = CustomizableDateTime.current;
    return UserHealth(
      userId: userId,
      steps: healthByPeriod.steps,
      distance: healthByPeriod.distance,
      burnedCalorie: healthByPeriod.burnedCalorie,
      date: DateTime(now.year, now.month, now.day),
      // 90日間有効
      expiredAt: DateTime(now.year, now.month, now.day).add(const Duration(days: 90)),
    );
  }
}
