import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mockito/mockito.dart';
import 'package:virtualpilgrimage/application/user/health/update_health_interactor.dart';
import 'package:virtualpilgrimage/application/user/health/update_health_result.codegen.dart';
import 'package:virtualpilgrimage/application/user/health/update_health_usecase.dart';
import 'package:virtualpilgrimage/domain/customizable_date_time.dart';
import 'package:virtualpilgrimage/domain/exception/database_exception.dart';
import 'package:virtualpilgrimage/domain/exception/get_health_exception.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/pilgrimage_info.codegen.dart';
import 'package:virtualpilgrimage/domain/user/health/health_by_period.codegen.dart';
import 'package:virtualpilgrimage/domain/user/health/health_info.codegen.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

import '../../../helper/default_mock_firebase_crashlytics.dart';
import '../../../helper/mock.mocks.dart';
import '../../../helper/provider_container.dart';

void main() {
  late MockHealthRepository mockHealthRepository;
  late MockUserRepository mockUserRepository;
  late MockUserHealthRepository mockUserHealthRepository;
  late MockFirebaseCrashlytics mockFirebaseCrashlytics;
  final logger = Logger(level: Level.nothing);

  late UpdateHealthInteractor target;

  setUp(() {
    mockHealthRepository = MockHealthRepository();
    mockUserRepository = MockUserRepository();
    mockUserHealthRepository = MockUserHealthRepository();
    mockFirebaseCrashlytics = MockFirebaseCrashlytics();
    target = UpdateHealthInteractor(
      mockHealthRepository,
      mockUserRepository,
      mockUserHealthRepository,
      logger,
      mockFirebaseCrashlytics,
    );
  });

  group('UpdateHealthInteractor', () {
    final user = defaultUser();
    CustomizableDateTime.customTime = DateTime.now();
    final health = HealthInfo(
      today: defaultHealthByPeriod(steps: 10, distance: 10, burnedCalorie: 10),
      yesterday: defaultHealthByPeriod(steps: 100, distance: 100, burnedCalorie: 100),
      week: defaultHealthByPeriod(steps: 0, distance: 1000, burnedCalorie: 1000),
      month: defaultHealthByPeriod(steps: 1000, distance: 10000, burnedCalorie: 10000),
      totalSteps: 1000,
      totalDistance: 0,
      updatedAt: CustomizableDateTime.current,
    );
    final updatedUser = user.copyWith(
      health: HealthInfo(
        today: defaultHealthByPeriod(steps: 10, distance: 10, burnedCalorie: 10),
        yesterday: defaultHealthByPeriod(steps: 100, distance: 100, burnedCalorie: 100),
        week: defaultHealthByPeriod(),
        month: defaultHealthByPeriod(steps: 1000, distance: 10000, burnedCalorie: 10000),
        totalSteps: 1000,
        totalDistance: 100,
        updatedAt: CustomizableDateTime.current,
      ),
    );

    setUp(() {
      CustomizableDateTime.customTime = DateTime.now();
      when(
        mockHealthRepository.getHealthInfo(
          targetDateTime: CustomizableDateTime.current,
          createdAt: user.createdAt,
        ),
      ).thenAnswer((realInvocation) => Future.value(health));
      when(mockUserRepository.update(updatedUser)).thenAnswer((_) => Future.value());
    });

    test('DI', () {
      final container = mockedProviderContainer();
      final usecase = container.read(updateHealthUsecaseProvider);
      expect(usecase, isNotNull);
    });

    group('正常系', () {
      test('ヘルスケア情報を更新できる', () async {
        // when
        final actual = await target.execute(user);

        // then
        expect(actual, UpdateHealthResult(status: UpdateHealthStatus.success, user: updatedUser));
        verify(
          mockHealthRepository.getHealthInfo(
            targetDateTime: CustomizableDateTime.current,
            createdAt: user.createdAt,
          ),
        ).called(1);
        verify(mockUserRepository.update(updatedUser)).called(1);
      });
    });

    group('異常系', () {
      setUp(() {
        defaultMockFirebaseCrashlytics(mockFirebaseCrashlytics);
      });
      test('ヘルスケア情報の取得に失敗', () async {
        // given
        when(
          mockHealthRepository.getHealthInfo(
            targetDateTime: anyNamed('targetDateTime'),
            createdAt: anyNamed('createdAt'),
          ),
        ).thenThrow(
          GetHealthException(message: 'dummy', status: GetHealthExceptionStatus.notAuthorized),
        );

        // when
        final actual = await target.execute(user);

        // then
        expect(actual.status, UpdateHealthStatus.getHealthError);
        verify(
          mockHealthRepository.getHealthInfo(
            targetDateTime: anyNamed('targetDateTime'),
            createdAt: anyNamed('createdAt'),
          ),
        ).called(1);
        verifyNever(mockUserRepository.update(any)).called(0);
        verify(mockFirebaseCrashlytics.log(any)).called(1);
        verify(mockFirebaseCrashlytics.recordError(any, null)).called(1);
      });

      test('DBへの保存に失敗', () async {
        // given
        when(
          mockUserRepository.update(any),
        ).thenThrow(DatabaseException(message: 'dummy', cause: FirebaseException(plugin: 'dummy')));

        // when
        final actual = await target.execute(user);

        // then
        expect(actual.status, UpdateHealthStatus.updateUserError);
        verify(
          mockHealthRepository.getHealthInfo(
            targetDateTime: anyNamed('targetDateTime'),
            createdAt: anyNamed('createdAt'),
          ),
        ).called(1);
        verify(mockUserRepository.update(any)).called(1);
        verify(mockFirebaseCrashlytics.log(any)).called(2);
        verify(mockFirebaseCrashlytics.recordError(any, null)).called(1);
      });

      test('未知の例外が発生', () async {
        // given
        when(
          mockHealthRepository.getHealthInfo(
            targetDateTime: anyNamed('targetDateTime'),
            createdAt: anyNamed('createdAt'),
          ),
        ).thenThrow(Exception('dummy'));

        // when
        final actual = await target.execute(user);

        // then
        expect(actual.status, UpdateHealthStatus.unknownError);
        verify(
          mockHealthRepository.getHealthInfo(
            targetDateTime: anyNamed('targetDateTime'),
            createdAt: anyNamed('createdAt'),
          ),
        ).called(1);
        verifyNever(mockUserRepository.update(any)).called(0);
        verify(mockFirebaseCrashlytics.log(any)).called(1);
        verify(mockFirebaseCrashlytics.recordError(any, null)).called(1);
      });
    });
  });
}

VirtualPilgrimageUser defaultUser() {
  return VirtualPilgrimageUser(
    id: 'dummyId',
    nickname: 'dummyName',
    birthDay: DateTime.utc(2000),
    email: 'test@example.com',
    userIconUrl: '',
    userStatus: UserStatus.created,
    createdAt: CustomizableDateTime.current.subtract(const Duration(days: 14)),
    updatedAt: CustomizableDateTime.current.subtract(const Duration(days: 10)),
    health: HealthInfo(
      today: defaultHealthByPeriod(),
      yesterday: defaultHealthByPeriod(),
      week: defaultHealthByPeriod(),
      month: defaultHealthByPeriod(),
      totalSteps: 100,
      totalDistance: 100,
      updatedAt: CustomizableDateTime.current,
    ),
    pilgrimage: PilgrimageInfo(id: 'dummyId', updatedAt: CustomizableDateTime.current),
  );
}

HealthByPeriod defaultHealthByPeriod({int steps = 10, int distance = 10, int burnedCalorie = 10}) {
  return HealthByPeriod(steps: steps, distance: distance, burnedCalorie: burnedCalorie);
}
