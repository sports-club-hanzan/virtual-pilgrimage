import 'package:freezed_annotation/freezed_annotation.dart';

part 'health_by_period.codegen.freezed.dart';
part 'health_by_period.codegen.g.dart';

extension HealthByPeriodFieldKeys on String {
  static const steps = 'steps';
  static const distance = 'distance';
  static const burnedCalorie = 'burnedCalorie';
}

@freezed
class HealthByPeriod with _$HealthByPeriod {
  @JsonSerializable()
  const factory HealthByPeriod({
    // 歩数
    required int steps,
    // 距離[m]
    required int distance,
    // 消費カロリー[kcal]
    required int burnedCalorie,
  }) = _HealthByPeriod;

  const HealthByPeriod._();

  factory HealthByPeriod.fromJson(Map<String, dynamic> json) =>
      _$HealthByPeriodFromJson(json);
}
