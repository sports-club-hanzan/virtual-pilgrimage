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
