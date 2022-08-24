import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/infrastructure/auth/email_and_password_auth_repository.dart';
import 'package:virtualpilgrimage/infrastructure/auth/google_auth_repository.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_auth_provider.dart';

final emailAndPasswordAuthRepositoryProvider = Provider.autoDispose(
  (ref) => EmailAndPasswordRepository(ref.watch(firebaseAuthProvider)),
);

final googleAuthRepositoryProvider = Provider.autoDispose(
  (ref) => GoogleAuthRepository(ref.watch(firebaseAuthProvider)),
);

abstract class AuthRepository {
  Future<UserCredential?> signIn({String? email, String? password});
}
