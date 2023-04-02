import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:virtualpilgrimage/application/user/health/health_repository.dart';
import 'package:virtualpilgrimage/application/user/health/user_health_repository.dart';
import 'package:virtualpilgrimage/application/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/customizable_date_time.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/pilgrimage_info.codegen.dart';
import 'package:virtualpilgrimage/domain/user/health/health_by_period.codegen.dart';
import 'package:virtualpilgrimage/domain/user/health/health_info.codegen.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/ui/pages/profile/profile_presenter.dart';
import 'package:virtualpilgrimage/ui/pages/profile/profile_state.codegen.dart';

import '../../../helper/fakes/fake_health_repository.dart';
import '../../../helper/fakes/fake_user_health_repository.dart';
import '../../../helper/fakes/fake_user_repository.dart';
import '../../../helper/provider_container.dart';

void main() {
  late ProfilePresenter target;
  late UserRepository userRepository;
  late HealthRepository healthRepository;
  const id = 'dummyId';
  late VirtualPilgrimageUser user;
  late HealthByPeriod healthByPeriod;
  late HealthInfo healthInfo;

  setUpAll(() {
    CustomizableDateTime.customTime = DateTime.now();
  });

  setUp(() {
    final container = mockedProviderContainer();
    target = container.read(profileProvider.notifier);

    user = VirtualPilgrimageUser(
      id: id,
      birthDay: CustomizableDateTime.current,
      createdAt: CustomizableDateTime.current,
      updatedAt: CustomizableDateTime.current,
      pilgrimage: PilgrimageInfo(id: id, updatedAt: CustomizableDateTime.current),
    );
    userRepository = FakeUserRepository(user);

    healthByPeriod = const HealthByPeriod(steps: 1100, distance: 1000, burnedCalorie: 100);
    healthInfo = HealthInfo(
      today: const HealthByPeriod(steps: 100, distance: 100, burnedCalorie: 100),
      yesterday: const HealthByPeriod(steps: 200, distance: 200, burnedCalorie: 200),
      week: const HealthByPeriod(steps: 10000, distance: 10000, burnedCalorie: 10000),
      month: const HealthByPeriod(steps: 50000, distance: 50000, burnedCalorie: 50000),
      updatedAt: CustomizableDateTime.current,
      totalSteps: 100000,
      totalDistance: 80000,
    );
    healthRepository = FakeHealthRepository(healthByPeriod: healthByPeriod, healthInfo: healthInfo);
  });

  group('profileUserProvider', () {
    late ProviderContainer container;
    final loginUser = VirtualPilgrimageUser(
      id: 'dummyLoginUserId',
      birthDay: CustomizableDateTime.current,
      createdAt: CustomizableDateTime.current,
      updatedAt: CustomizableDateTime.current,
      pilgrimage: PilgrimageInfo(id: 'dummyLoginUserId', updatedAt: CustomizableDateTime.current),
    );
    setUp(() {
      container = mockedProviderContainer(
        overrides: [
          userRepositoryProvider.overrideWithValue(userRepository),
          healthRepositoryProvider.overrideWithValue(healthRepository),
        ],
      );
      container.read(userStateProvider.notifier).state = loginUser;
    });

    test('ログインユーザと同じユーザを取得する場合', () async {
      container = mockedProviderContainer(
        overrides: [
          userRepositoryProvider.overrideWithValue(FakeUserRepository(loginUser)),
          userHealthRepositoryProvider.overrideWithValue(FakeUserHealthRepository()),
          healthRepositoryProvider.overrideWithValue(healthRepository),
        ],
      );
      container.read(userStateProvider.notifier).state = loginUser;
      final actualLoading = container.read(profileUserProvider('dummyLoginUserId'));
      expect(actualLoading, const AsyncValue<VirtualPilgrimageUser?>.loading());

      // UseCaseでの更新処理と取得処理の3つをawaitするため、3回 + UseCase の async 待ちの4回 await
      await Future<void>.value();
      await Future<void>.value();
      await Future<void>.value();
      await Future<void>.value();

      final actualValue = container.read(profileUserProvider('dummyLoginUserId')).value;
      expect(actualValue, loginUser.copyWith(health: healthInfo));
    });

    test('ログインユーザと違うユーザを取得', () async {
      final expected = user;

      final actualLoading = container.read(profileUserProvider('dummyId'));
      expect(actualLoading, const AsyncValue<VirtualPilgrimageUser?>.loading());

      await Future<void>.value();

      final actualValue = container.read(profileUserProvider('dummyId')).value;
      expect(actualValue, expected);
    });
  });

  group('ProfilePresenter', () {
    test('DI', () {
      expect(target, isNotNull);
    });

    test('tabLabels', () {
      expect(target.tabLabels(), ['今日', '昨日', '週間', '月間']);
    });

    test('setSelectedTabIndex', () async {
      const index = 1;
      await target.setSelectedTabIndex(index);
      expect(target.debugState, ProfileState(selectedTabIndex: index));
    });

    test('getGenderString', () {
      expect(target.getGenderString(Gender.values[0]), '');
      expect(target.getGenderString(Gender.values[1]), '男性');
      expect(target.getGenderString(Gender.values[2]), '女性');
    });

    group('getAgeString', () {
      setUp(() {
        CustomizableDateTime.customTime = DateTime(2022, 1, 1);
      });

      test('22歳 -> 20代', () {
        expect(target.getAgeString(DateTime(2000, 1, 1)), '20代');
      });

      test('あと少しで30歳 -> 20代, 1日後に日付を参照して30代', () {
        final birthday = DateTime(1992, 1, 2, 23, 59, 59, 999, 999);
        expect(target.getAgeString(birthday), '20代');
        CustomizableDateTime.customTime = DateTime(2022, 1, 2);
        expect(target.getAgeString(birthday), '30代');
      });
    });

    group('updateProfileImage', () {
      test('正常系', () async {
        // FIXME: 必要に応じてテストを書く
      });
    });
  });
}
