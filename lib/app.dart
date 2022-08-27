import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:virtualpilgrimage/domain/auth/sign_in_controller.dart';
import 'package:virtualpilgrimage/domain/auth/sign_in_state.codegen.dart';
import 'package:virtualpilgrimage/ui/pages/registration/registration_page.dart';
import 'package:virtualpilgrimage/ui/pages/sign_in/sign_in_page.dart';
import 'package:virtualpilgrimage/ui/style/theme.dart';

// ref. https://zenn.dev/mkikuchi/articles/cc87c84e1404c4
// TODO: router は別で定義して、App クラスの中身を main.dart に移す
final Provider<GoRouter> routerProvider = Provider<GoRouter>((ref) => GoRouter(
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
        ),
        // ユーザ情報登録
        GoRoute(
          path: '/registration',
          builder: (BuildContext context, GoRouterState state) {
            return const RegistrationPage();
          },
        )
      ],
      redirect: ((state) {
        // サインイン状態によって遷移先を変える
        final signInContext = ref.watch(signInControllerProvider).context;
        switch (signInContext) {
          case SignInStateContext.success:
            break;
          case SignInStateContext.temporary:
            if (state.location != '/registration') {
              return '/registration';
            }
            break;
          case SignInStateContext.failed:
          case SignInStateContext.notSignedIn:
            if (state.location != '/signin') {
              return '/signin';
            }
            break;
          default:
            return '/signin';
        }

        return null;
      }),
    ));

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

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
