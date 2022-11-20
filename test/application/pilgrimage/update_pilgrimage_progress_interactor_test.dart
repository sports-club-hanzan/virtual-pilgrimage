import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:virtualpilgrimage/application/pilgrimage/temple_repository.dart';
import 'package:virtualpilgrimage/application/pilgrimage/update_pilgrimage_progress_interactor.dart';
import 'package:virtualpilgrimage/application/pilgrimage/update_pilgrimage_progress_result.codegen.dart';
import 'package:virtualpilgrimage/application/pilgrimage/update_pilgrimage_progress_usecase.dart';
import 'package:virtualpilgrimage/application/user/health/health_repository.dart';
import 'package:virtualpilgrimage/domain/customizable_date_time.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/pilgrimage_info.codegen.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/temple_info.codegen.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/virtual_position_calculator.dart';
import 'package:virtualpilgrimage/domain/user/health/health_by_period.codegen.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

import '../../helper/fakes/fake_user_repository.dart';
import '../../helper/provider_container.dart';
import 'update_pilgrimage_progress_interactor_test.mocks.dart';

@GenerateMocks([TempleRepository, HealthRepository])
void main() {
  late UpdatePilgrimageProgressInteractor target;
  late TempleRepository templeRepository;
  late HealthRepository healthRepository;
  final user = defaultUser();
  final userRepository = FakeUserRepository(user);
  final virtualPositionCalculator = VirtualPositionCalculator();
  final logger = Logger(level: Level.nothing);

  final container = mockedProviderContainer();

  setUp(() {
    templeRepository = MockTempleRepository();
    healthRepository = MockHealthRepository();
    target = UpdatePilgrimageProgressInteractor(
      templeRepository,
      healthRepository,
      userRepository,
      virtualPositionCalculator,
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
          status: UpdatePilgrimageProgressResultStatus.success,
          reachedPilgrimageIdList: [86, 87, 1],
          updatedUser: user.copyWith(
            updatedAt: CustomizableDateTime.current,
            pilgrimage: user.pilgrimage.copyWith(
              nowPilgrimageId: 2, // 86 -> 87 -> 88(スタート地点がリセットされて1) -> 2
              lap: 2, // 88にたどり着いたのでlap++
              movingDistance: 1600 + 100, // (27000 - (7000 + 17000 + 1400)) + 100(元々ユーザ情報に保持していた距離)
              updatedAt: CustomizableDateTime.current,
            ),
          ),
          virtualPolylineLatLngs: virtualPolylineLatLngs(),
          virtualPosition: virtualUserPosition(),
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
        // お遍路の進捗計算・仮想的な移動経路の取得で2度呼ばれるはず
        verify(templeRepository.getTempleInfo(2)).called(2);
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
    pilgrimage: PilgrimageInfo(
      id: 'dummyId',
      nowPilgrimageId: 86,
      updatedAt: DateTime.utc(2022),
      movingDistance: 100,
    ),
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
        encodedPoints:
            'k}npE{`~qXCAGOESICuAJIHIPQJNn@N|@n@vEDRHl@XC`CUjAMrCStFEfB?L??IBGPBfBBhB?tD?xBKn@G~@ORMRATIxAq@t@WdAg@bAg@`@Y|@_@\\MTGfBc@pDo@jIoAbBOv@Kj@Ij@OXBd@Ib@@tCGnFOfAA`@@zAPn@RdAd@lBn@bAXnE`AzCn@dCj@f@Pt@Z`A\\~@PfAB|CApDAbKOzBEnBOzBEbADfBPnDn@zAVvD`AtCt@|Cz@`Cv@`NlEfEvAz@T|AVlAJ|ADjHTl@FPCf@@p@Dj@@tABxCJdFN`ABbAAj@Gh@MPIZOBHDN@N|@Hh@FDFCl@AxAPx@N^^^H@ZA|Cd@TH@D`AN`@Df@`DNnADbBn@E`AA|@@d@BhBVnAHrBJ`AJZD?Pt@Ft@HlBD~@D~AIpA?n@ElE?r@@JAHGLa@bAEbAE`ABRATEr@YJCbACV?@a@|AJb@@lAKpDBH??LAb@AbBA^w@GUAAA@m@',
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
        encodedPoints:
            'utcpE{k|qX?n@lAH?Rb@?dABn@E^@HD|BDzDA`CAvCHtEPp@WbBATC~BLn@?n@GTKfAONAFi@?}AzEs@pBDnABxASb@Cn@F~Cb@`CLfFa@jGYtFz@dALr@@|@GlAUfO}EtIoC`EkAhBa@bBUfFi@pI{@v@El@Dr@JvA\\fElBfPdIhJxElAj@n@P~@Lv@?|@K~Ac@~DmAnA[rA@~@TbAh@|A|@~@XnAPpBGvCE`DQlDQn@Yt@g@l@Wv@Kh@?h@Kd@UVUd@e@\\Sf@Oh@Gz@ETGZQLMJBf@Dn@ETOf@OH?HJTz@NHTGBMW_BQyAIg@DKNCFP?VJX~@hAR@XE^HZ?ZYLCv@Db@Eb@Dn@Rv@D`@Gj@Gf@Bj@EPCp@Df@Df@ZzAG|AOTUXk@n@k@FYIi@Sk@Ca@Rc@RULGLBBNCZI`@d@l@l@b@x@^LV?ZELWPMRDRTT~@z@^P^F`BEZNRRZDfAYjAGl@DVFP@DGCUu@_@w@sBG_@@ILEDBFTBNTZ^V\\LTAZKTU?i@Es@BWJIXAl@Pd@Bj@GREl@Y\\WPe@l@aAPsAZu@F[XS\\WNSnAY`@HHJLTNHZKr@c@^Mf@D^DNLRb@TJf@HXNTVn@F`A@|@Xj@X`@Hz@BrANhBPxBVnAEdAG|@FpABj@@TLj@\\x@Fl@Hf@E^Hp@XdAp@`@Nn@_AVWRw@b@k@p@}@HSXRpA^hBVf@A^Kj@c@xCkD|AcBx@_@n@Et@Hh@RrDvB~@\\nAJhBJ`@Fd@PhGtCvBhA^Zz@dAHb@RVNIZG~@B?fA?v@JhAp@rBXp@HHVL~@LXAbA[r@Ux@?tBhAZJLJPPn@?`BDl@EdA]LYPuBTy@|@yA\\i@^[LKBQ?QNSPi@VsAPo@rA{BZk@Je@BkGXuIJkBZqA\\k@`@c@~Ay@lBs@jEgBjA_A`@i@j@sAVmAHaA@yDPy@Ru@T[j@[fBSz@Kd@Ov@e@jA]b@Ov@o@NULeA^iER_AZy@jAuBDcBIo@s@uA[i@IIa@Ym@i@k@O{@i@wAsAwAk@yEqBuC{@SO{A_DoBmCgCwEo@cAG[Eo@MW}Au@KMMeAMUUGk@W[k@I{@MWiBwAw@q@UE]KMQQs@MYaAc@k@c@Q]CQGQeAo@sAiAOUOo@Iw@B_@Cq@OiAa@w@kBwCmBmBi@m@Uk@EQMEgACe@Is@_@WYy@{@q@g@KOO_Aa@{A]u@Qm@@e@DIAOK_@Iw@Gu@i@eF[sAUq@c@?G??F?JNb@LXEC][_@IIBMV?JJDL@',
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
        encodedPoints:
            'mwnoEuc}sXJ?z@Z\\D?h@@|@TtBPx@rAtD\\pALh@X|B\\hDHtABf@Jf@Bh@HTBTRtBl@hFRdA\\lAHPx@vCl@xBx@vB^l@bAxAx@v@GHC|@?\\Cn@e@Ny@TOx@O?E@In@',
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
        encodedPoints:
            '{bnoEmszsXLq@H?F?@CLw@~Aa@By@BsAFITPZVn@^dAf@~@\\jExANF?DPn@Xl@rAxCN`@Fj@@t@FnABNLd@z@xB\\hAR\\^Tf@T^\\r@|@lB~C~@hBx@~ARv@Ph@r@vANj@Bh@@jATrC?dAOrAG\\?^F\\Lb@h@bAHZB`@`AjBnA`CTzAJ~@?f@Cr@OlBA`APfC@f@HPFHMLQV_@v@Sr@If@Et@ClA@d@Fr@f@hDRnANfBL`CHh@BLHNl@VPL|AhAHARf@FTDr@Dj@Hh@h@vAj@lAQ@oAMG@ABElAAfAALSAm@CSCc@SOI',
      ),
    ),
  );
}

