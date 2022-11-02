import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/analytics.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/gen/firebase_options_dev.dart' as dev;
import 'package:virtualpilgrimage/gen/firebase_options_prod.dart' as prod;
import 'package:virtualpilgrimage/gen/firebase_options_prod_sub.dart' as sub;
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_auth_provider.dart';
import 'package:virtualpilgrimage/router.dart';
import 'package:virtualpilgrimage/ui/style/theme.dart';

import 'domain/user/user_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
  await Firebase.initializeApp(options: _getFirebaseOptions(flavor));
  // flutter側で検知されるエラーをCrashlyticsに送信
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(const ProviderScope(child: _App(flavor: flavor,)));
}

class _App extends ConsumerWidget {
  const _App({required this.flavor});

  final String flavor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    final analytics = ref.read(analyticsProvider);
    final userState = ref.watch(userStateProvider.state);
    final loginState = ref.watch(loginStateProvider.state);
    // final userIconRepository = ref.read(userIconRepositoryProvider);

    // Firebaseへのログインがキャッシュされていれば
    // Firestoreからユーザ情報を詰める
    // TODO(s14t284): この辺りの実装は綺麗にしたい
    if (firebaseAuth.currentUser != null && userState.state == null) {
      ref.read(userRepositoryProvider).get(firebaseAuth.currentUser!.uid).then((value) {
        if (value != null) {
          analytics.setUserProperties(user: value);
          // 一旦、ピン画像は更新しないようにしている
          // userIconRepository.loadIconImage(value.userIconUrl).then((bitmap) {
          //   value = value!.setUserIconBitmap(bitmap);
          //   userState.state = value;
          // });
          userState.state = value;
          loginState.state = value.userStatus;
        }
      });
    }

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
    // MEMO: subはストアにリリースした後は不要になる想定
    case 'sub':
      return sub.DefaultFirebaseOptions.currentPlatform;
    default:
      throw ArgumentError(
        'Flavor is invalid. "dev", "sub" or "prod" are expected. but flavor: $flavor',
      );
  }
}
