import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:virtualpilgrimage/domain/exception/database_exception.dart';
import 'package:virtualpilgrimage/domain/user/registration/registration_result.dart';
import 'package:virtualpilgrimage/domain/user/registration/user_registration_interactor.dart';
import 'package:virtualpilgrimage/domain/user/registration/user_registration_usecase.dart';
import 'package:virtualpilgrimage/domain/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

import '../../../helper/mock.mocks.dart';
import '../../../helper/provider_container.dart';
import '../../auth/sign_in_interactor_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockUserRepository;
  late MockFirebaseCrashlytics mockFirebaseCrashlytics;
  final logger = Logger(level: Level.nothing);

  late UserRegistrationInteractor target;

  setUp(() {
    mockUserRepository = MockUserRepository();
    mockFirebaseCrashlytics = MockFirebaseCrashlytics();
    target = UserRegistrationInteractor(mockUserRepository, logger, mockFirebaseCrashlytics);
  });

  group('UserRegistrationInteractor', () {
    test('DI', () {
      final container = mockedProviderContainer();
      final usecase = container.read(userRegistrationUsecaseProvider);
      expect(usecase, isNotNull);
    });

    group('execute', () {
      const nickname = 'dummyName';
      final user = VirtualPilgrimageUser(
        nickname: nickname,
        birthDay: DateTime.utc(2000),
        userStatus: UserStatus.temporary,
      );
      setUp(() {
        when(mockFirebaseCrashlytics.log(any)).thenAnswer((_) => Future.value());
        when(mockFirebaseCrashlytics.recordError(any, null)).thenAnswer((_) => Future.value());
      });
      group('正常系', () {
        test('ユーザを登録できる', () async {
          // given
          final updateTarget = user.copyWith(userStatus: UserStatus.created);
          final expected = RegistrationResult(RegistrationResultStatus.success);
          when(mockUserRepository.findWithNickname(nickname)).thenAnswer(
            (_) => Future.value(null),
          );
          when(mockUserRepository.update(user)).thenAnswer((_) => Future.value(null));

          // when
          final actual = await target.execute(user);

          // then
          expect(actual, expected);
          verify(mockUserRepository.findWithNickname(nickname)).called(1);
          verify(mockUserRepository.update(updateTarget)).called(1);
        });
        test('ユーザが既に存在する', () async {
          // given
          final expected =
              RegistrationResult(RegistrationResultStatus.alreadyExistSameNicknameUser);
          when(mockUserRepository.findWithNickname(nickname)).thenAnswer(
            (_) => Future.value(user),
          );

          // when
          final actual = await target.execute(user);

          // then
          expect(actual, expected);
          verify(mockUserRepository.findWithNickname(nickname)).called(1);
          verifyNever(mockUserRepository.update(any)).called(0);
        });
      });

      group('異常系', () {
        final params = {
          'DBとの接続で例外が発生した場合': const DatabaseException(message: 'dummy', cause: null),
          '未知の例外が発生した場合': Exception(),
        };

        for (final param in params.entries) {
          test(param.key, () async {
            // given
            when(mockUserRepository.findWithNickname(nickname)).thenThrow(param.value);

            // when
            final actual = await target.execute(user);

            // then
            expect(actual.status, RegistrationResultStatus.fail);
          });
        }
      });
    });
  });
}
