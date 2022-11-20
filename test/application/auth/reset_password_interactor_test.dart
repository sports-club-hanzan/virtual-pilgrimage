import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mockito/mockito.dart';
import 'package:virtualpilgrimage/application/auth/reset_password_interactor.dart';
import 'package:virtualpilgrimage/application/auth/reset_password_usecase.dart';

import '../../helper/fakes/fake_package_info.dart';
import '../../helper/mock.mocks.dart';
import '../../helper/provider_container.dart';

void main() {
  late ResetUserPasswordInteractor target;
  late MockEmailAndPasswordAuthRepository emailAndPasswordAuthRepository;
  late MockFirebaseCrashlytics crashlytics;
  final logger = Logger(level: Level.nothing);

  const email = 'test@example.com';
  const packageName = 'com.virtualpilgrimage';

  setUp(() {
    emailAndPasswordAuthRepository = MockEmailAndPasswordAuthRepository();
    crashlytics = MockFirebaseCrashlytics();
    target = ResetUserPasswordInteractor(emailAndPasswordAuthRepository, logger, crashlytics);

    initializeFakePackageInfo(packageName: packageName);
  });

  tearDown(() {
    const MethodChannel('plugins.flutter.io/package_info').setMockMethodCallHandler(null);
  });

  group('ResetPasswordInteractor', () {
    test('DI', () {
      final container = mockedProviderContainer();
      final usecase = container.read(resetUserPasswordUsecaseProvider);
      expect(usecase, isNotNull);
    });

    group('execute', () {
      test('正常系', () async {
        // given
        when(emailAndPasswordAuthRepository.resetPassword(email: email, packageName: packageName))
            .thenAnswer((_) => Future.value());

        // then
        await target.execute(email: email);

        // then
        verify(emailAndPasswordAuthRepository.resetPassword(email: email, packageName: packageName))
            .called(1);
        verifyNever(crashlytics.recordError(any, any)).called(0);
      });

      group('異常系', () {
        final params = {
          'FirebaseException': FirebaseException(plugin: ''),
          'Exception': Exception(),
        };

        for (final param in params.entries) {
          test(param.key, () async {
            // given
            when(
              emailAndPasswordAuthRepository.resetPassword(
                email: anyNamed('email'),
                packageName: anyNamed('packageName'),
              ),
            ).thenThrow(param.value);

            // when
            await target.execute(email: email);

            // then
            verify(
              emailAndPasswordAuthRepository.resetPassword(
                email: anyNamed('email'),
                packageName: anyNamed('packageName'),
              ),
            ).called(1);
            verify(crashlytics.recordError(param.value, any)).called(1);
          });
        }
      });
    });
  });
}
