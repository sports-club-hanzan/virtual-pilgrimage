import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/storage_provider.dart';
import 'package:virtualpilgrimage/infrastructure/pilgrimage/pilgrimage_repository_impl.dart';
import 'package:virtualpilgrimage/logger.dart';

final pilgrimageRepositoryProvider = Provider<PilgrimageRepository>(
  (ref) => PilgrimageRepositoryImpl(
    ref.read(storageProvider),
    ref.read(loggerProvider),
  ),
);

abstract class PilgrimageRepository {
  Future<String> getTempleImageUrl(String pilgrimageId, String filename);
}
