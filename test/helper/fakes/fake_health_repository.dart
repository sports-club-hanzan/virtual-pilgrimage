import 'package:virtualpilgrimage/application/health/health_repository.dart';
import 'package:virtualpilgrimage/domain/health/health_aggregation_result.codegen.dart';
import 'package:virtualpilgrimage/domain/user/health/health_by_period.codegen.dart';
import 'package:virtualpilgrimage/domain/user/health/health_info.codegen.dart';

class FakeHealthRepository extends HealthRepository {
  FakeHealthRepository({required this.healthByPeriod, required this.healthInfo});

  final HealthByPeriod healthByPeriod;
  final HealthInfo healthInfo;

  @override
  Future<HealthAggregationResult> aggregateHealthByPeriod(
      {required DateTime from, required DateTime to}) {
    return Future.value(
      HealthAggregationResult(
        eachDay: {from: healthByPeriod},
        total: healthByPeriod,
      ),
    );
  }

  @override
  Future<HealthInfo> getHealthInfo({
    required DateTime targetDateTime,
    required DateTime createdAt,
  }) {
    return Future.value(healthInfo);
  }

  @override
  Future<RecentlyHealthInfo> getRecentlyHealthInfo({
    required DateTime targetDateTime,
    required DateTime createdAt,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Map<DateTime, HealthByPeriod>> getHealthEachPeriod({
    required DateTime from,
    required DateTime to,
  }) {
    throw UnimplementedError();
  }
}
