import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';
import 'package:virtualpilgrimage/application/user/health/health_repository.dart';
import 'package:virtualpilgrimage/application/user/health/update_health_result.codegen.dart';
import 'package:virtualpilgrimage/application/user/health/update_health_usecase.dart';
import 'package:virtualpilgrimage/application/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/customizable_date_time.dart';
import 'package:virtualpilgrimage/domain/exception/database_exception.dart';
import 'package:virtualpilgrimage/domain/exception/get_health_exception.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

class UpdateHealthInteractor implements UpdateHealthUsecase {
  UpdateHealthInteractor(
    this._healthRepository,
    this._userRepository,
    this._logger,
    this._crashlytics,
  );

  final HealthRepository _healthRepository;
  final UserRepository _userRepository;
  final Logger _logger;
  final FirebaseCrashlytics _crashlytics;

  @override
  Future<UpdateHealthResult> execute(VirtualPilgrimageUser user) async {
    UpdateHealthStatus status = UpdateHealthStatus.success;
    VirtualPilgrimageUser? updatedUser;
    Exception? error;
    final now = CustomizableDateTime.current;
    try {
      final health = await _healthRepository.getHealthInfo(
        targetDateTime: now,
        createdAt: user.createdAt,
      );
      updatedUser = user.updateHealth(health);
      await _userRepository.update(updatedUser);
    } on GetHealthException catch (e) {
      final message = 'get user health information error [user][$user][error][$e]';
      _logger.e(message);
      await _crashlytics.log(message);
      await _crashlytics.recordError(e, null);
      status = UpdateHealthStatus.getHealthError;
      error = e;
    } on DatabaseException catch (e) {
      final message = 'update user health information error [user][$user][error][$e]';
      _logger.e(message, e);
      await _crashlytics.log(message);
      await _crashlytics.recordError(e, null);
      status = UpdateHealthStatus.updateUserError;
      error = e;
    } on Exception catch (e) {
      final message = 'unexpected error when update user health information'
          '[user][$user]'
          '[error][${e.toString()}]';
      _logger.e(message, e);
      await _crashlytics.log(message);
      await _crashlytics.recordError(e, null);
      status = UpdateHealthStatus.unknownError;
      error = e;
    }

    return UpdateHealthResult(status: status, user: updatedUser, error: error);
  }
}
