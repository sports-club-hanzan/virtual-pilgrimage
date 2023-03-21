import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/gen/firebase_options_dev.dart' as dev;
import 'package:virtualpilgrimage/gen/firebase_options_prod.dart' as prod;
import 'package:virtualpilgrimage/router.dart';
import 'package:virtualpilgrimage/ui/style/theme.dart';

Future<void> main() async {
  // 初期化が終了するまでスプラッシュ画面を表示
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
  await Firebase.initializeApp(options: _getFirebaseOptions(flavor));
  // flutter側で検知されるエラーをCrashlyticsに送信
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(const ProviderScope(child: _App(flavor: flavor)));
}

class _App extends ConsumerWidget {
  const _App({required this.flavor});

  final String flavor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      title: '巡礼ウォーク',
      locale: const Locale('ja'),
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: flavor == 'dev',
    );
  }
}

FirebaseOptions _getFirebaseOptions(String flavor) {
  switch (flavor) {
    case 'dev':
      return dev.DefaultFirebaseOptions.currentPlatform;
    case 'prod':
      return prod.DefaultFirebaseOptions.currentPlatform;
    default:
      throw ArgumentError(
        'Flavor is invalid. "dev" or "prod" are expected. but flavor: $flavor',
      );
  }
}
