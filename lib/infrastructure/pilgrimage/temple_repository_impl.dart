import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/application/pilgrimage/temple_repository.dart';
import 'package:virtualpilgrimage/domain/exception/database_exception.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/temple_info.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firestore_collection_path.dart';

// Firestoreに格納しているお寺の情報のキャッシュ
// お寺の情報は不変であるため、一度取得したら更新する必要はないためキャッシュしておく
// アプリの起動時は空だが、Firestore からデータを詰めて利用する
final templeInfoCache = StateProvider<Map<int, TempleInfo>>((_) => {});

class TempleRepositoryImpl extends TempleRepository {
  TempleRepositoryImpl(this._firestore, this._ref);

  final FirebaseFirestore _firestore;
  final Ref _ref;

  static const templeInfoLength = 88;

  @override
  Future<TempleInfo> getTempleInfo(int templeId) async {
    // キャッシュに存在するならばキャッシュの値をそのまま参照する
    final templeInfoCacheMap = _ref.read(templeInfoCache);
    if (templeInfoCacheMap.containsKey(templeId)) {
      return templeInfoCacheMap[templeId]!;
    }
    // キャッシュに存在しないならばFirestoreに問い合わせる
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
        message: 'unexpected Firestore error ${e.toString()}',
        cause: e,
      );
    }
  }

  /// 全てのお寺情報を取得する
  /// アプリの起動時にお寺情報を取得しておくことで、毎回お寺の情報を参照しなくて済む
  /// アプリの初回ログイン時にのみFirebaseに問い合わせるような仕様になるはず
  @override
  Future<void> getTempleInfoAll() async {
    // templeInfoCache にすでにキャッシュされた情報が含まれている場合は何もしない
    if (_ref.read(templeInfoCache).length == templeInfoLength) {
      return;
    }
    try {
      // firebase からすベてのお寺情報を取得
      final snapshot = await _firestore.collection(FirestoreCollectionPath.temples).get(const GetOptions(source: Source.serverAndCache));
      final Map<int, TempleInfo> templeInfoMap = {};
      // domain entity に convert して id ごとに情報を詰める
      for (final doc in snapshot.docs) {
        final templeInfoSnapshot = await doc.reference
            .withConverter<TempleInfo>(
              fromFirestore: (snapshot, _) => TempleInfo.fromJson(snapshot.data()!),
              toFirestore: (TempleInfo templeInfo, _) => templeInfo.toJson(),
            )
            .get(const GetOptions(source: Source.serverAndCache));
        final data = templeInfoSnapshot.data();
        if (templeInfoSnapshot.exists && data != null) {
          templeInfoMap.addAll({data.id: data});
        }
      }
      _ref.read(templeInfoCache.notifier).state = templeInfoMap;
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
