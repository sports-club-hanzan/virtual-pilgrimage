import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/user/registration/registration_result.dart';
import 'package:virtualpilgrimage/domain/user/registration/user_registration_interactor.dart';
import 'package:virtualpilgrimage/domain/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/logger.dart';

final userRegistrationUsecaseProvider = Provider.autoDispose(
  (ref) => UserRegistrationInteractor(
    ref.read(userRepositoryProvider),
    ref.read(loggerProvider),
    ref.read(crashlyticsProvider),
  ),
);

// ユーザ情報を登録するためのユースケース
abstract class UserRegistrationUsecase {
  Future<RegistrationResult> execute(VirtualPilgrimageUser user);
}
