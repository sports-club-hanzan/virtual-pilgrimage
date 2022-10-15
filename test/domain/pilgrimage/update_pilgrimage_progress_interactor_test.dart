import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:virtualpilgrimage/domain/customizable_date_time.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/update_pilgrimage_progress_interactor.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/update_pilgrimage_progress_result.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/update_pilgrimage_progress_usecase.dart';
import 'package:virtualpilgrimage/domain/temple/temple_info.codegen.dart';
import 'package:virtualpilgrimage/domain/temple/temple_repository.dart';
import 'package:virtualpilgrimage/domain/user/health/health_by_period.codegen.dart';
import 'package:virtualpilgrimage/domain/user/health/health_repository.dart';
import 'package:virtualpilgrimage/domain/user/pilgrimage/pilgrimage_info.codegen.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

import '../../helper/fake_user_repository.dart';
import '../../helper/provider_container.dart';
import 'update_pilgrimage_progress_interactor_test.mocks.dart';

@GenerateMocks([TempleRepository, HealthRepository])
void main() {
  late UpdatePilgrimageProgressInteractor target;
  late TempleRepository templeRepository;
  late HealthRepository healthRepository;
  final user = defaultUser();
  final userRepository = FakeUserRepository(user);
  final logger = Logger(level: Level.nothing);

  final container = mockedProviderContainer();

  setUp(() {
    templeRepository = MockTempleRepository();
    healthRepository = MockHealthRepository();
    target = UpdatePilgrimageProgressInteractor(
      templeRepository,
      healthRepository,
      userRepository,
      logger,
    );

    CustomizableDateTime.customTime = DateTime.now();
  });

  group('UpdatePilgrimageProgressInteractor', () {
    test('DI', () {
      final actual = container.read(updatePilgrimageProgressUsecaseProvider);
      expect(actual, isNotNull);
    });

    group('execute', () {
      test('正常系', () async {
        // given
        setupTempleRepositoryMock(templeRepository);
        when(
          healthRepository.getHealthByPeriod(
            from: DateTime.utc(2022),
            to: CustomizableDateTime.current,
          ),
        ).thenAnswer(
          (_) => Future.value(const HealthByPeriod(steps: 0, distance: 27000, burnedCalorie: 0)),
        );

        final expected = UpdatePilgrimageProgressResult(
          UpdatePilgrimageProgressResultStatus.success,
          [87, 88],
        );

        // when
        final actual = await target.execute(user);

        // then
        expect(actual, expected);
        // call される順に verify
        // 1. 次の札所である87番札所の情報とヘルスケア情報を取得
        // 2. 87番札所の歩数 < 移動距離 であったため、88番札所の情報を取得
        // 3. 88番札所の歩数 < 移動距離 であったため、2番札所の情報を取得
        //    (1番札所からリスタートするため、次の目的地は2番札所。仕様が変わったらテストも修正する)
        verify(templeRepository.getTempleInfo(87)).called(1);
        verify(
          healthRepository.getHealthByPeriod(
            from: user.updatedAt,
            to: CustomizableDateTime.current,
          ),
        );
        verify(templeRepository.getTempleInfo(88)).called(1);
        verify(templeRepository.getTempleInfo(2)).called(1);
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
    createdAt: DateTime.utc(2022),
    updatedAt: DateTime.utc(2022),
    pilgrimage: PilgrimageInfo(id: 'dummyId', nowPilgrimageId: 86, updatedAt: DateTime.utc(2022)),
  );
}

void setupTempleRepositoryMock(TempleRepository templeRepository) {
  when(templeRepository.getTempleInfo(87)).thenAnswer(
    (_) => Future.value(
      const TempleInfo(
        id: 87,
        name: '長尾寺',
        address: '香川県さぬき市長尾西653',
        // 7km
        distance: 7000,
        geoPoint: GeoPoint(34.26680556, 134.1717778),
        prefecture: '香川県',
      ),
    ),
  );
  when(templeRepository.getTempleInfo(88)).thenAnswer(
    (_) => Future.value(
      const TempleInfo(
        id: 88,
        name: '大窪寺',
        address: '香川県さぬき市多和兼割96',
        // 17km
        distance: 17000,
        geoPoint: GeoPoint(34.26680556, 134.1717778),
        prefecture: '香川県',
      ),
    ),
  );
  when(templeRepository.getTempleInfo(2)).thenAnswer(
    (_) => Future.value(
      const TempleInfo(
        id: 2,
        name: '極楽寺',
        address: '徳島県鳴門市大麻町檜段の上12',
        // 17km
        distance: 17000,
        geoPoint: GeoPoint(34.26680556, 134.1717778),
        prefecture: '徳島県',
      ),
    ),
  );
}
