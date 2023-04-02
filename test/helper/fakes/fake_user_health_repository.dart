import 'package:virtualpilgrimage/application/user/health/user_health_repository.dart';
import 'package:virtualpilgrimage/domain/health/user_health.codegen.dart';

class FakeUserHealthRepository extends UserHealthRepository {
  @override
  Future<List<UserHealth>> findHealthByPeriod(String userId, DateTime from, DateTime to) {
    // TODO: implement findHealthByPeriod
    throw UnimplementedError();
  }

  @override
  Future<void> update(UserHealth userHealth) {
    return Future.value();
  }
}
