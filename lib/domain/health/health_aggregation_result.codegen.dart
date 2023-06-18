import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:virtualpilgrimage/domain/user/health/health_by_period.codegen.dart';

part 'health_aggregation_result.codegen.freezed.dart';

@freezed
class HealthAggregationResult with _$HealthAggregationResult {
  const factory HealthAggregationResult({
    required Map<DateTime, HealthByPeriod> eachDay,
    required HealthByPeriod total,
  }) = _HealthAggregationResult;

  const HealthAggregationResult._();
}
