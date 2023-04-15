import 'package:virtualpilgrimage/application/health/user_health_repository.dart';
import 'package:virtualpilgrimage/domain/health/user_health.codegen.dart';

class FakeUserHealthRepository extends UserHealthRepository {
  @override
  Future<List<UserHealth>> findHealthByPeriod(String userId, DateTime from, DateTime to) {
    // FIXME: implement findHealthByPeriod
    throw UnimplementedError();
  }

  @override
  Future<void> update(UserHealth userHealth) {
    return Future.value();
  }

  @override
  Future<UserHealth?> find(String userId, DateTime now) {
    throw UnimplementedError();
  }
}
