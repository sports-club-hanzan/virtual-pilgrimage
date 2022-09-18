import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/health.dart';
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
  Future<void> getHealthInfo(DateTime now);
}
