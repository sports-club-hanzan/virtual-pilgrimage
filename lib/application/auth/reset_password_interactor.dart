import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';
import 'package:package_info/package_info.dart';
import 'package:virtualpilgrimage/application/auth/auth_repository.dart';
import 'package:virtualpilgrimage/application/auth/reset_password_usecase.dart';

class ResetUserPasswordInteractor extends ResetUserPasswordUsecase {
  ResetUserPasswordInteractor(this._authRepository, this._logger, this._crashlytics);

  final AuthRepository _authRepository;
  final Logger _logger;
  final FirebaseCrashlytics _crashlytics;

  @override
  Future<bool> execute({required String email}) async {
    final packageInfo = await PackageInfo.fromPlatform();
    const errorMsg = 'fail to reset password';
    bool status = false;

    try {
      await _authRepository.resetPassword(email: email, packageName: packageInfo.packageName);
      status = true;
    } on FirebaseAuthException catch (e) {
      _logger.e('$errorMsg [email][$email][code][${e.code}][message][${e.message}]');
      unawaited(_crashlytics.recordError(e, e.stackTrace));
    } on Exception catch (e) {
      _logger.e('$errorMsg [email][$email][error][${e.toString()}]');
      unawaited(_crashlytics.recordError(e, null));
    }
    return status;
  }
}
