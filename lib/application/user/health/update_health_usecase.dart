import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/application/user/health/health_repository.dart';
import 'package:virtualpilgrimage/application/user/health/update_health_interactor.dart';
import 'package:virtualpilgrimage/application/user/health/update_health_result.codegen.dart';
import 'package:virtualpilgrimage/application/user/health/user_health_repository.dart';
import 'package:virtualpilgrimage/application/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_crashlytics_provider.dart';
import 'package:virtualpilgrimage/logger.dart';

final updateHealthUsecaseProvider = Provider.autoDispose<UpdateHealthUsecase>(
  (ref) => UpdateHealthInteractor(
    ref.read(healthRepositoryProvider),
    ref.read(userRepositoryProvider),
    ref.read(userHealthRepositoryProvider),
    ref.read(loggerProvider),
    ref.read(firebaseCrashlyticsProvider),
  ),
);

abstract class UpdateHealthUsecase {
  /// ユーザのヘルスケア情報を更新
  ///
  /// [user] 更新対象のユーザ
  Future<UpdateHealthResult> execute(VirtualPilgrimageUser user);

  /// 昨日・今日のユーザのヘルスケア情報を更新
  ///
  /// [user] 更新対象のユーザ
  Future<UpdateHealthResult> executeForRecentlyInfo(VirtualPilgrimageUser user);
}
