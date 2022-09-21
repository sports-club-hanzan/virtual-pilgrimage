import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/health.dart';
import 'package:virtualpilgrimage/domain/user/health/health_info.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/user/health_repository_impl.dart';
import 'package:virtualpilgrimage/logger.dart';

final healthFactoryProvider = Provider<HealthFactory>(
  (_) => HealthFactory(),
);

final healthRepositoryProvider = Provider<HealthRepository>(
  (ref) => HealthRepositoryImpl(
    ref.read(healthFactoryProvider),
    ref.read(loggerProvider),
  ),
);

abstract class HealthRepository {
  /// 歩数、歩行距離といったヘルスケア情報を各OSの仕組みから取得
  ///
  /// [targetDateTime] ヘルスケア情報を取得する起点となる時間
  /// [createdAt] ユーザの作成時刻。アプリケーションに登録されてからの情報を取得するために利用
  Future<HealthInfo> getHealthInfo({required DateTime targetDateTime, required DateTime createdAt});
}
