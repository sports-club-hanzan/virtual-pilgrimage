import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/health/daily_health_log.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firestore_provider.dart';
import 'package:virtualpilgrimage/infrastructure/health/firestore_daily_health_log_repository.dart';
import 'package:virtualpilgrimage/logger.dart';

final dailyHealthLogRepositoryProvider = Provider<DailyHealthLogRepository>(
  (ref) => FirestoreDailyHealthLogRepository(ref.read(firestoreProvider), ref.read(loggerProvider)),
);

/// 日毎のヘルスケア情報を取得するリポジトリ
abstract class DailyHealthLogRepository {
  /// ヘルスケア情報を作成・更新
  Future<void> update(DailyHealthLog dailyHealthLog);

  /// 指定した日のヘルスケア情報を取得
  Future<DailyHealthLog?> find(String userId, DateTime now);
}
