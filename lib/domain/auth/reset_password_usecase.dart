import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/auth/auth_repository.dart';
import 'package:virtualpilgrimage/domain/auth/reset_password_interactor.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_crashlytics_provider.dart';
import 'package:virtualpilgrimage/logger.dart';

final resetUserPasswordUsecaseProvider = Provider.autoDispose(
  (ref) => ResetUserPasswordInteractor(
    ref.read(emailAndPasswordAuthRepositoryProvider),
    ref.read(loggerProvider),
    ref.read(firebaseCrashlyticsProvider),
  ),
);

abstract class ResetUserPasswordUsecase {
  /// パスワードをリセットするメールを送信する
  ///
  /// [email] パスワードのリセット対象のメールアドレス
  Future<bool> execute({required String email});
}
