import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:virtualpilgrimage/domain/user/health/health_by_period.codegen.dart';

part 'health_info.codegen.freezed.dart';
part 'health_info.codegen.g.dart';

extension HealthFieldKeys on String {
  static const yesterday = 'yesterday';
  static const week = 'week';
  static const month = 'month';
  static const updatedAt = 'updatedAt';
  static const totalSteps = 'totalSteps';
  static const totalDistance = 'totalDistance';
}

// DateTime <-> Timestamp の相互変換用クラス
// 共通化したいが、ここで定義しないと自動生成ファイル側で import エラーが発生する
class _FirestoreTimestampConverter {
  static Timestamp dateTimeToTimestamp(DateTime dateTime) =>
      Timestamp.fromDate(dateTime);

  static DateTime timestampToDateTime(Timestamp timestamp) =>
      timestamp.toDate();
}

@freezed
class HealthInfo with _$HealthInfo {
  @JsonSerializable(explicitToJson: true)
  const factory HealthInfo({
    required HealthByPeriod yesterday,
    required HealthByPeriod week,
    required HealthByPeriod month,
    @JsonKey(
      fromJson: _FirestoreTimestampConverter.timestampToDateTime,
      toJson: _FirestoreTimestampConverter.dateTimeToTimestamp,
    )
        required DateTime updatedAt,
    required int totalSteps,
    required int totalDistance,
  }) = _HealthInfo;

  const HealthInfo._();

  factory HealthInfo.fromJson(Map<String, dynamic> json) =>
      _$HealthInfoFromJson(json);
}
