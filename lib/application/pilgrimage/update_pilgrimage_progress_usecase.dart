import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/application/health/daily_health_log_repository.dart';
import 'package:virtualpilgrimage/application/health/health_gateway.dart';
import 'package:virtualpilgrimage/application/pilgrimage/temple_repository.dart';
import 'package:virtualpilgrimage/application/pilgrimage/update_pilgrimage_progress_interactor.dart';
import 'package:virtualpilgrimage/application/pilgrimage/update_pilgrimage_progress_result.codegen.dart';
import 'package:virtualpilgrimage/application/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/virtual_position_calculator.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_crashlytics_provider.dart';
import 'package:virtualpilgrimage/logger.dart';

final updatePilgrimageProgressUsecaseProvider = Provider<UpdatePilgrimageProgressUsecase>(
  (ref) => UpdatePilgrimageProgressInteractor(
    ref.read(templeRepositoryProvider),
    ref.read(healthGatewayProvider),
    ref.read(userRepositoryProvider),
    ref.read(dailyHealthLogRepositoryProvider),
    ref.read(virtualPositionCalculatorProvider),
    ref.read(loggerProvider),
    ref.read(firebaseCrashlyticsProvider),
  ),
);

// お遍路の進捗を更新するUseCase
abstract class UpdatePilgrimageProgressUsecase {
  /// お遍路の進捗状況を更新
  ///
  /// [userId] 更新対象のユーザのID
  Future<UpdatePilgrimageProgressResult> execute(String userId);
}
