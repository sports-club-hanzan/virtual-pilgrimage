import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/health.dart';
import 'package:virtualpilgrimage/domain/health/health_aggregation_result.codegen.dart';
import 'package:virtualpilgrimage/domain/user/health/health_by_period.codegen.dart';
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

  /// 指定した期間のヘルスケア情報を各OSの仕組みから取得
  ///
  /// [from] ヘルスケア情報を取得する起点となる時間
  /// [to] ヘルスケア情報を取得する終点となる時間
  Future<HealthAggregationResult> aggregateHealthByPeriod({
    required DateTime from,
    required DateTime to,
  });

  /// 指定した期間の日毎のヘルスケア情報を各OSの仕組みから取得
  ///
  /// [from] ヘルスケア情報を取得する起点となる時間
  /// [to] ヘルスケア情報を取得する終点となる時間
  Future<Map<DateTime, HealthByPeriod>> getHealthEachPeriod({
    required DateTime from,
    required DateTime to,
  });

  /// 昨日、今日のヘルスケア情報を各OSの仕組みから取得
  /// home page で利用
  ///
  /// [targetDateTime] ヘルスケア情報を取得する起点となる時間
  /// [createdAt] ユーザの作成時刻。アプリケーションに登録されてからの情報を取得するために利用
  Future<RecentlyHealthInfo> getRecentlyHealthInfo({
    required DateTime targetDateTime,
    required DateTime createdAt,
  });
}
