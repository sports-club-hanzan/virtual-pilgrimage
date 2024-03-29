// ignore_for_file: type=lint

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:health/health.dart';
import 'package:logger/logger.dart';
import 'package:mockito/mockito.dart';
import 'package:virtualpilgrimage/application/health/health_gateway.dart';
import 'package:virtualpilgrimage/domain/health/health_aggregation_result.codegen.dart';
import 'package:virtualpilgrimage/domain/user/health/health_by_period.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/user/flutter_health_gateway.dart';

import '../../helper/mock.mocks.dart';
import '../../helper/provider_container.dart';

const defaultDeviceId = 'dummyDeviceId';
const defaultSourceId = 'dummySourceId';
const defaultSourceName = 'dummySourceName';

void main() {
  MockHealthFactory mockHealthFactory = MockHealthFactory();
  MockFirebaseCrashlytics mockFirebaseCrashlytics = MockFirebaseCrashlytics();
  final logger = Logger(level: Level.nothing);
  FlutterHealthGateway target =
      FlutterHealthGateway(mockHealthFactory, logger, mockFirebaseCrashlytics);

  setUp(() {
    mockHealthFactory = MockHealthFactory();
    target = FlutterHealthGateway(mockHealthFactory, logger, mockFirebaseCrashlytics);
  });

  group('HealthRepositoryImpl', () {
    final targetDateTime = DateTime(2022, 9, 19, 11, 0);
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
      // android 端末を想定
      debugDefaultTargetPlatformOverride = TargetPlatform.android;

      when(mockHealthFactory.hasPermissions(any, permissions: anyNamed('permissions')))
          .thenAnswer((_) => Future.value(false));
      when(mockHealthFactory.requestAuthorization(any, permissions: anyNamed('permissions')))
          .thenAnswer((_) => Future.value(true));

      /// 今日
      /// 今日の集計だけ対象時間からではなく、当日の00:00:00-現在時刻まで集計
      when(
        mockHealthFactory.getHealthDataFromTypes(
          DateTime(2022, 9, 19),
          targetDateTime,
          types,
        ),
      ).thenAnswer(
        (_) => Future.value([
              // @formatter:off
          HealthDataPoint(NumericHealthValue(468), HealthDataType.ACTIVE_ENERGY_BURNED, HealthDataUnit.KILOCALORIE, DateTime(2022, 9, 12), DateTime(2022, 9, 18), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
          HealthDataPoint(NumericHealthValue(427), HealthDataType.STEPS, HealthDataUnit.COUNT, DateTime(2022, 9, 12), DateTime(2022, 9, 18), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
          HealthDataPoint(NumericHealthValue(670), HealthDataType.DISTANCE_DELTA, HealthDataUnit.METER, DateTime(2022, 9, 12), DateTime(2022, 9, 18), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
          // @formatter:on
        ]),
      );

      /// 昨日
      when(mockHealthFactory.getHealthDataFromTypes(yesterday, targetToDate, types))
          .thenAnswer((_) => Future.value([
                ...defaultHealthDataPoint(),
                // 同一時間帯に別のsourceIdでデータが登録されている
                HealthDataPoint(
                    NumericHealthValue(6000),
                    HealthDataType.STEPS,
                    HealthDataUnit.COUNT,
                    DateTime(2022, 9, 18),
                    DateTime(2022, 9, 18, 21, 40, 31, 986),
                    PlatformType.ANDROID,
                    defaultDeviceId,
                    'source',
                    defaultSourceName),
              ]));

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

    test('DI', () {
      final container = mockedProviderContainer();
      final repository = container.read(healthGatewayProvider);
      expect(repository, isNotNull);
    });

    group('aggregateHealthByPeriod', () {
      test('正常系', () async {
        // given
        /// 今日
        when(
          mockHealthFactory.getHealthDataFromTypes(
            DateTime(2022, 9, 18, 11, 0, 0, 0, 0),
            DateTime(2022, 9, 18, 23, 59, 59, 999, 999),
            types,
          ),
        ).thenAnswer(
          (_) => Future.value([
                // @formatter:off
            HealthDataPoint(NumericHealthValue(468), HealthDataType.ACTIVE_ENERGY_BURNED, HealthDataUnit.KILOCALORIE, DateTime(2022, 9, 18), DateTime(2022, 9, 18), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
            HealthDataPoint(NumericHealthValue(427), HealthDataType.STEPS, HealthDataUnit.COUNT, DateTime(2022, 9, 18), DateTime(2022, 9, 18), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
            HealthDataPoint(NumericHealthValue(670), HealthDataType.DISTANCE_DELTA, HealthDataUnit.METER, DateTime(2022, 9, 18), DateTime(2022, 9, 18), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
            // @formatter:on
          ]),
        );
        when(mockHealthFactory.getHealthDataFromTypes(
                DateTime(2022, 9, 19), DateTime(2022, 9, 19, 23, 59, 59, 999, 999), types))
            .thenAnswer((realInvocation) => Future.value([
              // @formatter:off
          HealthDataPoint(NumericHealthValue(1000), HealthDataType.ACTIVE_ENERGY_BURNED, HealthDataUnit.KILOCALORIE, DateTime(2022, 9, 19), DateTime(2022, 9, 20), PlatformType.ANDROID, defaultDeviceId, defaultSourceId + "_dummy", defaultSourceName),
          HealthDataPoint(NumericHealthValue(1000), HealthDataType.STEPS, HealthDataUnit.COUNT, DateTime(2022, 9, 19), DateTime(2022, 9, 20), PlatformType.ANDROID, defaultDeviceId, defaultSourceId + "_dummy", defaultSourceName),
          HealthDataPoint(NumericHealthValue(1000), HealthDataType.DISTANCE_DELTA, HealthDataUnit.METER, DateTime(2022, 9, 19), DateTime(2022, 9, 20), PlatformType.ANDROID, defaultDeviceId, defaultSourceId + "_dummy", defaultSourceName),
          HealthDataPoint(NumericHealthValue(2000), HealthDataType.ACTIVE_ENERGY_BURNED, HealthDataUnit.KILOCALORIE, DateTime(2022, 9, 19), DateTime(2022, 9, 20), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
          HealthDataPoint(NumericHealthValue(2000), HealthDataType.STEPS, HealthDataUnit.COUNT, DateTime(2022, 9, 19), DateTime(2022, 9, 20), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
          HealthDataPoint(NumericHealthValue(2000), HealthDataType.DISTANCE_DELTA, HealthDataUnit.METER, DateTime(2022, 9, 19), DateTime(2022, 9, 20), PlatformType.ANDROID, defaultDeviceId, defaultSourceId, defaultSourceName),
                  // @formatter:on
                ]));

        // when
        final actual = await target.aggregateHealthByPeriod(
          from: DateTime(2022, 9, 18, 11),
          to: DateTime(2022, 9, 19, 23, 59, 59, 999, 999),
        );

        // then
        final expected = HealthAggregationResult(
          eachDay: {
            DateTime(2022, 9, 18): HealthByPeriod(steps: 427, distance: 670, burnedCalorie: 468),
            DateTime(2022, 9, 19): HealthByPeriod(steps: 2000, distance: 2000, burnedCalorie: 2000),
          },
          total: HealthByPeriod(steps: 2427, distance: 2670, burnedCalorie: 2468),
        );
        expect(actual, expected);
        verify(mockHealthFactory.requestAuthorization(any, permissions: anyNamed('permissions')))
            .called(1);
      });
    });
  });
}

List<HealthDataPoint> defaultHealthDataPoint() {
  final distanceType =
      Platform.isIOS ? HealthDataType.DISTANCE_WALKING_RUNNING : HealthDataType.DISTANCE_DELTA;
  final platformType = Platform.isIOS ? PlatformType.IOS : PlatformType.ANDROID;
  // @formatter:off
  return [
    // 実データを元にテストデータを作成している
    // 1行が長いため、readability のため、Android Studio などで補完されないように @formatter:off を付与
    HealthDataPoint(NumericHealthValue(1305.7261962890625), HealthDataType.ACTIVE_ENERGY_BURNED, HealthDataUnit.KILOCALORIE, DateTime(2022, 9, 18), DateTime(2022, 9, 18, 21, 40, 31, 986), platformType, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(13.775235176086426), HealthDataType.ACTIVE_ENERGY_BURNED, HealthDataUnit.KILOCALORIE, DateTime(2022, 9, 18, 21, 40, 31, 986), DateTime(2022, 9, 18, 21, 44, 16, 990), platformType, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(3.1692113876342773), HealthDataType.ACTIVE_ENERGY_BURNED, HealthDataUnit.KILOCALORIE, DateTime(2022, 9, 18, 21, 44, 16, 990), DateTime(2022, 9, 18, 21, 47, 31, 986), platformType, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(14.213860511779785), HealthDataType.ACTIVE_ENERGY_BURNED, HealthDataUnit.KILOCALORIE, DateTime(2022, 9, 18, 21, 47, 31, 986), DateTime(2022, 9, 18, 21, 49, 31, 986), platformType, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(1.1071913242340088), HealthDataType.ACTIVE_ENERGY_BURNED, HealthDataUnit.KILOCALORIE, DateTime(2022, 9, 18, 21, 49, 31, 986), DateTime(2022, 9, 18, 21, 50, 31, 986), platformType, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(106.05174255371094), HealthDataType.ACTIVE_ENERGY_BURNED, HealthDataUnit.KILOCALORIE, DateTime(2022, 9, 18, 21, 50, 31, 986), DateTime(2022, 9, 18, 23, 36, 7, 983), platformType, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(22.61113929748535), HealthDataType.ACTIVE_ENERGY_BURNED, HealthDataUnit.KILOCALORIE, DateTime(2022, 9, 18, 23, 36, 7, 983), DateTime(2022, 9, 18, 23, 58, 39, 256), platformType, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(1.330716609954834), HealthDataType.ACTIVE_ENERGY_BURNED, HealthDataUnit.KILOCALORIE, DateTime(2022, 9, 18, 23, 58, 39, 256), DateTime(2022, 9, 18, 23, 59, 59, 99), platformType, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(4), HealthDataType.STEPS, HealthDataUnit.COUNT, DateTime(2022, 9, 18, 7, 10), DateTime(2022, 9, 18, 7, 10, 58), platformType, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(23), HealthDataType.STEPS, HealthDataUnit.COUNT, DateTime(2022, 9, 18, 8, 29), DateTime(2022, 9, 18, 8, 37, 58), platformType, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(300), HealthDataType.STEPS, HealthDataUnit.COUNT, DateTime(2022, 9, 18, 8, 37, 58), DateTime(2022, 9, 18, 8, 41), platformType, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(1400), HealthDataType.STEPS, HealthDataUnit.COUNT, DateTime(2022, 9, 18, 8, 41), DateTime(2022, 9, 18, 10), platformType, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(3300), HealthDataType.STEPS, HealthDataUnit.COUNT, DateTime(2022, 9, 18, 10), DateTime(2022, 9, 18, 10, 30), platformType, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(400), HealthDataType.STEPS, HealthDataUnit.COUNT, DateTime(2022, 9, 18, 23), DateTime(2022, 9, 18, 23, 30), platformType, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(2.7836718559265137), distanceType, HealthDataUnit.METER, DateTime(2022, 9, 18, 7, 10), DateTime(2022, 9, 18, 7, 10, 58), platformType, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(16.597394943237305), distanceType, HealthDataUnit.METER, DateTime(2022, 9, 18, 8, 29), DateTime(2022, 9, 18, 8, 37, 58), platformType, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(278.25809478759766), distanceType, HealthDataUnit.METER, DateTime(2022, 9, 18, 8, 37, 58), DateTime(2022, 9, 18, 8, 41), platformType, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(1000.1), distanceType, HealthDataUnit.METER, DateTime(2022, 9, 18, 8, 41), DateTime(2022, 9, 18, 10), platformType, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(3000.555), distanceType, HealthDataUnit.METER, DateTime(2022, 9, 18, 10), DateTime(2022, 9, 18, 10, 30), platformType, defaultDeviceId, defaultSourceId, defaultSourceName),
    HealthDataPoint(NumericHealthValue(380.11), distanceType, HealthDataUnit.METER, DateTime(2022, 9, 18, 23), DateTime(2022, 9, 18, 23, 30), platformType, defaultDeviceId, defaultSourceId, defaultSourceName),
  ];
  // @formatter:on
}
