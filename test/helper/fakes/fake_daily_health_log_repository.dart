import 'package:virtualpilgrimage/application/health/daily_health_log_repository.dart';
import 'package:virtualpilgrimage/domain/health/daily_health_log.codegen.dart';

class FakeDailyHealthLogRepository extends DailyHealthLogRepository {
  @override
  Future<void> update(DailyHealthLog userHealth) {
    return Future.value();
  }

  @override
  Future<DailyHealthLog?> find(String userId, DateTime now) {
    throw UnimplementedError();
  }
}
