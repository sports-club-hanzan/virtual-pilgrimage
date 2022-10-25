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
              movingDistance: 1600 + 100, // (27000 - (7000 + 17000 + 1400)) + 100(元々ユーザ情報に保持していた距離)
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
    pilgrimage: PilgrimageInfo(id: 'dummyId', nowPilgrimageId: 86, updatedAt: DateTime.utc(2022), movingDistance: 100),
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
        encodedPoints: 'k}npE{`~qXCAGOESICuAJIHIPQJNn@N|@n@vEDRHl@XC`CUjAMrCStFEfB?L??IBGPBfBBhB?tD?xBKn@G~@ORMRATIxAq@t@WdAg@bAg@`@Y|@_@\\MTGfBc@pDo@jIoAbBOv@Kj@Ij@OXBd@Ib@@tCGnFOfAA`@@zAPn@RdAd@lBn@bAXnE`AzCn@dCj@f@Pt@Z`A\\~@PfAB|CApDAbKOzBEnBOzBEbADfBPnDn@zAVvD`AtCt@|Cz@`Cv@`NlEfEvAz@T|AVlAJ|ADjHTl@FPCf@@p@Dj@@tABxCJdFN`ABbAAj@Gh@MPIZOBHDN@N|@Hh@FDFCl@AxAPx@N^^^H@ZA|Cd@TH@D`AN`@Df@`DNnADbBn@E`AA|@@d@BhBVnAHrBJ`AJZD?Pt@Ft@HlBD~@D~AIpA?n@ElE?r@@JAHGLa@bAEbAE`ABRATEr@YJCbACV?@a@|AJb@@lAKpDBH??LAb@AbBA^w@GUAAA@m@',
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
        encodedPoints: 'utcpE{k|qX?n@lAH?Rb@?dABn@E^@HD|BDzDA`CAvCHtEPp@WbBATC~BLn@?n@GTKfAONAFi@?}AzEs@pBDnABxASb@Cn@F~Cb@`CLfFa@jGYtFz@dALr@@|@GlAUfO}EtIoC`EkAhBa@bBUfFi@pI{@v@El@Dr@JvA\\fElBfPdIhJxElAj@n@P~@Lv@?|@K~Ac@~DmAnA[rA@~@TbAh@|A|@~@XnAPpBGvCE`DQlDQn@Yt@g@l@Wv@Kh@?h@Kd@UVUd@e@\\Sf@Oh@Gz@ETGZQLMJBf@Dn@ETOf@OH?HJTz@NHTGBMW_BQyAIg@DKNCFP?VJX~@hAR@XE^HZ?ZYLCv@Db@Eb@Dn@Rv@D`@Gj@Gf@Bj@EPCp@Df@Df@ZzAG|AOTUXk@n@k@FYIi@Sk@Ca@Rc@RULGLBBNCZI`@d@l@l@b@x@^LV?ZELWPMRDRTT~@z@^P^F`BEZNRRZDfAYjAGl@DVFP@DGCUu@_@w@sBG_@@ILEDBFTBNTZ^V\\LTAZKTU?i@Es@BWJIXAl@Pd@Bj@GREl@Y\\WPe@l@aAPsAZu@F[XS\\WNSnAY`@HHJLTNHZKr@c@^Mf@D^DNLRb@TJf@HXNTVn@F`A@|@Xj@X`@Hz@BrANhBPxBVnAEdAG|@FpABj@@TLj@\\x@Fl@Hf@E^Hp@XdAp@`@Nn@_AVWRw@b@k@p@}@HSXRpA^hBVf@A^Kj@c@xCkD|AcBx@_@n@Et@Hh@RrDvB~@\\nAJhBJ`@Fd@PhGtCvBhA^Zz@dAHb@RVNIZG~@B?fA?v@JhAp@rBXp@HHVL~@LXAbA[r@Ux@?tBhAZJLJPPn@?`BDl@EdA]LYPuBTy@|@yA\\i@^[LKBQ?QNSPi@VsAPo@rA{BZk@Je@BkGXuIJkBZqA\\k@`@c@~Ay@lBs@jEgBjA_A`@i@j@sAVmAHaA@yDPy@Ru@T[j@[fBSz@Kd@Ov@e@jA]b@Ov@o@NULeA^iER_AZy@jAuBDcBIo@s@uA[i@IIa@Ym@i@k@O{@i@wAsAwAk@yEqBuC{@SO{A_DoBmCgCwEo@cAG[Eo@MW}Au@KMMeAMUUGk@W[k@I{@MWiBwAw@q@UE]KMQQs@MYaAc@k@c@Q]CQGQeAo@sAiAOUOo@Iw@B_@Cq@OiAa@w@kBwCmBmBi@m@Uk@EQMEgACe@Is@_@WYy@{@q@g@KOO_Aa@{A]u@Qm@@e@DIAOK_@Iw@Gu@i@eF[sAUq@c@?G??F?JNb@LXEC][_@IIBMV?JJDL@',
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
        encodedPoints: 'mwnoEuc}sXJ?z@Z\\D?h@@|@TtBPx@rAtD\\pALh@X|B\\hDHtABf@Jf@Bh@HTBTRtBl@hFRdA\\lAHPx@vCl@xBx@vB^l@bAxAx@v@GHC|@?\\Cn@e@Ny@TOx@O?E@In@',
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
        encodedPoints: '{bnoEmszsXLq@H?F?@CLw@~Aa@By@BsAFITPZVn@^dAf@~@\\jExANF?DPn@Xl@rAxCN`@Fj@@t@FnABNLd@z@xB\\hAR\\^Tf@T^\\r@|@lB~C~@hBx@~ARv@Ph@r@vANj@Bh@@jATrC?dAOrAG\\?^F\\Lb@h@bAHZB`@`AjBnA`CTzAJ~@?f@Cr@OlBA`APfC@f@HPFHMLQV_@v@Sr@If@Et@ClA@d@Fr@f@hDRnANfBL`CHh@BLHNl@VPL|AhAHARf@FTDr@Dj@Hh@h@vAj@lAQ@oAMG@ABElAAfAALSAm@CSCc@SOI',
      ),
    ),
  );
}
