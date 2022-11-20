import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:virtualpilgrimage/application/auth/auth_repository.dart';
import 'package:virtualpilgrimage/domain/exception/sign_in_exception.dart';
import 'package:virtualpilgrimage/infrastructure/auth/google_auth_repository.dart';

import '../../helper/mock.mocks.dart';
import '../../helper/provider_container.dart';

void main() {
  MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  MockGoogleSignIn mockGoogleSignIn = MockGoogleSignIn();
  MockGoogleSignInAccount mockGoogleSignInAccount = MockGoogleSignInAccount();
  MockGoogleSignInAuthentication mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
  MockUserCredential mockUserCredential = MockUserCredential();
  GoogleAuthRepository target = GoogleAuthRepository(mockFirebaseAuth, mockGoogleSignIn);

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    mockGoogleSignInAccount = MockGoogleSignInAccount();
    mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
    mockUserCredential = MockUserCredential();
    target = GoogleAuthRepository(mockFirebaseAuth, mockGoogleSignIn);
  });

  group('GoogleAuthRepository', () {
    test('DI', () {
      final container = mockedProviderContainer();
      final repository = container.read(googleAuthRepositoryProvider);
      expect(repository, isNotNull);
    });

    group('signIn', () {
      setUp(() {
        when(mockGoogleSignInAuthentication.idToken).thenReturn('dummy');
        when(mockGoogleSignInAuthentication.accessToken).thenReturn('dummy');
        when(mockGoogleSignInAccount.authentication)
            .thenAnswer((_) => Future.value(mockGoogleSignInAuthentication));
        when(mockGoogleSignIn.signIn()).thenAnswer((_) => Future.value(mockGoogleSignInAccount));
        when(mockFirebaseAuth.signInWithCredential(any))
            .thenAnswer((_) => Future.value(mockUserCredential));
      });
      group('正常系', () {
        test('サインインできる', () async {
          // when
          final actual = await target.signIn();

          // then
          expect(actual, mockUserCredential);
          verify(mockGoogleSignIn.signIn()).called(1);
          verify(mockGoogleSignInAccount.authentication).called(1);
          // テスト側で引数を検証できないので any で呼び出しのみを確認
          verify(mockFirebaseAuth.signInWithCredential(any)).called(1);
        });
      });

      group('異常系', () {
        test('PlatformException が発生', () async {
          // given
          when(mockFirebaseAuth.signInWithCredential(any))
              .thenThrow(PlatformException(code: 'dummy', message: 'dummy'));

          // when
          expect(
            () => target.signIn(),
            throwsA(const TypeMatcher<SignInException>()),
          );
        });

        group('FirebaseAuthException が発生', () {
          test('code: account-exists-with-different-credentials', () async {
            // given
            when(mockFirebaseAuth.signInWithCredential(any)).thenThrow(
              FirebaseAuthException(
                code: 'account-exists-with-different-credentials',
                message: 'dummy',
                email: 'test@example.com',
              ),
            );

            // when
            expect(
              () => target.signIn(),
              throwsA(const TypeMatcher<SignInException>()),
            );
          });

          test('code: invalid-credential', () async {
            // given
            when(mockFirebaseAuth.signInWithCredential(any)).thenThrow(
              FirebaseAuthException(
                code: 'invalid-credential',
                message: 'dummy',
                email: 'test@example.com',
              ),
            );

            // when
            expect(
              () => target.signIn(),
              throwsA(const TypeMatcher<SignInException>()),
            );
          });

          test('不明なcode', () async {
            // given
            when(mockFirebaseAuth.signInWithCredential(any)).thenThrow(
              FirebaseAuthException(
                code: 'unknown-code',
                message: 'dummy',
                email: 'test@example.com',
              ),
            );

            // when
            expect(
              () => target.signIn(),
              throwsA(const TypeMatcher<SignInException>()),
            );
          });
        });

        test('Firebase, Platform 以外の例外が発生', () async {
          // given
          when(mockFirebaseAuth.signInWithCredential(any)).thenThrow(Exception());

          // when
          expect(
            () => target.signIn(),
            throwsA(const TypeMatcher<SignInException>()),
          );
        });
      });
    });
  });
}