// @formatter:off
List<LatLng> virtualPolylineLatLngs() => const [LatLng(34.15614, 134.49031), LatLng(34.15607, 134.49056), LatLng(34.15602, 134.49056), LatLng(34.15598, 134.49056), LatLng(34.15597, 134.49058), LatLng(34.1559, 134.49086), LatLng(34.15542, 134.49103), LatLng(34.1554, 134.49132), LatLng(34.15538, 134.49174), LatLng(34.15534, 134.49179), LatLng(34.15523, 134.4917), LatLng(34.15509, 134.49158), LatLng(34.15485, 134.49142), LatLng(34.1545, 134.49122), LatLng(34.15418, 134.49107), LatLng(34.15316, 134.49062), LatLng(34.15308, 134.49058), LatLng(34.15308, 134.49055), LatLng(34.15299, 134.49031), LatLng(34.15286, 134.49008), LatLng(34.15244, 134.48931), LatLng(34.15236, 134.48914), LatLng(34.15232, 134.48892), LatLng(34.15231, 134.48865), LatLng(34.15227, 134.48825), LatLng(34.15225, 134.48817), LatLng(34.15218, 134.48798), LatLng(34.15188, 134.48737), LatLng(34.15173, 134.487), LatLng(34.15163, 134.48685), LatLng(34.15147, 134.48674), LatLng(34.15127, 134.48663), LatLng(34.15111, 134.48648), LatLng(34.15085, 134.48617), LatLng(34.1503, 134.48537), LatLng(34.14998, 134.48484), LatLng(34.14969, 134.48436), LatLng(34.14959, 134.48408), LatLng(34.1495, 134.48387), LatLng(34.14924, 134.48343), LatLng(34.14916, 134.48321), LatLng(34.14914, 134.483), LatLng(34.14913, 134.48262), LatLng(34.14902, 134.48188), LatLng(34.14902, 134.48153), LatLng(34.1491, 134.48111), LatLng(34.14914, 134.48096), LatLng(34.14914, 134.4808), LatLng(34.1491, 134.48065), LatLng(34.14903, 134.48047), LatLng(34.14882, 134.48013), LatLng(34.14877, 134.47999), LatLng(34.14875, 134.47982), LatLng(34.14842, 134.47928), LatLng(34.14802, 134.47863), LatLng(34.14791, 134.47817), LatLng(34.14785, 134.47785), LatLng(34.14785, 134.47765), LatLng(34.14787, 134.47739), LatLng(34.14795, 134.47684), LatLng(34.14796, 134.47651), LatLng(34.14787, 134.47583), LatLng(34.14786, 134.47563), LatLng(34.14781, 134.47554), LatLng(34.14777, 134.47549), LatLng(34.14784, 134.47542), LatLng(34.14793, 134.4753), LatLng(34.14809, 134.47502), LatLng(34.14819, 134.47476), LatLng(34.14824, 134.47456), LatLng(34.14827, 134.47429), LatLng(34.14829, 134.4739), LatLng(34.14828, 134.47371), LatLng(34.14824, 134.47345), LatLng(34.14804, 134.4726), LatLng(34.14794, 134.4722), LatLng(34.14786, 134.47168), LatLng(34.14779, 134.47103), LatLng(34.14774, 134.47082), LatLng(34.14772, 134.47075), LatLng(34.14767, 134.47067), LatLng(34.14744, 134.47055), LatLng(34.14735, 134.47048), LatLng(34.14688, 134.47011), LatLng(34.14683, 134.47012), LatLng(34.14673, 134.46992), LatLng(34.14669, 134.46981), LatLng(34.14666, 134.46955), LatLng(34.14663, 134.46933), LatLng(34.14658, 134.46912), LatLng(34.14637, 134.46868), LatLng(34.14615, 134.46829), LatLng(34.14624, 134.46828), LatLng(34.14664, 134.46835), LatLng(34.14668, 134.46834), LatLng(34.14669, 134.46832), LatLng(34.14672, 134.46793), LatLng(34.14673, 134.46757), LatLng(34.14674, 134.4675), LatLng(34.14684, 134.46751), LatLng(34.14707, 134.46753), LatLng(34.14717, 134.46755), LatLng(34.14735, 134.46765), LatLng(34.14743, 134.4677)];
LatLng virtualUserPosition() => const LatLng(34.1483200512593, 134.47911758219774);
// @formatter:on
