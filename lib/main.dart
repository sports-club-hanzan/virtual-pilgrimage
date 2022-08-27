import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/app.dart';
import 'package:virtualpilgrimage/gen/firebase_options_dev.dart' as dev;
import 'package:virtualpilgrimage/gen/firebase_options_prod.dart' as prod;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
  await Firebase.initializeApp(options: getFirebaseOptions(flavor));
  // FIXME: FirebaseAnalytics のテストのために記述しているので削除する
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  await analytics
      .logEvent(name: 'start', parameters: {'foo': 'bar', 'hoge': 'fuga'});
  runApp(ProviderScope(child: App()));
}

FirebaseOptions getFirebaseOptions(String flavor) {
  switch (flavor) {
    case 'dev':
      return dev.DefaultFirebaseOptions.currentPlatform;
    case 'prod':
      return prod.DefaultFirebaseOptions.currentPlatform;
    default:
      throw ArgumentError(
          'Flavor is invalid. "dev" or "prod" are expected. but flavor: $flavor');
  }
}
