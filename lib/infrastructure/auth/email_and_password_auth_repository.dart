import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:virtualpilgrimage/domain/auth/auth_repository.dart';
import 'package:virtualpilgrimage/domain/exception/sign_in_exception.dart';

// ref. https://firebase.google.com/docs/auth/flutter/password-auth
class EmailAndPasswordAuthRepository extends AuthRepository {
  EmailAndPasswordAuthRepository(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  @override
  Future<UserCredential?> signIn({String? email, String? password}) async {
    // interface 定義の都合上 email, password が nullable だが、
    // email, password が必要なので、null だったら例外
    if (email == null || password == null) {
      throw SignInException(
        message: 'email or password are null [email][$email][password][$password]',
        status: SignInExceptionStatus.emailOrPasswordIsNull,
      );
    }

    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on PlatformException catch (e) {
      throw SignInException(
        message: 'cause platform exception [code][${e.code}][message][${e.message}]',
        status: SignInExceptionStatus.platformException,
        cause: e,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return _signInWithCreateUser(email, password);
      } else if (e.code == 'wrong-password') {
        throw SignInException(
          message: 'Firebase exception because user set wrong password'
              '[message][${e.message}]'
              '[email][${e.email}]',
          status: SignInExceptionStatus.wrongPassword,
          cause: e,
        );
      }
      throw SignInException(
        message: 'cause Firebase exception when signIn'
            '[message][${e.message}]'
            '[code][${e.code}]',
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
  }

  FutureOr<UserCredential?> _signInWithCreateUser(
    String email,
    String password,
  ) async {
    try {
      return _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw SignInException(
          message: 'password set with user is weak'
              '[message][${e.message}]'
              '[email][${e.email}]',
          status: SignInExceptionStatus.weakPassword,
          cause: e,
        );
      } else if (e.code == 'email-already-in-use') {
        throw SignInException(
          message: 'email already in use [message][${e.message}][email][${e.email}]',
          status: SignInExceptionStatus.alreadyUsedEmail,
          cause: e,
        );
      }
      throw SignInException(
        message: 'Firebase signin with create user cause unknown error',
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
  }
}
