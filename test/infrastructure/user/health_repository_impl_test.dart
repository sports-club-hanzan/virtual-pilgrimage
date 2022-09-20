import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:health/health.dart';
import 'package:logger/logger.dart';
import 'package:mockito/mockito.dart';
import 'package:virtualpilgrimage/domain/customizable_date_time.dart';
import 'package:virtualpilgrimage/domain/user/health/health_by_period.codegen.dart';
import 'package:virtualpilgrimage/domain/user/health/health_info.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/user/health_repository_impl.dart';

import '../../helper/mock.mocks.dart';

const defaultDeviceId = 'dummyDeviceId';
const defaultSourceId = 'dummySourceId';
const defaultSourceName = 'dummySourceName';

void main() {
  MockHealthFactory mockHealthFactory = MockHealthFactory();
  final logger = Logger(level: Level.nothing);
  HealthRepositoryImpl target = HealthRepositoryImpl(mockHealthFactory, logger);

  setUp(() {
    mockHealthFactory = MockHealthFactory();
    target = HealthRepositoryImpl(mockHealthFactory, logger);
    final map = HealthByPeriod(steps: 1, distance: 1, burnedCalorie: 1).toJson();
    final str = map.toString().replaceAll('{', '{"').replaceAll(':', '":').replaceAll(', ', ', "');
    final decoded = json.decode(str);
    print(str);
    print(map);
    print(decoded);
    final health2 = HealthByPeriod.fromJson(map);
    final health = HealthByPeriod.fromJson(decoded);
    print(health);
    print(health2);
  });

  group('HealthRepositoryImpl', () {
    final targetDate = DateTime(2022, 9, 19, 11, 0);
    final targetToDate = DateTime(2022, 9, 18, 23, 59, 59, 999, 999);
    final yesterday = DateTime(2022, 9, 18);
    final lastWeek = DateTime(2022, 9, 12);
    final lastMonth = DateTime(2022, 8, 19);
    final types = [
      HealthDataType.STEPS,
      HealthDataType.DISTANCE_DELTA,
      HealthDataType.ACTIVE_ENERGY_BURNED,
    ];
    setUp(() {
      when(mockHealthFactory.requestAuthorization(any)).thenAnswer((_) => Future.value(true));

      /// 1日単位
      when(mockHealthFactory.getHealthDataFromTypes(yesterday, targetToDate, types))
          .thenAnswer((_) => Future.value(defaultHealthDataPoint()));

      /// 1週間単位
      when(mockHealthFactory.getHealthDataFromTypes(lastWeek, targetToDate, types)).thenAnswer(
        (_) => Future.value([
          ...defaultHealthDataPoint(),
              // @formatter:off
          HealthDataPoint(NumericHealthValue(10000), HealthDataType.ACTIVE_ENERGY_BURNED, HealthDataUnit.KILOCALORIE, DateTime(2022, 9, 12), DateTime(2022, 9, 18), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
          HealthDataPoint(NumericHealthValue(10000), HealthDataType.STEPS, HealthDataUnit.COUNT, DateTime(2022, 9, 12), DateTime(2022, 9, 18), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
          HealthDataPoint(NumericHealthValue(10000), HealthDataType.DISTANCE_DELTA, HealthDataUnit.METER, DateTime(2022, 9, 12), DateTime(2022, 9, 18), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
          // @formatter:on
        ]),
      );

      /// 1ヶ月単位
      when(mockHealthFactory.getHealthDataFromTypes(lastMonth, targetToDate, types)).thenAnswer(
        (_) => Future.value([
          ...defaultHealthDataPoint(),
              // @formatter:off
          HealthDataPoint(NumericHealthValue(100000), HealthDataType.ACTIVE_ENERGY_BURNED, HealthDataUnit.KILOCALORIE, DateTime(2022, 8, 19), DateTime(2022, 9, 18), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
          HealthDataPoint(NumericHealthValue(100000), HealthDataType.STEPS, HealthDataUnit.COUNT, DateTime(2022, 8, 19), DateTime(2022, 9, 18), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
          HealthDataPoint(NumericHealthValue(100000), HealthDataType.DISTANCE_DELTA, HealthDataUnit.METER, DateTime(2022, 8, 19), DateTime(2022, 9, 18), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
          // @formatter:on
        ]),
      );
    });
    group('正常系', () {
      CustomizableDateTime.customTime = DateTime(2022, 9, 19, 11, 0);
      test('ヘルスケア情報を取得できる', () async {
        // given
        final createdAt = DateTime(2022, 4, 1);
        final expected = HealthInfo(
          yesterday: const HealthByPeriod(steps: 5427, distance: 4679, burnedCalorie: 1468),
          week: const HealthByPeriod(steps: 15427, distance: 14679, burnedCalorie: 11468),
          month: const HealthByPeriod(steps: 105427, distance: 104679, burnedCalorie: 101468),
          updatedAt: CustomizableDateTime.current,
          totalSteps: 1005427,
          totalDistance: 1004679,
        );

        /// total単位
        when(mockHealthFactory.getHealthDataFromTypes(createdAt, targetToDate, types)).thenAnswer(
          (_) => Future.value([
            ...defaultHealthDataPoint(),
                // @formatter:off
            HealthDataPoint(NumericHealthValue(1000000), HealthDataType.ACTIVE_ENERGY_BURNED, HealthDataUnit.KILOCALORIE, DateTime(2022), DateTime(2022, 9, 18), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
            HealthDataPoint(NumericHealthValue(1000000), HealthDataType.STEPS, HealthDataUnit.COUNT, DateTime(2022), DateTime(2022, 9, 18), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
            HealthDataPoint(NumericHealthValue(1000000), HealthDataType.DISTANCE_DELTA, HealthDataUnit.METER, DateTime(2022), DateTime(2022, 9, 18), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
            // @formatter:on
          ]),
        );

        // when
        final actual = await target.getHealthInfo(targetDateTime: targetDate, createdAt: createdAt);

        // then
        expect(actual, expected);
        verify(mockHealthFactory.requestAuthorization(any)).called(1);
        for (final from in [yesterday, lastWeek, lastMonth, createdAt]) {
          verify(
            mockHealthFactory.getHealthDataFromTypes(from, targetToDate, types),
          ).called(1);
        }
      });

      test('ヘルスケア情報を取得できる(ユーザ登録から3日しか経過していない)', () async {
        // given
        final createdAt = targetDate.subtract(const Duration(days: 3));
        final expected = HealthInfo(
          yesterday: const HealthByPeriod(steps: 5427, distance: 4679, burnedCalorie: 1468),
          week: const HealthByPeriod(steps: 35427, distance: 34679, burnedCalorie: 31468),
          month: const HealthByPeriod(steps: 35427, distance: 34679, burnedCalorie: 31468),
          updatedAt: CustomizableDateTime.current,
          totalSteps: 35427,
          totalDistance: 34679,
        );
        // 1週間, 1ヶ月, total単位
        when(mockHealthFactory.getHealthDataFromTypes(createdAt, targetToDate, types)).thenAnswer(
          (_) => Future.value([
            ...defaultHealthDataPoint(),
                // @formatter:off
            HealthDataPoint(NumericHealthValue(30000), HealthDataType.ACTIVE_ENERGY_BURNED, HealthDataUnit.KILOCALORIE, createdAt, DateTime(2022, 9, 18), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
            HealthDataPoint(NumericHealthValue(30000), HealthDataType.STEPS, HealthDataUnit.COUNT, createdAt, DateTime(2022, 9, 18), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
            HealthDataPoint(NumericHealthValue(30000), HealthDataType.DISTANCE_DELTA, HealthDataUnit.METER, createdAt, DateTime(2022, 9, 18), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
            // @formatter:on
          ]),
        );

        // when
        final actual = await target.getHealthInfo(targetDateTime: targetDate, createdAt: createdAt);

        // then
        expect(actual, expected);
        verify(mockHealthFactory.requestAuthorization(any)).called(1);
        verify(mockHealthFactory.getHealthDataFromTypes(yesterday, targetToDate, types)).called(1);
        // createdAt の参照は3回呼ばれる
        verify(mockHealthFactory.getHealthDataFromTypes(createdAt, targetToDate, types)).called(3);
      });
    });
  });
}

List<HealthDataPoint> defaultHealthDataPoint() {
  return [
    // 実データを元にテストデータを作成している
    // 1行が長いため、readability のため、Android Studio などで補完されないように @formatter:off を付与
    // @formatter:off
    HealthDataPoint(NumericHealthValue(1305.7261962890625), HealthDataType.ACTIVE_ENERGY_BURNED, HealthDataUnit.KILOCALORIE, DateTime(2022, 9, 18), DateTime(2022, 9, 18, 21, 40, 31, 986), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(13.775235176086426), HealthDataType.ACTIVE_ENERGY_BURNED, HealthDataUnit.KILOCALORIE, DateTime(2022, 9, 18, 21, 40, 31, 986), DateTime(2022, 9, 18, 21, 44, 16, 990), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(3.1692113876342773), HealthDataType.ACTIVE_ENERGY_BURNED, HealthDataUnit.KILOCALORIE, DateTime(2022, 9, 18, 21, 44, 16, 990), DateTime(2022, 9, 18, 21, 47, 31, 986), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(14.213860511779785), HealthDataType.ACTIVE_ENERGY_BURNED, HealthDataUnit.KILOCALORIE, DateTime(2022, 9, 18, 21, 47, 31, 986), DateTime(2022, 9, 18, 21, 49, 31, 986), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(1.1071913242340088), HealthDataType.ACTIVE_ENERGY_BURNED, HealthDataUnit.KILOCALORIE, DateTime(2022, 9, 18, 21, 49, 31, 986), DateTime(2022, 9, 18, 21, 50, 31, 986), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(106.05174255371094), HealthDataType.ACTIVE_ENERGY_BURNED, HealthDataUnit.KILOCALORIE, DateTime(2022, 9, 18, 21, 50, 31, 986), DateTime(2022, 9, 18, 23, 36, 7, 983), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(22.61113929748535), HealthDataType.ACTIVE_ENERGY_BURNED, HealthDataUnit.KILOCALORIE, DateTime(2022, 9, 18, 23, 36, 7, 983), DateTime(2022, 9, 18, 23, 58, 39, 256), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(1.330716609954834), HealthDataType.ACTIVE_ENERGY_BURNED, HealthDataUnit.KILOCALORIE, DateTime(2022, 9, 18, 23, 58, 39, 256), DateTime(2022, 9, 18, 23, 59, 59, 99), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(4), HealthDataType.STEPS, HealthDataUnit.COUNT, DateTime(2022, 9, 18, 7, 10), DateTime(2022, 9, 18, 7, 10, 58), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(23), HealthDataType.STEPS, HealthDataUnit.COUNT, DateTime(2022, 9, 18, 8, 29), DateTime(2022, 9, 18, 8, 37, 58), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(300), HealthDataType.STEPS, HealthDataUnit.COUNT, DateTime(2022, 9, 18, 8, 37, 58), DateTime(2022, 9, 18, 8, 41), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(1400), HealthDataType.STEPS, HealthDataUnit.COUNT, DateTime(2022, 9, 18, 8, 41), DateTime(2022, 9, 18, 10), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(3300), HealthDataType.STEPS, HealthDataUnit.COUNT, DateTime(2022, 9, 18, 10), DateTime(2022, 9, 18, 10, 30), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(400), HealthDataType.STEPS, HealthDataUnit.COUNT, DateTime(2022, 9, 18, 23), DateTime(2022, 9, 18, 23, 30), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(2.7836718559265137), HealthDataType.DISTANCE_DELTA, HealthDataUnit.METER, DateTime(2022, 9, 18, 7, 10), DateTime(2022, 9, 18, 7, 10, 58), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(16.597394943237305), HealthDataType.DISTANCE_DELTA, HealthDataUnit.METER, DateTime(2022, 9, 18, 8, 29), DateTime(2022, 9, 18, 8, 37, 58), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(278.25809478759766), HealthDataType.DISTANCE_DELTA, HealthDataUnit.METER, DateTime(2022, 9, 18, 8, 37, 58), DateTime(2022, 9, 18, 8, 41), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(1000.1), HealthDataType.DISTANCE_DELTA, HealthDataUnit.METER, DateTime(2022, 9, 18, 8, 41), DateTime(2022, 9, 18, 10), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(3000.555), HealthDataType.DISTANCE_DELTA, HealthDataUnit.METER, DateTime(2022, 9, 18, 10), DateTime(2022, 9, 18, 10, 30), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(380.11), HealthDataType.DISTANCE_DELTA, HealthDataUnit.METER, DateTime(2022, 9, 18, 23), DateTime(2022, 9, 18, 23, 30), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
    // @formatter:on
  ];
}
