import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/health.dart';
import 'package:virtualpilgrimage/domain/health/health_aggregation_result.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_crashlytics_provider.dart';
import 'package:virtualpilgrimage/infrastructure/user/flutter_health_gateway.dart';
import 'package:virtualpilgrimage/logger.dart';

final healthFactoryProvider = Provider<HealthFactory>(
  // TODO: いずれは health connect に対応する必要がある
  (_) => HealthFactory(useHealthConnectIfAvailable: false),
);

final healthGatewayProvider = Provider<HealthGateway>(
  (ref) => FlutterHealthGateway(
    ref.read(healthFactoryProvider),
    ref.read(loggerProvider),
    ref.read(firebaseCrashlyticsProvider),
  ),
);

/// ヘルスケア情報を集計する gateway
abstract class HealthGateway {
  /// 指定した期間のヘルスケア情報を各OSの仕組みから取得
  ///
  /// [from] ヘルスケア情報を取得する起点となる時間
  /// [to] ヘルスケア情報を取得する終点となる時間
  Future<HealthAggregationResult> aggregateHealthByPeriod({
    required DateTime from,
    required DateTime to,
  });
}
