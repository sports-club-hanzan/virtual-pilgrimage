import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:virtualpilgrimage/domain/auth/auth_repository.dart';
import 'package:virtualpilgrimage/domain/exception/sign_in_exception.dart';

class GoogleAuthRepository extends AuthRepository {
  GoogleAuthRepository(this._firebaseAuth, this._googleSignIn);

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  @override
  Future<UserCredential?> signIn({String? email, String? password}) async {
    try {
      final GoogleSignInAccount? googleSigninAccount = await _googleSignIn.signIn();
      if (googleSigninAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSigninAccount.authentication;
        final oAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        return _firebaseAuth.signInWithCredential(oAuthCredential);
      }
    } on PlatformException catch (e) {
      throw SignInException(
        message: 'cause platform exception [code][${e.code}][message][${e.message}]',
        status: SignInExceptionStatus.platformException,
        cause: e,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credentials') {
        throw SignInException(
          message:
              'Firebase Account exists with different [message][${e.message}][email][${e.email}]',
          status: SignInExceptionStatus.firebaseException,
          cause: e,
        );
      } else if (e.code == 'invalid-credential') {
        throw SignInException(
          message:
              'Firebase signin is invalid credential [message][${e.message}][email][${e.email}]',
          status: SignInExceptionStatus.firebaseException,
          cause: e,
        );
      }
      throw SignInException(
        message: 'cause Firebase exception when signIn [message][${e.message}][code][${e.code}]',
        status: SignInExceptionStatus.firebaseException,
        cause: e,
      );
    } on Exception catch (e) {
      throw SignInException(
        message: 'Firebase signin cause unknown error [exception][$e]',
        status: SignInExceptionStatus.unknownException,
        cause: e,
      );
    }
    return null;
  }

  @override
  Future<void> resetPassword({required String email, required String packageName}) {
    // Google認証はパスワードのリセットは必要ないため呼び出されたら例外
    throw UnimplementedError();
  }
}
