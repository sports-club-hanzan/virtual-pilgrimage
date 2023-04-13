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
      // FIXME: 各種ページで参照するヘルスケア情報を見直す
      // 最終更新日の00:00:00 ~ 現在時刻までのヘルスケア情報を取得
      final healthEachPeriod = await _healthRepository.getHealthEachPeriod(
        from: user.updatedAt.copyWith(hour: 0, minute: 0, second: 0),
        to: now,
      );
      for (final e in healthEachPeriod.entries) {
        final targetHealth = UserHealth.createFromHealthByPeriod(user.id, e.value);
        final userHealth = await _userHealthRepository.find(user.id, e.key);
        // すでに情報が存在する && 取得した情報が不正の場合は更新しない
        if (userHealth != null && !targetHealth.valid()) {
          break;
        }
        await _userHealthRepository.update(targetHealth);
      }
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
