import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtualpilgrimage/application/pilgrimage/temple_repository.dart';
import 'package:virtualpilgrimage/domain/exception/database_exception.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/temple_info.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firestore_collection_path.dart';

class TempleRepositoryImpl extends TempleRepository {
  TempleRepositoryImpl(this._firestore);

  final FirebaseFirestore _firestore;

  static const templeInfoLength = 88;

  DocumentSnapshot? fetchedLastDoc;

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

      final templeSnapshot = await ref.get(const GetOptions(source: Source.serverAndCache));
      final data = templeSnapshot.data();
      if (templeSnapshot.exists && data != null) {
        return data;
      }
      throw DatabaseException(message: 'not exists temple info [templeId][$templeId]');
    } on FirebaseException catch (e) {
      throw DatabaseException(
        message: 'cause Firestore error [code][${e.code}][message][${e.message}]',
        cause: e,
      );
    } on Exception catch (e) {
      throw DatabaseException(
        message: 'unexpected Firestore error $e',
        cause: e,
      );
    }
  }

  /// 全てのお寺情報を取得する
  /// アプリの起動時にお寺情報を取得しておくことで、毎回お寺の情報を参照しなくて済む
  /// アプリの初回ログイン時にのみFirebaseに問い合わせるような仕様になるはず
  @override
  Future<List<TempleInfo>> getTempleInfoWithPaging({required int limit}) async {
    if (limit > templeInfoLength) {
      throw ArgumentError('取得件数は$templeInfoLengthまでに絞ってください');
    }
    try {
      // firebase からすベてのお寺情報を取得
      QuerySnapshot<Map<String, dynamic>> snapshots;
      // 初回のデータ取得時は先頭から limit 件取得
      if (fetchedLastDoc == null) {
        snapshots = await _firestore
            .collection(FirestoreCollectionPath.temples)
            .orderBy('id')
            .limit(limit)
            .get(const GetOptions(source: Source.serverAndCache));
      }
      // 2回目以降はページネーションを使って limit 件取得
      else {
        snapshots = await _firestore
            .collection(FirestoreCollectionPath.temples)
            .orderBy('id')
            .startAfterDocument(fetchedLastDoc!)
            .limit(limit)
            .get(const GetOptions(source: Source.serverAndCache));
      }
      // 取得できたドキュメントの最後尾を保存
      fetchedLastDoc = snapshots.docs.last;

      final List<TempleInfo> temples = [];
      // domain entity に convert して id ごとに情報を詰める
      for (final doc in snapshots.docs) {
        final templeInfoSnapshot = await doc.reference
            .withConverter<TempleInfo>(
              fromFirestore: (snapshot, _) => TempleInfo.fromJson(snapshot.data()!),
              toFirestore: (TempleInfo templeInfo, _) => templeInfo.toJson(),
            )
            .get(const GetOptions(source: Source.serverAndCache));
        final data = templeInfoSnapshot.data();
        if (templeInfoSnapshot.exists && data != null) {
          temples.add(data);
        }
      }
      return temples;
    } on FirebaseException catch (e) {
      throw DatabaseException(
        message: 'cause Firestore error [code][${e.code}][message][${e.message}]',
        cause: e,
      );
    } on Exception catch (e) {
      throw DatabaseException(
        message: 'unexpected Firestore error $e',
        cause: e,
      );
    }
  }
}
