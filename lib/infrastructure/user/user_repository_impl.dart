import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:virtualpilgrimage/domain/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/database_exception.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firestore_collection_path.dart';

class UserRepositoryImpl extends UserRepository {
  final FirebaseFirestore _firestoreClient;
  final Logger _logger;

  UserRepositoryImpl(this._firestoreClient, this._logger);

  @override
  Future<VirtualPilgrimageUser?> get(String userId) async {
    try {
      _logger.d('get user from Firestore [userId][$userId]');
      final ref = _firestoreClient
          .collection(FirestoreCollectionPath.users)
          .doc(userId)
          .withConverter(
            fromFirestore:
                (DocumentSnapshot<Map<String, dynamic>> snapshot, _) =>
                    VirtualPilgrimageUser.fromJson(snapshot.data()!),
            toFirestore: (VirtualPilgrimageUser user, _) => user.toJson(),
          );
      final userSnapshot = await ref.get();
      final user = userSnapshot.data();
      if (userSnapshot.exists && user != null) {
        _logger.d(user);
        return user;
      }
      return null;
    } on FirebaseException catch (e) {
      throw DatabaseException(
        message:
            'cause Firestore error [code][${e.code}][message][${e.message}]',
        cause: e,
      );
    } on Exception catch (e) {
      throw DatabaseException(
        message: 'unexpected Firestore error ${e.toString()}',
        cause: e,
      );
    }
  }

  @override
  Future<void> update(VirtualPilgrimageUser user) async {
    try {
      _firestoreClient
          .collection(FirestoreCollectionPath.users)
          .doc(user.id)
          .set(user.toJson());
    } on FirebaseException catch (e) {
      throw DatabaseException(
        message: 'Failed with error [code][${e.code}][message][${e.message}]',
        cause: e,
      );
    } on Exception catch (e) {
      throw DatabaseException(
        message: 'unexpected error ${e.toString()}',
        cause: e,
      );
    }
  }
}
