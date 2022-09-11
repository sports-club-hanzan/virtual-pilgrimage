import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:virtualpilgrimage/domain/auth/auth_repository.dart';
import 'package:virtualpilgrimage/domain/exception/sign_in_exception.dart';
import 'package:virtualpilgrimage/infrastructure/auth/email_and_password_auth_repository.dart';

import '../../helper/mock.mocks.dart';
import '../../helper/provider_container.dart';

void main() {
  MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  MockUserCredential mockUserCredential = MockUserCredential();
  EmailAndPasswordAuthRepository target = EmailAndPasswordAuthRepository(
    mockFirebaseAuth,
  );

  const email = 'test@example.com';
  const password = 'Passw0rd123';

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    target = EmailAndPasswordAuthRepository(mockFirebaseAuth);
  });

  group('EmailAndPasswordAuthRepository', () {
    test('DI', () {
      final container = mockedProviderContainer();
      final repository = container.read(emailAndPasswordAuthRepositoryProvider);
      expect(repository, isNotNull);
    });

    group('signIn', () {
      group('正常系', () {
        setUp(() {
          when(
            mockFirebaseAuth.signInWithEmailAndPassword(
              email: email,
              password: password,
            ),
          ).thenAnswer((_) => Future.value(mockUserCredential));
        });
        test('サインインできる', () async {
          // when
          final actual = await target.signIn(email: email, password: password);

          // then
          expect(actual, mockUserCredential);
          // テスト側で引数を検証できないので any で呼び出しのみを確認
          verify(
            mockFirebaseAuth.signInWithEmailAndPassword(
              email: email,
              password: password,
            ),
          ).called(1);
        });
      });

      group('異常系', () {
        test('email が null', () async {
          // when
          expect(
            () => target.signIn(password: password),
            throwsA(const TypeMatcher<SignInException>()),
          );
        });
        test('password が null', () async {
          // given
          when(mockFirebaseAuth.signInWithEmailAndPassword(email: email))
              .thenAnswer((_) => Future.value(mockUserCredential));

          // when
          expect(
            () => target.signIn(password: password),
            throwsA(const TypeMatcher<SignInException>()),
          );
        });

        test('PlatformException が発生', () async {
          // given
          when(
            mockFirebaseAuth.signInWithEmailAndPassword(
              email: email,
              password: password,
            ),
          ).thenThrow(PlatformException(code: 'dummy', message: 'dummy'));

          // when
          expect(
            () => target.signIn(email: email, password: password),
            throwsA(const TypeMatcher<SignInException>()),
          );
        });

        group('FirebaseAuthException が発生', () {
          group('code: user-not-found', () {
            test('ユーザを作成できる', () async {
              // given
              when(
                mockFirebaseAuth.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                ),
              ).thenThrow(
                FirebaseAuthException(
                  code: 'user-not-found',
                  message: 'dummy',
                  email: 'test@example.com',
                ),
              );
              // user-not-found の場合、ユーザが存在しないのでユーザを作成しようとする
              when(
                mockFirebaseAuth.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                ),
              ).thenAnswer((_) => Future.value(mockUserCredential));

              // when
              final actual = await target.signIn(email: email, password: password);

              // then
              expect(actual, mockUserCredential);
              // テスト側で引数を検証できないので any で呼び出しのみを確認
              verify(
                mockFirebaseAuth.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                ),
              ).called(1);
              verify(
                mockFirebaseAuth.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                ),
              ).called(1);
            });

            group('ユーザを作成時に例外が発生', () {
              final codes = [
                'weak-password',
                'email-already-in-use',
                'dummy',
              ];

              for (final code in codes) {
                test('code: $code', () async {
                  // given
                  when(
                    mockFirebaseAuth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    ),
                  ).thenThrow(
                    FirebaseAuthException(
                      code: 'user-not-found',
                      message: 'dummy',
                      email: 'test@example.com',
                    ),
                  );
                  // user-not-found の場合、ユーザが存在しないのでユーザを作成しようとする
                  // ユーザ作成時に例外が発生
                  when(
                    mockFirebaseAuth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    ),
                  ).thenThrow(
                    FirebaseAuthException(
                      code: code,
                      message: 'dummy',
                      email: 'test@example.com',
                    ),
                  );

                  // when
                  expect(
                    () => target.signIn(email: email, password: password),
                    throwsA(const TypeMatcher<SignInException>()),
                  );
                });
              }
            });
          });

          test('code: wrong-password', () async {
            // given
            when(
              mockFirebaseAuth.signInWithEmailAndPassword(
                email: email,
                password: password,
              ),
            ).thenThrow(
              FirebaseAuthException(
                code: 'wrong-password',
                message: 'dummy',
                email: 'test@example.com',
              ),
            );

            // when
            expect(
              () => target.signIn(email: email, password: password),
              throwsA(const TypeMatcher<SignInException>()),
            );
          });

          test('不明なcode', () async {
            // given
            when(
              mockFirebaseAuth.signInWithEmailAndPassword(
                email: email,
                password: password,
              ),
            ).thenThrow(
              FirebaseAuthException(
                code: 'unknown-code',
                message: 'dummy',
                email: 'test@example.com',
              ),
            );

            // when
            expect(
              () => target.signIn(email: email, password: password),
              throwsA(const TypeMatcher<SignInException>()),
            );
          });
        });

        test('Firebase, Platform 以外の例外が発生', () async {
          // given
          when(
            mockFirebaseAuth.signInWithEmailAndPassword(
              email: email,
              password: password,
            ),
          ).thenThrow(Exception());

          // when
          expect(
            () => target.signIn(email: email, password: password),
            throwsA(const TypeMatcher<SignInException>()),
          );
        });
      });
    });
  });
}
