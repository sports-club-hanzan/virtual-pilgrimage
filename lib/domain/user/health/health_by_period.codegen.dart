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

  bool validate() {
    return steps > 0 && distance > 0 && burnedCalorie > 0;
  }

  static const HealthByPeriod _default = HealthByPeriod(
      steps: 0,
      distance: 0,
      burnedCalorie: 0,
    );

  static HealthByPeriod getDefault() => _default;

  /// 2つの HealthByPeriod をマージした値を返す
  HealthByPeriod merge(HealthByPeriod healthByPeriod) {
    return HealthByPeriod(
      steps: steps + healthByPeriod.steps,
      distance: distance + healthByPeriod.distance,
      burnedCalorie: burnedCalorie + healthByPeriod.burnedCalorie,
    );
  }
}
