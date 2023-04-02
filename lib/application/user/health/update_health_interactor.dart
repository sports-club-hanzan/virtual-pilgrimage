import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';
import 'package:virtualpilgrimage/application/user/health/health_repository.dart';
import 'package:virtualpilgrimage/application/user/health/update_health_result.codegen.dart';
import 'package:virtualpilgrimage/application/user/health/update_health_usecase.dart';
import 'package:virtualpilgrimage/application/user/health/user_health_repository.dart';
import 'package:virtualpilgrimage/application/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/customizable_date_time.dart';
import 'package:virtualpilgrimage/domain/exception/database_exception.dart';
import 'package:virtualpilgrimage/domain/exception/get_health_exception.dart';
import 'package:virtualpilgrimage/domain/health/user_health.codegen.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

class UpdateHealthInteractor implements UpdateHealthUsecase {
  UpdateHealthInteractor(
    this._healthRepository,
    this._userRepository,
    this._userHealthRepository,
    this._logger,
    this._crashlytics,
  );

  final HealthRepository _healthRepository;
  final UserRepository _userRepository;
  final UserHealthRepository _userHealthRepository;
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
      // 更新内容のhealthと取得したhealthが不一致の場合は Google Fit や ヘルスケアから情報をうまく取得できていないので、ログ出力しておく
      if (updatedUser.health != health) {
        unawaited(
          _crashlytics.log(
            'Getting Health Info may be failed [gotHealth][$health][updateHealth][${updatedUser.health}]',
          ),
        );
      }
      await _userRepository.update(updatedUser);
      // 仮でここで更新している
      // TODO: 日毎にヘルスケア情報を記録するように修正したら更新ロジック自体を見直す
      await _userHealthRepository.update(
        UserHealth.createFromHealthByPeriod(
          user.id,
          (user.health != null && health.today.validate()) ? user.health!.today : health.today,
        ),
      );
    } on GetHealthException catch (e) {
      final message = 'get user health information error [user][$user][error][$e]';
      _logger.e(message);
      unawaited(_crashlytics.log(message));
      unawaited(_crashlytics.recordError(e, null));
      status = UpdateHealthStatus.getHealthError;
      error = e;
    } on DatabaseException catch (e) {
      final message = 'update user health information error [user][$user][error][$e]';
      _logger.e(message, e);
      unawaited(_crashlytics.log(message));
      unawaited(_crashlytics.recordError(e, null));
      status = UpdateHealthStatus.updateUserError;
      error = e;
    } on Exception catch (e) {
      final message = 'unexpected error when update user health information'
          ' [user][$user][error][$e]';
      _logger.e(message, e);
      unawaited(_crashlytics.log(message));
      unawaited(_crashlytics.recordError(e, null));
      status = UpdateHealthStatus.unknownError;
      error = e;
    }

    return UpdateHealthResult(status: status, user: updatedUser, error: error);
  }

  @override
  Future<UpdateHealthResult> executeForRecentlyInfo(VirtualPilgrimageUser user) async {
    UpdateHealthStatus status = UpdateHealthStatus.success;
    VirtualPilgrimageUser? updatedUser;
    Exception? error;
    final now = CustomizableDateTime.current;
    try {
      final healthByPeriod = await _healthRepository.getRecentlyHealthInfo(
        targetDateTime: now,
        createdAt: user.createdAt,
      );
      final health = user.health?.copyWith(
        today: healthByPeriod.today,
        yesterday: healthByPeriod.yesterday,
      );
      updatedUser = user.updateHealth(health!);
      // 更新内容のhealthと取得したhealthが不一致の場合は Google Fit や ヘルスケアから情報をうまく取得できていないので、ログ出力しておく
      if (updatedUser.health != health) {
        unawaited(
          _crashlytics.log(
            'Getting Health Info may be failed [gotHealth][$healthByPeriod][updateHealth][${updatedUser.health}]',
          ),
        );
      }
      await _userRepository.update(updatedUser);
    } on GetHealthException catch (e) {
      final message = 'get user health information error [user][$user][error][$e]';
      _logger.e(message);
      unawaited(_crashlytics.log(message));
      unawaited(_crashlytics.recordError(e, null));
      status = UpdateHealthStatus.getHealthError;
      error = e;
    } on DatabaseException catch (e) {
      final message = 'update user health information error [user][$user][error][$e]';
      _logger.e(message, e);
      unawaited(_crashlytics.log(message));
      unawaited(_crashlytics.recordError(e, null));
      status = UpdateHealthStatus.updateUserError;
      error = e;
    } on Exception catch (e) {
      final message = 'unexpected error when update user health information'
          ' [user][$user][error][$e]';
      _logger.e(message, e);
      unawaited(_crashlytics.log(message));
      unawaited(_crashlytics.recordError(e, null));
      status = UpdateHealthStatus.unknownError;
      error = e;
    }

    return UpdateHealthResult(status: status, user: updatedUser, error: error);
  }
}
