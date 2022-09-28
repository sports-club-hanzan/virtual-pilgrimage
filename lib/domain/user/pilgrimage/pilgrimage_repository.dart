import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/storage_provider.dart';
import 'package:virtualpilgrimage/logger.dart';

final pilgrimageRepositoryProvider = Provider<PilgrimageRepository>(
  (ref) => PilgrimageRepository(
    ref.read(storageProvider),
    ref.read(loggerProvider),
  ),
);

class PilgrimageRepository {
  PilgrimageRepository(this._firestoreClient, this._logger);

  final FirebaseStorage _firestoreClient;
  final Logger _logger;

  Future<String> getTempleImageUrl(String pilgrimageId, String filename) async {
    final storageRef = _firestoreClient.ref().child('temples/$pilgrimageId/$filename');

    _logger.d(filename);

    return storageRef.getDownloadURL();
  }
}
