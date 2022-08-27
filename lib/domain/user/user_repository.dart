import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firestore_provider.dart';
import 'package:virtualpilgrimage/infrastructure/user/user_repository_impl.dart';
import 'package:virtualpilgrimage/logger.dart';

final userRepositoryProvider = Provider<UserRepositoryImpl>(
  (ref) => UserRepositoryImpl(
    ref.read(firestoreProvider),
    ref.read(loggerProider),
  ),
);

abstract class UserRepository {
  Future<VirtualPilgrimageUser?> get(String userId);

  Future<void> update(VirtualPilgrimageUser user);
}
