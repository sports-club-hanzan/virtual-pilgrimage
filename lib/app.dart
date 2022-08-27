import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:virtualpilgrimage/domain/auth/sign_in_controller.dart';
import 'package:virtualpilgrimage/domain/auth/sign_in_state.codegen.dart';
import 'package:virtualpilgrimage/ui/pages/login/sign_in_page.dart';
import 'package:virtualpilgrimage/ui/style/theme.dart';

class App extends ConsumerWidget {
  App({Key? key}) : super(key: key);

  // ref. https://zenn.dev/mkikuchi/articles/cc87c84e1404c4
  final Provider<GoRouter> _router = Provider<GoRouter>((ref) => GoRouter(
        routes: <GoRoute>[
          // ルート
          GoRoute(
            path: '/',
            // builder: (BuildContext context, GoRouterState state) {
            //   return const Scaffold(
            //     body: Text('home'),
            //   );
            // },
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: SignInPage(key: state.pageKey),
            ),
          ),
          // ログイン
          GoRoute(
            path: '/signin',
            builder: (BuildContext context, GoRouterState state) {
              return const SignInPage();
            },
          )
        ],
        redirect: ((state) {
          // サインイン状態によって遷移先を変える
          final signInContext = ref.read(signInController).context;

          if (signInContext == SignInStateContext.notSignedIn) {
            return '/signin';
          }
          // ログイン成功時
          if (signInContext == SignInStateContext.success) {}
          // TODO: ログイン状態によって遷移先のページを変更する
          if (state.location != '/signin') {
            return '/signin';
          }
          return null;
        }),
      ));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(_router);

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
