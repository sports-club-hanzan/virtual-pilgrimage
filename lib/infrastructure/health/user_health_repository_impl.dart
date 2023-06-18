import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:virtualpilgrimage/application/health/user_health_repository.dart';
import 'package:virtualpilgrimage/domain/exception/database_exception.dart';
import 'package:virtualpilgrimage/domain/health/user_health.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firestore_collection_path.dart';

class UserHealthRepositoryImpl extends UserHealthRepository {
  UserHealthRepositoryImpl(this._firestoreClient, this._logger);

  final FirebaseFirestore _firestoreClient;
  final Logger _logger;

  @override
  Future<void> update(UserHealth userHealth) async {
    try {
      _logger.d('update user health to Firestore');
      await _firestoreClient
          .collection(FirestoreCollectionPath.health)
          .doc(userHealth.documentId())
          .set(userHealth.toJson());
    } on FirebaseException catch (e) {
      throw DatabaseException(
        message: 'Failed with error [code][${e.code}][message][${e.message}]',
        cause: e,
      );
    } on Exception catch (e) {
      throw DatabaseException(message: 'unexpected error [error][$e]', cause: e);
    }
  }

  @override
  Future<UserHealth?> find(String userId, DateTime now) async {
    final docId = '/${userId}_${DateFormat('yyyyMMdd').format(now)}';
    try {
      final ref = _firestoreClient
          .collection(FirestoreCollectionPath.health)
          .doc(docId)
          .withConverter<UserHealth>(
            fromFirestore: (DocumentSnapshot<Map<String, dynamic>> snapshot, _) =>
                UserHealth.fromJson(snapshot.data()!),
            toFirestore: (UserHealth userHealth, _) => userHealth.toJson(),
          );
      final snapshot = await ref.get();
      return snapshot.data();
    } on FirebaseException catch (e) {
      throw DatabaseException(
        message: 'Failed with error [code][${e.code}][message][${e.message}]',
        cause: e,
      );
    } on Exception catch (e) {
      throw DatabaseException(message: 'unexpected error [error][$e]', cause: e);
    }
  }

  // FIXME: interface に合うよう仮実装しているだけ
  @override
  Future<List<UserHealth>> findHealthByPeriod(String userId, DateTime from, DateTime to) async {
    try {
      final ref = _firestoreClient
          .collection(FirestoreCollectionPath.health)
          .where('userId', isEqualTo: userId)
          .where('date', isGreaterThanOrEqualTo: from)
          .where('date', isLessThanOrEqualTo: to)
          .withConverter<UserHealth>(
            fromFirestore: (DocumentSnapshot<Map<String, dynamic>> snapshot, _) =>
                UserHealth.fromJson(snapshot.data()!),
            toFirestore: (UserHealth userHealth, _) => userHealth.toJson(),
          );
      final snapshot = await ref.get();
      final healths = snapshot.docs.map((e) => e.data()).toList();
      return healths;
    } on FirebaseException catch (e) {
      throw DatabaseException(
        message: 'Failed with error [code][${e.code}][message][${e.message}]',
        cause: e,
      );
    } on Exception catch (e) {
      throw DatabaseException(message: 'unexpected error [error][$e]', cause: e);
    }
  }
}
