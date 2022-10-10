import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:health/health.dart';
import 'package:logger/logger.dart';
import 'package:mockito/mockito.dart';
import 'package:virtualpilgrimage/domain/customizable_date_time.dart';
import 'package:virtualpilgrimage/domain/user/health/health_by_period.codegen.dart';
import 'package:virtualpilgrimage/domain/user/health/health_info.codegen.dart';
import 'package:virtualpilgrimage/domain/user/health/health_repository.dart';
import 'package:virtualpilgrimage/infrastructure/user/health_repository_impl.dart';

import '../../helper/mock.mocks.dart';
import '../../helper/provider_container.dart';

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
      // android 端末を想定
      debugDefaultTargetPlatformOverride = TargetPlatform.android;

      when(mockHealthFactory.requestAuthorization(any)).thenAnswer((_) => Future.value(true));

      /// 今日
      when(
        mockHealthFactory.getHealthDataFromTypes(
          targetDate,
          targetToDate.add(const Duration(days: 1)),
          types,
        ),
      ).thenAnswer(
        (_) => Future.value([
          // @formatter:off
          HealthDataPoint(
              NumericHealthValue(468),
              HealthDataType.ACTIVE_ENERGY_BURNED,
              HealthDataUnit.KILOCALORIE,
              DateTime(2022, 9, 12),
              DateTime(2022, 9, 18),
              PlatformType.ANDROID,
              defaultDeviceId,
              defaultSourceId,
              defaultSourceName),
          HealthDataPoint(
              NumericHealthValue(427),
              HealthDataType.STEPS,
              HealthDataUnit.COUNT,
              DateTime(2022, 9, 12),
              DateTime(2022, 9, 18),
              PlatformType.ANDROID,
              defaultDeviceId,
              defaultSourceId,
              defaultSourceName),
          HealthDataPoint(
              NumericHealthValue(670),
              HealthDataType.DISTANCE_DELTA,
              HealthDataUnit.METER,
              DateTime(2022, 9, 12),
              DateTime(2022, 9, 18),
              PlatformType.ANDROID,
              defaultDeviceId,
              defaultSourceId,
              defaultSourceName),
          // @formatter:on
        ]),
      );

      /// 昨日
      when(mockHealthFactory.getHealthDataFromTypes(yesterday, targetToDate, types))
          .thenAnswer((_) => Future.value(defaultHealthDataPoint()));

      /// 1週間単位
      when(mockHealthFactory.getHealthDataFromTypes(lastWeek, targetToDate, types)).thenAnswer(
        (_) => Future.value([
          ...defaultHealthDataPoint(),
          // @formatter:off
          HealthDataPoint(
              NumericHealthValue(10000),
              HealthDataType.ACTIVE_ENERGY_BURNED,
              HealthDataUnit.KILOCALORIE,
              DateTime(2022, 9, 12),
              DateTime(2022, 9, 18),
              PlatformType.ANDROID,
              defaultDeviceId,
              defaultSourceId,
              defaultSourceName),
          HealthDataPoint(
              NumericHealthValue(10000),
              HealthDataType.STEPS,
              HealthDataUnit.COUNT,
              DateTime(2022, 9, 12),
              DateTime(2022, 9, 18),
              PlatformType.ANDROID,
              defaultDeviceId,
              defaultSourceId,
              defaultSourceName),
          HealthDataPoint(
              NumericHealthValue(10000),
              HealthDataType.DISTANCE_DELTA,
              HealthDataUnit.METER,
              DateTime(2022, 9, 12),
              DateTime(2022, 9, 18),
              PlatformType.ANDROID,
              defaultDeviceId,
              defaultSourceId,
              defaultSourceName),
          // @formatter:on
        ]),
      );

      /// 1ヶ月単位
      when(mockHealthFactory.getHealthDataFromTypes(lastMonth, targetToDate, types)).thenAnswer(
        (_) => Future.value([
          ...defaultHealthDataPoint(),
          // @formatter:off
          HealthDataPoint(
              NumericHealthValue(100000),
              HealthDataType.ACTIVE_ENERGY_BURNED,
              HealthDataUnit.KILOCALORIE,
              DateTime(2022, 8, 19),
              DateTime(2022, 9, 18),
              PlatformType.ANDROID,
              defaultDeviceId,
              defaultSourceId,
              defaultSourceName),
          HealthDataPoint(
              NumericHealthValue(100000),
              HealthDataType.STEPS,
              HealthDataUnit.COUNT,
              DateTime(2022, 8, 19),
              DateTime(2022, 9, 18),
              PlatformType.ANDROID,
              defaultDeviceId,
              defaultSourceId,
              defaultSourceName),
          HealthDataPoint(
              NumericHealthValue(100000),
              HealthDataType.DISTANCE_DELTA,
              HealthDataUnit.METER,
              DateTime(2022, 8, 19),
              DateTime(2022, 9, 18),
              PlatformType.ANDROID,
              defaultDeviceId,
              defaultSourceId,
              defaultSourceName),
          // @formatter:on
        ]),
      );
    });

    test('DI', () {
      final container = mockedProviderContainer();
      final repository = container.read(healthRepositoryProvider);
      expect(repository, isNotNull);
    });

    group('getHealthInfo', () {
      group('正常系', () {
        CustomizableDateTime.customTime = DateTime(2022, 9, 19, 11, 0);
        test('ヘルスケア情報を取得できる', () async {
          // given
          final createdAt = DateTime(2022, 4, 1);
          final expected = HealthInfo(
            today: const HealthByPeriod(steps: 427, distance: 670, burnedCalorie: 468),
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
              HealthDataPoint(
                  NumericHealthValue(1000000),
                  HealthDataType.ACTIVE_ENERGY_BURNED,
                  HealthDataUnit.KILOCALORIE,
                  DateTime(2022),
                  DateTime(2022, 9, 18),
                  PlatformType.ANDROID,
                  defaultDeviceId,
                  defaultSourceId,
                  defaultSourceName),
              HealthDataPoint(
                  NumericHealthValue(1000000),
                  HealthDataType.STEPS,
                  HealthDataUnit.COUNT,
                  DateTime(2022),
                  DateTime(2022, 9, 18),
                  PlatformType.ANDROID,
                  defaultDeviceId,
                  defaultSourceId,
                  defaultSourceName),
              HealthDataPoint(
                  NumericHealthValue(1000000),
                  HealthDataType.DISTANCE_DELTA,
                  HealthDataUnit.METER,
                  DateTime(2022),
                  DateTime(2022, 9, 18),
                  PlatformType.ANDROID,
                  defaultDeviceId,
                  defaultSourceId,
                  defaultSourceName),
              // @formatter:on
            ]),
          );

          // when
          final actual =
              await target.getHealthInfo(targetDateTime: targetDate, createdAt: createdAt);

          // then
          expect(actual, expected);
          verify(mockHealthFactory.requestAuthorization(any)).called(1);
          for (final from in [yesterday, lastWeek, lastMonth, createdAt]) {
            verify(
              mockHealthFactory.getHealthDataFromTypes(from, targetToDate, types),
            ).called(1);
          }
        });

        test('ヘルスケア情報を取得できる(ユーザ登録から24時間経過していない)', () async {
          // given
          final createdAt = targetDate.subtract(const Duration(hours: 12));
          final expected = HealthInfo(
            today: const HealthByPeriod(steps: 427, distance: 670, burnedCalorie: 468),
            yesterday: const HealthByPeriod(steps: 5427, distance: 4679, burnedCalorie: 1468),
            week: const HealthByPeriod(steps: 0, distance: 0, burnedCalorie: 0),
            month: const HealthByPeriod(steps: 0, distance: 0, burnedCalorie: 0),
            updatedAt: CustomizableDateTime.current,
            totalSteps: 0,
            totalDistance: 0,
          );

          // when
          final actual =
              await target.getHealthInfo(targetDateTime: targetDate, createdAt: createdAt);

          // then
          expect(actual, expected);
          verify(mockHealthFactory.requestAuthorization(any)).called(1);
          verify(mockHealthFactory.getHealthDataFromTypes(yesterday, targetToDate, types))
              .called(1);
          // createdAt の参照は3回呼ばれる
          verifyNever(mockHealthFactory.getHealthDataFromTypes(createdAt, targetToDate, types))
              .called(0);
        });

        test('ヘルスケア情報を取得できる(iOS)', () async {
          // given
          // iOS 端末を想定
          debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
          final iosTypes = [
            HealthDataType.STEPS,
            HealthDataType.DISTANCE_WALKING_RUNNING,
            HealthDataType.ACTIVE_ENERGY_BURNED,
          ];
          final createdAt = DateTime(2022, 4, 1);
          final expected = HealthInfo(
            today: const HealthByPeriod(steps: 427, distance: 670, burnedCalorie: 468),
            yesterday: const HealthByPeriod(steps: 5427, distance: 4679, burnedCalorie: 1468),
            week: const HealthByPeriod(steps: 15427, distance: 14679, burnedCalorie: 11468),
            month: const HealthByPeriod(steps: 105427, distance: 104679, burnedCalorie: 101468),
            updatedAt: CustomizableDateTime.current,
            totalSteps: 1005427,
            totalDistance: 1004679,
          );

          /// 今日
          when(
            mockHealthFactory.getHealthDataFromTypes(
              targetDate,
              targetToDate.add(const Duration(days: 1)),
              iosTypes,
            ),
          ).thenAnswer(
            (_) => Future.value([
              // @formatter:off
              HealthDataPoint(
                  NumericHealthValue(468),
                  HealthDataType.ACTIVE_ENERGY_BURNED,
                  HealthDataUnit.KILOCALORIE,
                  DateTime(2022, 9, 12),
                  DateTime(2022, 9, 18),
                  PlatformType.ANDROID,
                  defaultDeviceId,
                  defaultSourceId,
                  defaultSourceName),
              HealthDataPoint(
                  NumericHealthValue(427),
                  HealthDataType.STEPS,
                  HealthDataUnit.COUNT,
                  DateTime(2022, 9, 12),
                  DateTime(2022, 9, 18),
                  PlatformType.ANDROID,
                  defaultDeviceId,
                  defaultSourceId,
                  defaultSourceName),
              HealthDataPoint(
                  NumericHealthValue(670),
                  HealthDataType.DISTANCE_DELTA,
                  HealthDataUnit.METER,
                  DateTime(2022, 9, 12),
                  DateTime(2022, 9, 18),
                  PlatformType.ANDROID,
                  defaultDeviceId,
                  defaultSourceId,
                  defaultSourceName),
              // @formatter:on
            ]),
          );

          /// 昨日
          when(mockHealthFactory.getHealthDataFromTypes(yesterday, targetToDate, iosTypes))
              .thenAnswer((_) => Future.value(defaultHealthDataPoint()));

          /// 1週間単位
          when(mockHealthFactory.getHealthDataFromTypes(lastWeek, targetToDate, iosTypes))
              .thenAnswer(
            (_) => Future.value([
              ...defaultHealthDataPoint(),
              // @formatter:off
              HealthDataPoint(
                  NumericHealthValue(10000),
                  HealthDataType.ACTIVE_ENERGY_BURNED,
                  HealthDataUnit.KILOCALORIE,
                  DateTime(2022, 9, 12),
                  DateTime(2022, 9, 18),
                  PlatformType.IOS,
                  defaultDeviceId,
                  defaultSourceId,
                  defaultSourceName),
              HealthDataPoint(
                  NumericHealthValue(10000),
                  HealthDataType.STEPS,
                  HealthDataUnit.COUNT,
                  DateTime(2022, 9, 12),
                  DateTime(2022, 9, 18),
                  PlatformType.IOS,
                  defaultDeviceId,
                  defaultSourceId,
                  defaultSourceName),
              HealthDataPoint(
                  NumericHealthValue(10000),
                  HealthDataType.DISTANCE_WALKING_RUNNING,
                  HealthDataUnit.METER,
                  DateTime(2022, 9, 12),
                  DateTime(2022, 9, 18),
                  PlatformType.IOS,
                  defaultDeviceId,
                  defaultSourceId,
                  defaultSourceName),
              // @formatter:on
            ]),
          );

          /// 1ヶ月単位
          when(mockHealthFactory.getHealthDataFromTypes(lastMonth, targetToDate, iosTypes))
              .thenAnswer(
            (_) => Future.value([
              ...defaultHealthDataPoint(),
              // @formatter:off
              HealthDataPoint(
                  NumericHealthValue(100000),
                  HealthDataType.ACTIVE_ENERGY_BURNED,
                  HealthDataUnit.KILOCALORIE,
                  DateTime(2022, 8, 19),
                  DateTime(2022, 9, 18),
                  PlatformType.IOS,
                  defaultDeviceId,
                  defaultSourceId,
                  defaultSourceName),
              HealthDataPoint(
                  NumericHealthValue(100000),
                  HealthDataType.STEPS,
                  HealthDataUnit.COUNT,
                  DateTime(2022, 8, 19),
                  DateTime(2022, 9, 18),
                  PlatformType.IOS,
                  defaultDeviceId,
                  defaultSourceId,
                  defaultSourceName),
              HealthDataPoint(
                  NumericHealthValue(100000),
                  HealthDataType.DISTANCE_WALKING_RUNNING,
                  HealthDataUnit.METER,
                  DateTime(2022, 8, 19),
                  DateTime(2022, 9, 18),
                  PlatformType.IOS,
                  defaultDeviceId,
                  defaultSourceId,
                  defaultSourceName),
              // @formatter:on
            ]),
          );

          /// total単位
          when(mockHealthFactory.getHealthDataFromTypes(createdAt, targetToDate, iosTypes))
              .thenAnswer(
            (_) => Future.value([
              ...defaultHealthDataPoint(),
              // @formatter:off
              HealthDataPoint(
                  NumericHealthValue(1000000),
                  HealthDataType.ACTIVE_ENERGY_BURNED,
                  HealthDataUnit.KILOCALORIE,
                  DateTime(2022),
                  DateTime(2022, 9, 18),
                  PlatformType.IOS,
                  defaultDeviceId,
                  defaultSourceId,
                  defaultSourceName),
              HealthDataPoint(
                  NumericHealthValue(1000000),
                  HealthDataType.STEPS,
                  HealthDataUnit.COUNT,
                  DateTime(2022),
                  DateTime(2022, 9, 18),
                  PlatformType.IOS,
                  defaultDeviceId,
                  defaultSourceId,
                  defaultSourceName),
              HealthDataPoint(
                  NumericHealthValue(1000000),
                  HealthDataType.DISTANCE_WALKING_RUNNING,
                  HealthDataUnit.METER,
                  DateTime(2022),
                  DateTime(2022, 9, 18),
                  PlatformType.IOS,
                  defaultDeviceId,
                  defaultSourceId,
                  defaultSourceName),
              // @formatter:on
            ]),
          );

          // when
          final actual =
              await target.getHealthInfo(targetDateTime: targetDate, createdAt: createdAt);

          // then
          expect(actual, expected);
          verify(mockHealthFactory.requestAuthorization(any)).called(1);
          for (final from in [yesterday, lastWeek, lastMonth, createdAt]) {
            verify(
              mockHealthFactory.getHealthDataFromTypes(from, targetToDate, iosTypes),
            ).called(1);
          }
        });
      });
    });

    group('getHealthInfo', () {
      test('正常系', () async {
        // given
        const expected = HealthByPeriod(steps: 427, distance: 670, burnedCalorie: 468);

        // when
        final actual = await target.getHealthByPeriod(
          from: targetDate,
          to: targetToDate.add(const Duration(days: 1)),
        );

        // then
        expect(actual, expected);
        verify(mockHealthFactory.requestAuthorization(any)).called(1);
        verify(
          mockHealthFactory.getHealthDataFromTypes(
            targetDate,
            targetToDate.add(const Duration(days: 1)),
            types,
          ),
        ).called(1);
      });
    });
  });
}

