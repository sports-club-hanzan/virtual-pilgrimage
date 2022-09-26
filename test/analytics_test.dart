import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mockito/mockito.dart';
import 'package:virtualpilgrimage/analytics.dart';
import 'package:virtualpilgrimage/domain/customizable_date_time.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

import 'helper/mock.mocks.dart';
import 'helper/provider_container.dart';

void main() {
  MockFirebaseAnalytics mockFirebaseAnalytics = MockFirebaseAnalytics();
  final logger = Logger(level: Level.nothing);
  Analytics analytics = Analytics(
    mockFirebaseAnalytics,
    logger,
  );

  setUp(() {
    mockFirebaseAnalytics = MockFirebaseAnalytics();
    analytics = Analytics(
      mockFirebaseAnalytics,
      logger,
    );
  });

  group('Analytics', () {
    test('DI', () {
      final container = mockedProviderContainer();
      final target = container.read(analyticsProvider);
      expect(target, isNotNull);
    });

    group('logEvent', () {
      test('正常系', () async {
        // given
        const eventName = 'dummyEvent';
        final parameters = {'hoge': 'fuga', 'foo': 'bar'};
        when(mockFirebaseAnalytics.logEvent(name: eventName, parameters: parameters))
            .thenAnswer((_) => Future.value());

        // when
        await analytics.logEvent(eventName: eventName, parameters: parameters);

        // then
        verify(mockFirebaseAnalytics.logEvent(name: eventName, parameters: parameters)).called(1);
      });

      test('異常系: eventName が40文字以上', () async {
        // given
        const eventName = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        final parameters = {'hoge': 'fuga', 'foo': 'bar'};
        when(mockFirebaseAnalytics.logEvent(name: eventName, parameters: parameters))
            .thenAnswer((_) => Future.value());

        // when
        await analytics.logEvent(eventName: eventName, parameters: parameters);

        // then
        verifyNever(
          mockFirebaseAnalytics.logEvent(
            name: anyNamed('name'),
            parameters: anyNamed('parameters'),
          ),
        ).called(0);
      });
    });

    group('setCurrentScreen', () {
      test('正常系', () async {
        // given
        const screenName = 'dummyScreen';
        when(mockFirebaseAnalytics.logEvent(name: 'route_screen_$screenName'))
            .thenAnswer((_) => Future.value());
        when(mockFirebaseAnalytics.setCurrentScreen(screenName: screenName))
            .thenAnswer((_) => Future.value());

        // when
        await analytics.setCurrentScreen(screenName: screenName);

        // then
        verify(mockFirebaseAnalytics.logEvent(name: 'route_screen_$screenName')).called(1);
        verify(mockFirebaseAnalytics.setCurrentScreen(screenName: screenName)).called(1);
      });
    });

    group('setUserProperties', () {
      test('正常系', () async {
        // given
        final user = VirtualPilgrimageUser(
          id: 'dummyId',
          nickname: 'dummyName',
          gender: Gender.woman,
          birthDay: DateTime(1990),
          createdAt: CustomizableDateTime.current,
          updatedAt: CustomizableDateTime.current,
        );
        when(
          mockFirebaseAnalytics.setUserProperty(
            name: 'id',
            value: 'dummyId',
          ),
        ).thenAnswer((_) => Future.value());
        when(
          mockFirebaseAnalytics.setUserProperty(
            name: 'nickname',
            value: 'dummyName',
          ),
        ).thenAnswer((_) => Future.value());
        when(
          mockFirebaseAnalytics.setUserProperty(
            name: 'gender',
            value: 'woman',
          ),
        ).thenAnswer((_) => Future.value());

        // when
        await analytics.setUserProperties(user: user);

        // then
        verify(mockFirebaseAnalytics.setUserProperty(name: 'id', value: 'dummyId')).called(1);
        verify(mockFirebaseAnalytics.setUserProperty(name: 'nickname', value: 'dummyName'))
            .called(1);
        verify(mockFirebaseAnalytics.setUserProperty(name: 'gender', value: 'woman')).called(1);
      });
    });
  });
}
