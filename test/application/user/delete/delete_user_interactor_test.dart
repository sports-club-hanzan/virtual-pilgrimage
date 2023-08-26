import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mockito/mockito.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:virtualpilgrimage/application/user/delete/delete_user_interactor.dart';
import 'package:virtualpilgrimage/application/user/delete/delete_user_result.codegen.dart';
import 'package:virtualpilgrimage/application/user/delete/delete_user_usecase.dart';
import 'package:virtualpilgrimage/application/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/customizable_date_time.dart';
import 'package:virtualpilgrimage/domain/exception/database_exception.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/pilgrimage_info.codegen.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

import '../../../helper/mock.mocks.dart';
import '../../../helper/provider_container.dart';

void main() {
  late UserRepository userRepository;
  late DeleteUserInteractor target;
  final Logger logger = Logger(level: Level.nothing);
  late FirebaseCrashlytics firebaseCrashlytics;

  tz.initializeTimeZones();

  final user = VirtualPilgrimageUser(
    birthDay: DateTime(1990),
    createdAt: CustomizableDateTime.current,
    updatedAt: CustomizableDateTime.current,
    pilgrimage: PilgrimageInfo(id: 'dummyId', updatedAt: CustomizableDateTime.current),
  );

  final container = mockedProviderContainer();

  setUp(() {
    userRepository = MockUserRepository();
    firebaseCrashlytics = MockFirebaseCrashlytics();
    target = DeleteUserInteractor(userRepository, logger, firebaseCrashlytics);
  });

  group('DeleteUserInteractor', () {
    test('DI', () {
      final actual = container.read(deleteUserUsecaseProvider);
      expect(actual, isNotNull);
    });

    group('execute', () {
      test('正常系', () async {
        // given
        when(userRepository.delete(user)).thenAnswer((_) => Future.value());

        // when
        final actual = await target.execute(user);

        // then
        expect(actual, const DeleteUserResult(status: DeleteUserStatus.success));
      });

      test('異常系', () async {
        // given
        const exception = DatabaseException(message: 'dummy message');
        when(userRepository.delete(user)).thenThrow(exception);

        // when
        final actual = await target.execute(user);

        // then
        expect(actual, const DeleteUserResult(status: DeleteUserStatus.fail, error: exception));
        verify(userRepository.delete(user)).called(1);
        verify(
          firebaseCrashlytics.log(
            'delete user error [id][${user.id}][error][$exception][nestedError][${exception.cause}]',
          ),
        ).called(1);
        verify(firebaseCrashlytics.recordError(exception, null)).called(1);
      });
    });
  });
}
