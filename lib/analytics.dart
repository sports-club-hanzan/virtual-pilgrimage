import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_analytics_provider.dart';
import 'package:virtualpilgrimage/logger.dart';

// analytics クラスに渡すイベント名を定義する extension
extension AnalyticsEvent on String {
  static const signInWithEmailAndPassword = 'sign_in_with_email_and_password';
  static const signInWithEmailAndPasswordFailed = 'sign_in_with_email_and_password_failed';
  static const signInWithGoogle = 'sign_in_with_google';
  static const signInWithGoogleFailed = 'sign_in_with_google_failed';
  static const logout = 'logout';
  static const pressedRegistration = 'pressed_registration';
  static const registrationFailed = 'registration_failed';
}

final analyticsProvider = Provider<Analytics>(
      (ref) => Analytics(ref.read(firebaseAnalyticsProvider), ref.read(loggerProvider)),
);

class Analytics {
  Analytics(this._analytics, this._logger);

  final FirebaseAnalytics _analytics;
  final Logger _logger;

  Future<void> logEvent({required String eventName, Map<String, dynamic>? parameters}) async {
    if (eventName.length > 40) {
      _logger.w('firebase analytics log name must be 40 or less. [eventName][$eventName][parameters][$parameters]');
      return Future.value();
    }

    return _analytics.logEvent(name: eventName, parameters: parameters);
  }

  Future<void> setCurrentScreen({required String screenName}) async {
    unawaited(logEvent(eventName: 'route_screen_$screenName'));
    await _analytics.setCurrentScreen(screenName: screenName);
  }

  Future<void> setUserProperties({required String name, String? value}) async {
    unawaited(_analytics.setUserProperty(name: name, value: value));
  }
}
