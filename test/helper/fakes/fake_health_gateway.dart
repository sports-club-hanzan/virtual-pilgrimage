import 'package:virtualpilgrimage/application/health/health_gateway.dart';
import 'package:virtualpilgrimage/domain/health/health_aggregation_result.codegen.dart';
import 'package:virtualpilgrimage/domain/user/health/health_by_period.codegen.dart';
import 'package:virtualpilgrimage/domain/user/health/health_info.codegen.dart';

class FakeHealthGateway extends HealthGateway {
  FakeHealthGateway({required this.healthByPeriod, required this.healthInfo});

  final HealthByPeriod healthByPeriod;
  final HealthInfo healthInfo;

  @override
  Future<HealthAggregationResult> aggregateHealthByPeriod({
    required DateTime from,
    required DateTime to,
  }) {
    return Future.value(
      HealthAggregationResult(
        eachDay: {from: healthByPeriod},
        total: healthByPeriod,
      ),
    );
  }
}
