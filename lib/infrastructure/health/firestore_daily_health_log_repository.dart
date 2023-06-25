import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:virtualpilgrimage/application/health/daily_health_log_repository.dart';
import 'package:virtualpilgrimage/domain/exception/database_exception.dart';
import 'package:virtualpilgrimage/domain/health/daily_health_log.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firestore_collection_path.dart';

/// Firestore から日毎のヘルスケア情報を取得するリポジトリの実装
class FirestoreDailyHealthLogRepository extends DailyHealthLogRepository {
  FirestoreDailyHealthLogRepository(this._firestoreClient, this._logger);

  final FirebaseFirestore _firestoreClient;
  final Logger _logger;

  @override
  Future<void> update(DailyHealthLog dailyHealthLog) async {
    try {
      _logger.d('update user health to Firestore');
      await _firestoreClient
          .collection(FirestoreCollectionPath.health)
          .doc(dailyHealthLog.documentId())
          .set(dailyHealthLog.toJson());
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
  Future<DailyHealthLog?> find(String userId, DateTime now) async {
    final docId = '/${userId}_${DateFormat('yyyyMMdd').format(now)}';
    try {
      final ref = _firestoreClient
          .collection(FirestoreCollectionPath.health)
          .doc(docId)
          .withConverter<DailyHealthLog>(
            fromFirestore: (DocumentSnapshot<Map<String, dynamic>> snapshot, _) =>
                DailyHealthLog.fromJson(snapshot.data()!),
            toFirestore: (DailyHealthLog dailyHealthLog, _) => dailyHealthLog.toJson(),
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
}
