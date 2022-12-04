import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/application/user/delete/delete_user_interactor.dart';
import 'package:virtualpilgrimage/application/user/delete/delete_user_result.codegen.dart';
import 'package:virtualpilgrimage/application/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_crashlytics_provider.dart';
import 'package:virtualpilgrimage/logger.dart';

final deleteUserUsecaseProvider = Provider<DeleteUserUsecase>(
  (ref) => DeleteUserInteractor(
    ref.read(userRepositoryProvider),
    ref.read(loggerProvider),
    ref.read(firebaseCrashlyticsProvider),
  ),
);

abstract class DeleteUserUsecase {
  /// ユーザを削除
  ///
  /// [user] 更新対象のユーザ
  Future<DeleteUserResult> execute(VirtualPilgrimageUser user);
}