List<HealthDataPoint> defaultHealthDataPoint() {
  final distanceType =
      Platform.isIOS ? HealthDataType.DISTANCE_WALKING_RUNNING : HealthDataType.DISTANCE_DELTA;
  final platformType = Platform.isIOS ? PlatformType.IOS : PlatformType.ANDROID;
  return [
    // 実データを元にテストデータを作成している
    // 1行が長いため、readability のため、Android Studio などで補完されないように @formatter:off を付与
    // @formatter:off
    HealthDataPoint(
        NumericHealthValue(1305.7261962890625),
        HealthDataType.ACTIVE_ENERGY_BURNED,
        HealthDataUnit.KILOCALORIE,
        DateTime(2022, 9, 18),
        DateTime(2022, 9, 18, 21, 40, 31, 986),
        platformType,
        defaultDeviceId,
        defaultSourceId,
        defaultSourceName),
    HealthDataPoint(
        NumericHealthValue(13.775235176086426),
        HealthDataType.ACTIVE_ENERGY_BURNED,
        HealthDataUnit.KILOCALORIE,
        DateTime(2022, 9, 18, 21, 40, 31, 986),
        DateTime(2022, 9, 18, 21, 44, 16, 990),
        platformType,
        defaultDeviceId,
        defaultSourceId,
        defaultSourceName),
    HealthDataPoint(
        NumericHealthValue(3.1692113876342773),
        HealthDataType.ACTIVE_ENERGY_BURNED,
        HealthDataUnit.KILOCALORIE,
        DateTime(2022, 9, 18, 21, 44, 16, 990),
        DateTime(2022, 9, 18, 21, 47, 31, 986),
        platformType,
        defaultDeviceId,
        defaultSourceId,
        defaultSourceName),
    HealthDataPoint(
        NumericHealthValue(14.213860511779785),
        HealthDataType.ACTIVE_ENERGY_BURNED,
        HealthDataUnit.KILOCALORIE,
        DateTime(2022, 9, 18, 21, 47, 31, 986),
        DateTime(2022, 9, 18, 21, 49, 31, 986),
        platformType,
        defaultDeviceId,
        defaultSourceId,
        defaultSourceName),
    HealthDataPoint(
        NumericHealthValue(1.1071913242340088),
        HealthDataType.ACTIVE_ENERGY_BURNED,
        HealthDataUnit.KILOCALORIE,
        DateTime(2022, 9, 18, 21, 49, 31, 986),
        DateTime(2022, 9, 18, 21, 50, 31, 986),
        platformType,
        defaultDeviceId,
        defaultSourceId,
        defaultSourceName),
    HealthDataPoint(
        NumericHealthValue(106.05174255371094),
        HealthDataType.ACTIVE_ENERGY_BURNED,
        HealthDataUnit.KILOCALORIE,
        DateTime(2022, 9, 18, 21, 50, 31, 986),
        DateTime(2022, 9, 18, 23, 36, 7, 983),
        platformType,
        defaultDeviceId,
        defaultSourceId,
        defaultSourceName),
    HealthDataPoint(
        NumericHealthValue(22.61113929748535),
        HealthDataType.ACTIVE_ENERGY_BURNED,
        HealthDataUnit.KILOCALORIE,
        DateTime(2022, 9, 18, 23, 36, 7, 983),
        DateTime(2022, 9, 18, 23, 58, 39, 256),
        platformType,
        defaultDeviceId,
        defaultSourceId,
        defaultSourceName),
    HealthDataPoint(
        NumericHealthValue(1.330716609954834),
        HealthDataType.ACTIVE_ENERGY_BURNED,
        HealthDataUnit.KILOCALORIE,
        DateTime(2022, 9, 18, 23, 58, 39, 256),
        DateTime(2022, 9, 18, 23, 59, 59, 99),
        platformType,
        defaultDeviceId,
        defaultSourceId,
        defaultSourceName),
    HealthDataPoint(
        NumericHealthValue(4),
        HealthDataType.STEPS,
        HealthDataUnit.COUNT,
        DateTime(2022, 9, 18, 7, 10),
        DateTime(2022, 9, 18, 7, 10, 58),
        platformType,
        defaultDeviceId,
        defaultSourceId,
        defaultSourceName),
    HealthDataPoint(
        NumericHealthValue(23),
        HealthDataType.STEPS,
        HealthDataUnit.COUNT,
        DateTime(2022, 9, 18, 8, 29),
        DateTime(2022, 9, 18, 8, 37, 58),
        platformType,
        defaultDeviceId,
        defaultSourceId,
        defaultSourceName),
    HealthDataPoint(
        NumericHealthValue(300),
        HealthDataType.STEPS,
        HealthDataUnit.COUNT,
        DateTime(2022, 9, 18, 8, 37, 58),
        DateTime(2022, 9, 18, 8, 41),
        platformType,
        defaultDeviceId,
        defaultSourceId,
        defaultSourceName),
    HealthDataPoint(
        NumericHealthValue(1400),
        HealthDataType.STEPS,
        HealthDataUnit.COUNT,
        DateTime(2022, 9, 18, 8, 41),
        DateTime(2022, 9, 18, 10),
        platformType,
        defaultDeviceId,
        defaultSourceId,
        defaultSourceName),
    HealthDataPoint(
        NumericHealthValue(3300),
        HealthDataType.STEPS,
        HealthDataUnit.COUNT,
        DateTime(2022, 9, 18, 10),
        DateTime(2022, 9, 18, 10, 30),
        platformType,
        defaultDeviceId,
        defaultSourceId,
        defaultSourceName),
    HealthDataPoint(
        NumericHealthValue(400),
        HealthDataType.STEPS,
        HealthDataUnit.COUNT,
        DateTime(2022, 9, 18, 23),
        DateTime(2022, 9, 18, 23, 30),
        platformType,
        defaultDeviceId,
        defaultSourceId,
        defaultSourceName),
    HealthDataPoint(
        NumericHealthValue(2.7836718559265137),
        distanceType,
        HealthDataUnit.METER,
        DateTime(2022, 9, 18, 7, 10),
        DateTime(2022, 9, 18, 7, 10, 58),
        platformType,
        defaultDeviceId,
        defaultSourceId,
        defaultSourceName),
    HealthDataPoint(
        NumericHealthValue(16.597394943237305),
        distanceType,
        HealthDataUnit.METER,
        DateTime(2022, 9, 18, 8, 29),
        DateTime(2022, 9, 18, 8, 37, 58),
        platformType,
        defaultDeviceId,
        defaultSourceId,
        defaultSourceName),
    HealthDataPoint(
        NumericHealthValue(278.25809478759766),
        distanceType,
        HealthDataUnit.METER,
        DateTime(2022, 9, 18, 8, 37, 58),
        DateTime(2022, 9, 18, 8, 41),
        platformType,
        defaultDeviceId,
        defaultSourceId,
        defaultSourceName),
    HealthDataPoint(
        NumericHealthValue(1000.1),
        distanceType,
        HealthDataUnit.METER,
        DateTime(2022, 9, 18, 8, 41),
        DateTime(2022, 9, 18, 10),
        platformType,
        defaultDeviceId,
        defaultSourceId,
        defaultSourceName),
    HealthDataPoint(
        NumericHealthValue(3000.555),
        distanceType,
        HealthDataUnit.METER,
        DateTime(2022, 9, 18, 10),
        DateTime(2022, 9, 18, 10, 30),
        platformType,
        defaultDeviceId,
        defaultSourceId,
        defaultSourceName),
    HealthDataPoint(
        NumericHealthValue(380.11),
        distanceType,
        HealthDataUnit.METER,
        DateTime(2022, 9, 18, 23),
        DateTime(2022, 9, 18, 23, 30),
        platformType,
        defaultDeviceId,
        defaultSourceId,
        defaultSourceName),
    // @formatter:on
  ];
}
