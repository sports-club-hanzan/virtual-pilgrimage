import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/gen/firebase_options_dev.dart' as dev;
import 'package:virtualpilgrimage/gen/firebase_options_prod.dart' as prod;
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_auth_provider.dart';
import 'package:virtualpilgrimage/router.dart';
import 'package:virtualpilgrimage/ui/style/theme.dart';

import 'domain/user/user_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
  await Firebase.initializeApp(options: _getFirebaseOptions(flavor));
  runApp(const ProviderScope(child: _App()));
}

class _App extends ConsumerWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    final userState = ref.watch(userStateProvider.state);

    // Firebaseへのログインがキャッシュされていれば
    // Firestoreからユーザ情報を詰める
    if (firebaseAuth.currentUser != null && userState.state == null) {
      ref
          .read(userRepositoryProvider)
          .get(firebaseAuth.currentUser!.uid)
          .then((value) => userState.state = value);
    }

    return MaterialApp.router(
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      // TODO: タイトルはアプリ名に変更
      title: 'Virtual Pilgrimage',
      locale: const Locale('ja'),
      theme: AppTheme.theme,
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
          'Flavor is invalid. "dev" or "prod" are expected. but flavor: $flavor');
  }
}
