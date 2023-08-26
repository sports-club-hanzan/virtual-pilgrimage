import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:virtualpilgrimage/domain/customizable_date_time.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/pilgrimage_info.codegen.dart';
import 'package:virtualpilgrimage/domain/user/health/health_by_period.codegen.dart';
import 'package:virtualpilgrimage/domain/user/health/health_info.codegen.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

import '../../helper/mock.mocks.dart';

void main() {
  tz.initializeTimeZones();
  CustomizableDateTime.customTime = DateTime.utc(2023, 1, 1, 0, 0, 0);

  group('VirtualPilgrimageUser', () {
    group('initializeForSignIn', () {
      test('photoURLが登録されている場合', () {
        // given
        final user = MockUser();
        when(user.uid).thenReturn('user_id');
        when(user.email).thenReturn('test@test.com');
        when(user.photoURL).thenReturn('http://example.com');

        // when
        final actual = VirtualPilgrimageUser.initializeForSignIn(user);

        // then
        final expected = VirtualPilgrimageUser(
          id: 'user_id',
          email: 'test@test.com',
          userIconUrl: 'http://example.com',
          birthDay: DateTime.utc(1980, 1, 1),
          createdAt: CustomizableDateTime.current,
          updatedAt: CustomizableDateTime.current,
          pilgrimage: PilgrimageInfo(
            id: 'user_id',
            updatedAt: CustomizableDateTime.current,
          ),
        );
        expect(actual, expected);
      });

      test('photoURLが登録されていない場合', () {
        // given
        final user = MockUser();
        when(user.uid).thenReturn('user_id');
        when(user.email).thenReturn('test@test.com');
        when(user.photoURL).thenReturn(null);

        // when
        final actual = VirtualPilgrimageUser.initializeForSignIn(user);

        // then
        final expected = VirtualPilgrimageUser(
          id: 'user_id',
          email: 'test@test.com',
          userIconUrl:
              'https://firebasestorage.googleapis.com/v0/b/virtual-pilgrimage-dev.appspot.com/o/icon512.jpg?alt=media',
          birthDay: DateTime.utc(1980, 1, 1),
          createdAt: CustomizableDateTime.current,
          updatedAt: CustomizableDateTime.current,
          pilgrimage: PilgrimageInfo(
            id: 'user_id',
            updatedAt: CustomizableDateTime.current,
          ),
        );
        expect(actual, expected);
      });
    });

    // ユーザ登録フォームから入力されたユーザ情報を更新
    test('fromRegistrationForm', () {
      // given
      final user = createUser();
      const nickname = 'test_user';
      const gender = Gender.man;
      final birthday = DateTime.utc(1990, 1, 1);

      // 実行
      final actual = user.fromRegistrationForm(nickname, gender, birthday);

      // 検証
      final expected = user.copyWith(
        nickname: 'test_user',
        gender: Gender.man,
        birthDay: DateTime.utc(1990, 1, 1),
        userStatus: UserStatus.created,
      );
      expect(actual, expected);
    });

    test('toRegistration', () {
      // given
      final target = createUser();

      // when
      final actual = target.toRegistration();

      // then
      expect(actual, target.copyWith(userStatus: UserStatus.created));
    });

    test('toDelete', () {
      // given
      final target = createUser();

      // when
      final actual = target.toDelete();

      // then
      expect(actual, target.copyWith(userStatus: UserStatus.deleted));
    });

    test('updateUserIconUrl', () {
      // given
      final target = createUser();

      // when
      final actual = target.updateUserIconUrl('http://example.com/image.png');

      // then
      final expected = target.copyWith(
        userIconUrl: 'http://example.com/image.png',
        updatedAt: CustomizableDateTime.current,
      );
      expect(actual, expected);
    });

    group('convertForProfile', () {
      final defaultTarget = createUser(
        health: HealthInfo(
          today: const HealthByPeriod(steps: 100, distance: 120, burnedCalorie: 130),
          yesterday: const HealthByPeriod(steps: 200, distance: 240, burnedCalorie: 260),
          week: const HealthByPeriod(steps: 20000, distance: 24000, burnedCalorie: 26000),
          month: const HealthByPeriod(steps: 100000, distance: 120000, burnedCalorie: 130000),
          updatedAt: CustomizableDateTime.current,
          totalSteps: 100000000000,
          totalDistance: 300000000,
        ),
        updateTime: DateTime.utc(2023, 1, 1, 23, 59, 59),
      );
      test('変換がない場合', () {
        // given
        final target = defaultTarget;

        // when
        final actual = target.convertForProfile();

        // then
        final expected = target.copyWith();
        expect(actual, expected);
      });

      test('更新日が昨日の場合', () {
        // given
        final target = defaultTarget.copyWith(
          updatedAt: DateTime.utc(2022, 12, 31, 23, 59, 59),
        );

        // when
        final actual = target.convertForProfile();

        // then
        final expected = target.copyWith(
          health: target.health!.copyWith(
            today: HealthByPeriod.getDefault(),
            yesterday: const HealthByPeriod(steps: 100, distance: 120, burnedCalorie: 130),
          ),
        );
        expect(actual, expected);
      });

      test('更新日が一昨日以前の場合', () {
        // given
        final target = defaultTarget.copyWith(
          updatedAt: DateTime.utc(2022, 12, 29, 12, 34, 56),
        );

        // when
        final actual = target.convertForProfile();

        // then
        final expected = target.copyWith(
          health: target.health!.copyWith(
            today: HealthByPeriod.getDefault(),
            yesterday: HealthByPeriod.getDefault(),
          ),
        );
        expect(actual, expected);
      });
    });

    test('updatePilgrimageProgress', () {
      // given
      final target = createUser();

      // when
      final actual = target.updatePilgrimageProgress(87, 2, 3000, DateTime(2023, 1, 1, 23, 59, 59));

      // then
      final expected = target.copyWith(
        pilgrimage: target.pilgrimage.copyWith(
          nowPilgrimageId: 87,
          lap: 2,
          movingDistance: 3000,
          updatedAt: DateTime(2023, 1, 1, 23, 59, 59),
        ),
        updatedAt: DateTime(2023, 1, 1, 23, 59, 59),
      );
      expect(actual, expected);
    });
  });
}

VirtualPilgrimageUser createUser({
  DateTime? updateTime,
  HealthInfo? health,
}) {
  return VirtualPilgrimageUser(
    id: 'dummyId',
    nickname: 'dummyName',
    birthDay: DateTime.utc(2000),
    email: 'test@example.com',
    userIconUrl: '',
    userStatus: UserStatus.created,
    createdAt: CustomizableDateTime.current,
    updatedAt: updateTime ?? CustomizableDateTime.current,
    pilgrimage: PilgrimageInfo(id: 'dummyId', updatedAt: CustomizableDateTime.current),
    health: health,
  );
}
