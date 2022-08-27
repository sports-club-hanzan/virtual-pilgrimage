import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:virtualpilgrimage/infrastructure/auth/email_and_password_auth_repository.dart';
import 'package:virtualpilgrimage/infrastructure/auth/google_auth_repository.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_auth_provider.dart';

final _googleSignInProvider = Provider.autoDispose(
  (_) => GoogleSignIn(),
);

final emailAndPasswordAuthRepositoryProvider = Provider.autoDispose(
  (ref) => EmailAndPasswordRepository(ref.watch(firebaseAuthProvider)),
);

final googleAuthRepositoryProvider = Provider.autoDispose(
  (ref) => GoogleAuthRepository(
    ref.watch(firebaseAuthProvider),
    ref.read(_googleSignInProvider),
  ),
);

abstract class AuthRepository {
  Future<UserCredential?> signIn({String? email, String? password});
}
