import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:virtualpilgrimage/ui/pages/login/login_page.dart';
import 'package:virtualpilgrimage/ui/style/theme.dart';

class App extends ConsumerWidget {
  App({Key? key}) : super(key: key);

  // ref. https://zenn.dev/mkikuchi/articles/cc87c84e1404c4
  final GoRouter _router = GoRouter(
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
          child: LoginPage(key: state.pageKey),
        ),
      ),
      // ログイン
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      )
    ],
    redirect: ((state) {
      // TODO: ログイン状態によって遷移先のページを変更する
      if (state.location != '/login') {
        return '/login';
      }
      return null;
    }),
    // FIXME: 以下にログイン状態を保つモデルを渡す。ref.watch で login状態を持つProviderを参照すれば良い
    // refreshListenable:
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      // TODO: タイトルはアプリ名に変更
      title: 'Virtual Pilgrimage',
      locale: const Locale('ja'),
      theme: AppTheme.theme,
    );
  }
}
