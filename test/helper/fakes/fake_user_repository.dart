import 'package:virtualpilgrimage/application/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

/// テストで利用する UserRepository の Fake
class FakeUserRepository implements UserRepository {
  FakeUserRepository(this.user);

  final VirtualPilgrimageUser user;

  @override
  Future<VirtualPilgrimageUser?> findWithNickname(String nickname) {
    return Future.value(user);
  }

  @override
  Future<VirtualPilgrimageUser?> get(String userId) {
    return Future.value(user);
  }

  @override
  Future<void> update(VirtualPilgrimageUser user) {
    return Future.value();
  }
}
