import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firestore_provider.dart';
import 'package:virtualpilgrimage/infrastructure/temple/temple_repository_impl.dart';

import 'temple_info.codegen.dart';

final templeRepositoryProvider = Provider<TempleRepository>(
  (ref) => TempleRepositoryImpl(
    ref.read(firestoreProvider),
    ref.read,
  ),
);

abstract class TempleRepository {
  Future<TempleInfo> getTempleInfo(int templeId);
  Future<void> getTempleInfoAll();
}
