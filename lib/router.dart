import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/ui/pages/registration/registration_page.dart';
import 'package:virtualpilgrimage/ui/pages/sign_in/sign_in_page.dart';

extension RouterPath on String {
  static const home = '/';
  static const signIn = '/signin';
  static const registration = '/registration';
}

// ref. https://zenn.dev/mkikuchi/articles/cc87c84e1404c4
final Provider<GoRouter> routerProvider = Provider<GoRouter>((ref) => GoRouter(
      routes: <GoRoute>[
        // ルート
        // GoRoute(
        //   path: '/',
        //   builder: (BuildContext context, GoRouterState state) {
        //     return const Scaffold(
        //       body: Text('home'),
        //     );
        //   },
        //   pageBuilder: (context, state) => MaterialPage<void>(
        //     key: state.pageKey,
        //     child: SignInPage(key: state.pageKey),
        //   ),
        // ),
        // ログイン
        GoRoute(
          path: RouterPath.signIn,
          builder: (BuildContext context, GoRouterState state) {
            return const SignInPage();
          },
        ),
        // ユーザ情報登録
        GoRoute(
          path: RouterPath.registration,
          builder: (BuildContext context, GoRouterState state) {
            return const RegistrationPage();
          },
        )
      ],
      redirect: ((state) {
        // サインイン状態によって遷移先を変える
        final userState = ref.watch(userStateProvider);
        if (userState == null) {
          if (state.location != RouterPath.signIn) {
            return RouterPath.signIn;
          }
        } else {
          switch (userState.userStatus) {
            case UserStatus.temporary:
              if (state.location != RouterPath.registration) {
                return RouterPath.registration;
              }
              break;
            case UserStatus.success:
              // TODO: Handle this case.
              break;
            case UserStatus.deleted:
              // TODO: Handle this case.
              break;
          }
        }

        return null;
      }),
    ));
