import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/health/user_health.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firestore_provider.dart';
import 'package:virtualpilgrimage/infrastructure/health/user_health_repository_impl.dart';
import 'package:virtualpilgrimage/logger.dart';

final userHealthRepositoryProvider = Provider<UserHealthRepository>(
  (ref) => UserHealthRepositoryImpl(ref.read(firestoreProvider), ref.read(loggerProvider)),
);

/// ユーザのヘルスケア情報を管理するリポジトリ
abstract class UserHealthRepository {
  /// ヘルスケア情報を作成・更新
  Future<void> update(UserHealth userHealth);

  // 指定した日のヘルスケア情報を取得
  Future<UserHealth?> find(String userId, DateTime now);

  /// 期間内のヘルスケア情報を取得
  Future<List<UserHealth>> findHealthByPeriod(String userId, DateTime from, DateTime to);
}
