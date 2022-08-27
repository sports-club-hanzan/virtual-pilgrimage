import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:virtualpilgrimage/domain/exception/sign_in_exception.dart';
import 'package:virtualpilgrimage/infrastructure/auth/email_and_password_auth_repository.dart';

import 'email_and_password_auth_repository_test.mocks.dart';

@GenerateMocks([FirebaseAuth, UserCredential])
void main() {
  MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  MockUserCredential mockUserCredential = MockUserCredential();
  EmailAndPasswordRepository target =
      EmailAndPasswordRepository(mockFirebaseAuth);

  const email = 'test@example.com';
  const password = 'Passw0rd123';

  group('signIn', () {
    group('正常系', () {
      test('サインインできる', () async {
        // given
        when(mockFirebaseAuth.signInWithEmailAndPassword(
                email: email, password: password))
            .thenAnswer((_) => Future.value(mockUserCredential));

        // when
        final actual = await target.signIn(email: email, password: password);

        // then
        expect(actual, mockUserCredential);
        // テスト側で引数を検証できないので any で呼び出しのみを確認
        verify(mockFirebaseAuth.signInWithEmailAndPassword(
                email: email, password: password))
            .called(1);
      });
    });

    group('異常系', () {
      test('email が null', () async {
        // given
        when(mockFirebaseAuth.signInWithEmailAndPassword(
                email: email, password: password))
            .thenAnswer((_) => Future.value(mockUserCredential));

        // when
        expect(() => target.signIn(password: password),
            throwsA(const TypeMatcher<SignInException>()));
      });
      test('password が null', () async {
        // given
        when(mockFirebaseAuth.signInWithEmailAndPassword(email: email))
            .thenAnswer((_) => Future.value(mockUserCredential));

        // when
        expect(() => target.signIn(password: password),
            throwsA(const TypeMatcher<SignInException>()));
      });

      test('PlatformException が発生', () async {
        // given
        when(mockFirebaseAuth.signInWithEmailAndPassword(
                email: email, password: password))
            .thenThrow(PlatformException(code: 'dummy', message: 'dummy'));

        // when
        expect(() => target.signIn(email: email, password: password),
            throwsA(const TypeMatcher<SignInException>()));
      });

      group('FirebaseAuthException が発生', () {
        test('code: user-not-found', () async {
          // given
          when(mockFirebaseAuth.signInWithEmailAndPassword(
                  email: email, password: password))
              .thenThrow(FirebaseAuthException(
                  code: 'user-not-found',
                  message: 'dummy',
                  email: 'test@example.com'));

          // when
          expect(() => target.signIn(email: email, password: password),
              throwsA(const TypeMatcher<SignInException>()));
        });

        test('code: wrong-password', () async {
          // given
          when(mockFirebaseAuth.signInWithEmailAndPassword(
                  email: email, password: password))
              .thenThrow(FirebaseAuthException(
                  code: 'wrong-password',
                  message: 'dummy',
                  email: 'test@example.com'));

          // when
          expect(() => target.signIn(email: email, password: password),
              throwsA(const TypeMatcher<SignInException>()));
        });

        test('不明なcode', () async {
          // given
          when(mockFirebaseAuth.signInWithEmailAndPassword(
                  email: email, password: password))
              .thenThrow(FirebaseAuthException(
                  code: 'unknown-code',
                  message: 'dummy',
                  email: 'test@example.com'));

          // when
          expect(() => target.signIn(email: email, password: password),
              throwsA(const TypeMatcher<SignInException>()));
        });
      });

      test('Firebase, Platform 以外の例外が発生', () async {
        // given
        when(mockFirebaseAuth.signInWithEmailAndPassword(
                email: email, password: password))
            .thenThrow(Exception());

        // when
        expect(() => target.signIn(email: email, password: password),
            throwsA(const TypeMatcher<SignInException>()));
      });
    });
  });
}
