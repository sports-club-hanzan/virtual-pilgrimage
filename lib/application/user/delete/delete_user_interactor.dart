import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';
import 'package:virtualpilgrimage/application/user/delete/delete_user_result.codegen.dart';
import 'package:virtualpilgrimage/application/user/delete/delete_user_usecase.dart';
import 'package:virtualpilgrimage/application/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/exception/database_exception.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

class DeleteUserInteractor extends DeleteUserUsecase {
  DeleteUserInteractor(this._userRepository, this._logger, this._crashlytics);

  final UserRepository _userRepository;
  final Logger _logger;
  final FirebaseCrashlytics _crashlytics;

  @override
  Future<DeleteUserResult> execute(VirtualPilgrimageUser user) async {
    DeleteUserStatus status = DeleteUserStatus.fail;
    Exception? error;
    try {
      await _userRepository.delete(user);
      status = DeleteUserStatus.success;
    } on DatabaseException catch (e) {
      error = e;
      final message = 'delete user error [id][${user.id}][error][$e][nestedError][${e.cause}]';
      _logger.e(message);
      await _crashlytics.log(message);
      await _crashlytics.recordError(e, null);
    }

    return DeleteUserResult(status: status, error: error);
  }
}
