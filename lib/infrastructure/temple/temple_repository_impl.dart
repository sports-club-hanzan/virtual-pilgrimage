import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtualpilgrimage/domain/exception/database_exception.dart';
import 'package:virtualpilgrimage/domain/temple/temple_info.codegen.dart';
import 'package:virtualpilgrimage/domain/temple/temple_repository.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firestore_collection_path.dart';

class TempleRepositoryImpl extends TempleRepository {
  TempleRepositoryImpl(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<TempleInfo> getTempleInfo(int templeId) async {
    try {
      final ref = _firestore
          .collection(FirestoreCollectionPath.temples)
          .doc(templeId.toString())
          .withConverter<TempleInfo>(
        fromFirestore: (snapshot, _) => TempleInfo.fromJson(snapshot.data()!),
        toFirestore: (TempleInfo templeInfo, _) => templeInfo.toJson(),
      );

      final templeSnapshot = await ref.get();
      return templeSnapshot.data()!;
    } on FirebaseException catch (e) {
      throw DatabaseException(
        message: 'cause Firestore error [code][${e.code}][message][${e.message}]',
        cause: e,
      );
    } on Exception catch (e) {
      throw DatabaseException(
        message: 'unexpected Firestore error ${e.toString()}',
        cause: e,
      );
    }
  }
}
