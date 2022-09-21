import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mockito/mockito.dart';
import 'package:virtualpilgrimage/analytics.dart';

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
      test('正常系: value に値が設定される場合', () async {
        // given
        const name = 'dummyName';
        const value = 'User(name=dummyName, email=test@example.com)';
        when(mockFirebaseAnalytics.setUserProperty(name: name, value: value))
            .thenAnswer((_) => Future.value());

        // when
        await analytics.setUserProperties(name: name, value: value);

        // then
        verify(mockFirebaseAnalytics.setUserProperty(name: name, value: value)).called(1);
      });

      test('正常系: value に値が設定されない場合', () async {
        // given
        const name = 'dummyName';
        when(mockFirebaseAnalytics.setUserProperty(name: name, value: null))
            .thenAnswer((_) => Future.value());

        // when
        await analytics.setUserProperties(name: name);

        // then
        verify(mockFirebaseAnalytics.setUserProperty(name: name, value: null)).called(1);
      });
    });
  });
}
