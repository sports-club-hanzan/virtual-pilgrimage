import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:virtualpilgrimage/domain/customizable_date_time.dart';
import 'package:virtualpilgrimage/domain/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/ui/pages/profile/profile_presenter.dart';
import 'package:virtualpilgrimage/ui/pages/profile/profile_state.codegen.dart';

import '../../../helper/fake_user_repository.dart';
import '../../../helper/provider_container.dart';

void main() {
  late ProfilePresenter target;
  late UserRepository userRepository;
  const id = 'dummyId';
  late VirtualPilgrimageUser user;

  setUp(() {
    final container = mockedProviderContainer();
    target = container.read(profileProvider.notifier);

    CustomizableDateTime.customTime = DateTime.now();
    user = VirtualPilgrimageUser(
      id: id,
      birthDay: CustomizableDateTime.current,
      createdAt: CustomizableDateTime.current,
      updatedAt: CustomizableDateTime.current,
    );
    userRepository = FakeUserRepository(user);
  });

  group('profileUserProvider', () {
    late ProviderContainer container;
    final loginUser = VirtualPilgrimageUser(
      id: 'dummyLoginUserId',
      birthDay: CustomizableDateTime.current,
      createdAt: CustomizableDateTime.current,
      updatedAt: CustomizableDateTime.current,
    );
    setUp(() {
      container = mockedProviderContainer(
        overrides: [userRepositoryProvider.overrideWithValue(userRepository)],
      );
      container.read(userStateProvider.notifier).state = loginUser;
    });

    test('ログインユーザと同じユーザを取得する場合', () async {
      final actualLoading = container.read(profileUserProvider('dummyLoginUserId'));
      expect(actualLoading, const AsyncValue<VirtualPilgrimageUser?>.loading());

      await Future<void>.value();

      final actualValue = container.read(profileUserProvider('dummyLoginUserId')).value;
      expect(actualValue, loginUser);
    });

    test('ログインユーザと違うユーザを取得', () async {
      final expected = VirtualPilgrimageUser(
        id: 'dummyId',
        birthDay: CustomizableDateTime.current,
        createdAt: CustomizableDateTime.current,
        updatedAt: CustomizableDateTime.current,
      );

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
      expect(target.tabLabels(), ['昨日', '週間', '月間']);
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
