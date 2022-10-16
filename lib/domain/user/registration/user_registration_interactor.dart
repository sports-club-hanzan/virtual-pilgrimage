import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';
import 'package:virtualpilgrimage/domain/exception/database_exception.dart';
import 'package:virtualpilgrimage/domain/user/registration/registration_result.dart';
import 'package:virtualpilgrimage/domain/user/registration/user_registration_usecase.dart';
import 'package:virtualpilgrimage/domain/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

class UserRegistrationInteractor extends UserRegistrationUsecase {
  UserRegistrationInteractor(
    this._userRepository,
    this._logger,
    this._crashlytics,
  );

  final UserRepository _userRepository;
  final Logger _logger;
  final FirebaseCrashlytics _crashlytics;

  @override
  Future<RegistrationResult> execute(VirtualPilgrimageUser user) async {
    DatabaseException? error;
    RegistrationResultStatus status = RegistrationResultStatus.fail;

    try {
      if (await _userRepository.findWithNickname(user.nickname) != null) {
        return RegistrationResult(
          RegistrationResultStatus.alreadyExistSameNicknameUser,
        );
      }
      _logger.i('register user: $user');
      // 作成済みステータスに変えて保存
      await _userRepository.update(user.copyWith(userStatus: UserStatus.created));
      status = RegistrationResultStatus.success;
    } on DatabaseException catch (e) {
      final message = 'registration user error [user][$user]';
      _logger.e(message, e);
      await _crashlytics.log(message);
      await _crashlytics.recordError(e, null);
      error = e;
    } on Exception catch (e) {
      final message = 'unexpected error when registration user'
          '[user][$user]'
          '[error][${e.toString()}]';
      _logger.e(message, e);
      await _crashlytics.log(message);
      await _crashlytics.recordError(e, null);
      error = DatabaseException(
        message: message,
        cause: e,
      );
    }

    return RegistrationResult(status, error);
  }
}
