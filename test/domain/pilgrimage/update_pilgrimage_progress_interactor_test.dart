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
          [86, 87, 1],
          user.copyWith(
            updatedAt: CustomizableDateTime.current,
            pilgrimage: user.pilgrimage.copyWith(
              nowPilgrimageId: 2, // 86 -> 87 -> 88(スタート地点がリセットされて1) -> 2
              lap: 2, // 88にたどり着いたのでlap++
              movingDistance: 1600, // 27000 - (7000 + 17000 + 1400)
              updatedAt: CustomizableDateTime.current,
            ),
          ),
        );

        // when
        final actual = await target.execute(user.id);

        // then
        expect(actual, expected);
        // call される順に verify
        // 1. 現在たどり着いている86番札所の情報（87までの距離）とヘルスケア情報を取得
        // 2. 86番札所の歩数 < 移動距離 であったため、87番札所の情報を取得
        // 3. 87番札所の歩数 < 移動距離 であったため、1番札所の情報を取得
        //    (88 -> 1 へは移動せず、1番札所からリスタートするため)
        // 4. 01番札所の歩数 < 移動距離 であったため、2番札所の情報を取得
        verify(templeRepository.getTempleInfo(86)).called(1);
        verify(
          healthRepository.getHealthByPeriod(
            from: user.updatedAt,
            to: CustomizableDateTime.current,
          ),
        );
        verify(templeRepository.getTempleInfo(87)).called(1);
        verify(templeRepository.getTempleInfo(1)).called(1);
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
  when(templeRepository.getTempleInfo(86)).thenAnswer(
    (_) => Future.value(
      const TempleInfo(
        id: 86,
        name: '志度寺',
        address: '香川県さぬき市志度１１０２',
        // 7km
        distance: 7000,
        geoPoint: GeoPoint(34.32433333, 134.1796667),
        prefecture: '香川県',
      ),
    ),
  );
  when(templeRepository.getTempleInfo(87)).thenAnswer(
    (_) => Future.value(
      const TempleInfo(
        id: 87,
        name: '長尾寺',
        address: '香川県さぬき市長尾西653',
        // 17km
        distance: 17000,
        geoPoint: GeoPoint(34.26680556, 134.1717778),
        prefecture: '香川県',
      ),
    ),
  );
  when(templeRepository.getTempleInfo(1)).thenAnswer(
    (_) => Future.value(
      const TempleInfo(
        id: 1,
        name: '霊山寺',
        address: '徳島県大麻町板東126',
        // 1.4km
        distance: 1400,
        geoPoint: GeoPoint(34.15944444, 134.503),
        prefecture: '徳島県',
      ),
    ),
  );
  when(templeRepository.getTempleInfo(2)).thenAnswer(
    (_) => Future.value(
      const TempleInfo(
        id: 2,
        name: '極楽寺',
        address: '徳島県鳴門市大麻町檜段の上12',
        // 2.6km
        distance: 2600,
        geoPoint: GeoPoint(34.26680556, 134.1717778),
        prefecture: '徳島県',
      ),
    ),
  );
}
