import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:virtualpilgrimage/infrastructure/auth/email_and_password_auth_repository.dart';
import 'package:virtualpilgrimage/infrastructure/auth/google_auth_repository.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_auth_provider.dart';

final googleSignInProvider = Provider(
  (_) => GoogleSignIn(
    scopes: [
      'email',
    ],
    hostedDomain: '',
  ),
);

final emailAndPasswordAuthRepositoryProvider = Provider<AuthRepository>(
  (ref) => EmailAndPasswordAuthRepository(ref.watch(firebaseAuthProvider)),
);

final googleAuthRepositoryProvider = Provider<AuthRepository>(
  (ref) => GoogleAuthRepository(
    ref.watch(firebaseAuthProvider),
    ref.read(googleSignInProvider),
  ),
);

abstract class AuthRepository {
  Future<UserCredential?> signIn({String? email, String? password});

  Future<void> resetPassword({required String email, required String packageName});
}
