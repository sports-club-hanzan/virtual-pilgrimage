import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:virtualpilgrimage/domain/auth/auth_repository.dart';
import 'package:virtualpilgrimage/domain/auth/sign_in_exception.dart';

class GoogleAuthRepository extends AuthRepository {
  final FirebaseAuth _firebaseAuth;

  GoogleAuthRepository(this._firebaseAuth);

  @override
  Future<UserCredential?> signIn({String? email, String? password}) async {
    try {
      final GoogleSignInAccount? googleSigninAccount =
          await GoogleSignIn(scopes: ['email']).signIn();
      if (googleSigninAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSigninAccount.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        return await _firebaseAuth.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-differenct-credentials') {
        throw SignInException(
          'Firebase Account exists with different [message][${e.message}][email][${e.email}]',
          SignInExceptionStatus.firebaseException,
        );
      } else if (e.code == 'invalid-credential') {
        throw SignInException(
          'Firebase signin is invalid credential [message][${e.message}][email][${e.email}]',
          SignInExceptionStatus.firebaseException,
        );
      }
    } catch (e) {
      throw SignInException(
        'Firebase signin cause unknown error [exception][$e]',
        SignInExceptionStatus.unknownException,
      );
    }
    return null;
  }
}
