import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/auth/auth_repository.dart';
import 'package:virtualpilgrimage/domain/auth/sign_in_interactor.dart';
import 'package:virtualpilgrimage/domain/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_auth_provider.dart';
import 'package:virtualpilgrimage/logger.dart';

final signInUsecaseProvider = Provider.autoDispose<SignInUsecase>(
  (ref) => SignInInteractor(
    ref.watch(emailAndPasswordAuthRepositoryProvider),
    ref.watch(googleAuthRepositoryProvider),
    ref.watch(userRepositoryProvider),
    ref.watch(loggerProvider),
    ref.watch(crashlyticsProvider),
    ref.watch(firebaseAuthProvider),
  ),
);

abstract class SignInUsecase {
  Future<VirtualPilgrimageUser> signInWithGoogle();

  Future<VirtualPilgrimageUser> signInWithEmailAndPassword(
    String email,
    String password,
  );

  Future<void> logout();
}
