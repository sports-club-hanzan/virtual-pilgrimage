import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:virtualpilgrimage/domain/user/pilgrimage/pilgrimage_repository.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/cloudstorage_collection_path.dart';

class PilgrimageRepositoryImpl implements PilgrimageRepository {
  PilgrimageRepositoryImpl(this._firestoreClient, this._logger);

  final FirebaseStorage _firestoreClient;
  final Logger _logger;

  @override
  Future<String> getTempleImageUrl(String pilgrimageId, String filename) async {
    final storageRef = _firestoreClient.ref().child(
          CloudStorageCollectionPath.pilgrimage(pilgrimageId, filename),
        );

    _logger.d(filename);

    return storageRef.getDownloadURL();
  }
}
