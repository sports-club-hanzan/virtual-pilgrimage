import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/health.dart';
import 'package:virtualpilgrimage/domain/health/health_aggregation_result.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/user/health_repository_impl.dart';
import 'package:virtualpilgrimage/logger.dart';

final healthFactoryProvider = Provider<HealthFactory>(
  (_) => HealthFactory(),
);

final healthRepositoryProvider = Provider<HealthRepository>(
  (ref) => HealthRepositoryImpl(
    ref.read(healthFactoryProvider),
    ref.read(loggerProvider),
  ),
);

abstract class HealthRepository {
  /// 指定した期間のヘルスケア情報を各OSの仕組みから取得
  ///
  /// [from] ヘルスケア情報を取得する起点となる時間
  /// [to] ヘルスケア情報を取得する終点となる時間
  Future<HealthAggregationResult> aggregateHealthByPeriod({
    required DateTime from,
    required DateTime to,
  });
}
