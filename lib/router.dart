import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_analytics_provider.dart';
import 'package:virtualpilgrimage/logger.dart';
import 'package:virtualpilgrimage/ui/pages/home/home_page.dart';
import 'package:virtualpilgrimage/ui/pages/profile/profile_page.dart';
import 'package:virtualpilgrimage/ui/pages/registration/registration_page.dart';
import 'package:virtualpilgrimage/ui/pages/sign_in/sign_in_page.dart';

extension RouterPath on String {
  static const home = '/';
  static const signIn = '/signin';
  static const registration = '/registration';
  static const profile = '/profile';
  static const edit = '/edit';
}

// アニメーション抜きで即ページ遷移させるための設定
// タブで移動できるページに実装
CustomTransitionPage<ConsumerWidget> zeroTransitionPage(Widget child, BuildContext context) =>
    CustomTransitionPage(
      child: child,
      transitionDuration: Duration.zero,
      transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
    );

// ref. https://zenn.dev/mkikuchi/articles/cc87c84e1404c4
final Provider<GoRouter> routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    observers: [
      // Firebase Analytics に view の遷移を伝える
      FirebaseAnalyticsObserver(analytics: ref.read(firebaseAnalyticsProvider)),
    ],
    routes: <GoRoute>[
      // ルート
      GoRoute(
        path: RouterPath.home,
        pageBuilder: (context, state) => zeroTransitionPage(const HomePage(), context),
      ),
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
      ),
      // ユーザ情報表示
      GoRoute(
        name: RouterPath.profile,
        path: RouterPath.profile,
        pageBuilder: (context, state) {
          final userId = state.queryParams['userId']!;
          final canEdit = state.queryParams['canEdit'];
          final previousPage = state.queryParams['previousPagePath'];
          final page = ProfilePage(
            userId: userId,
            canEdit: canEdit == 'true',
            previousPagePath: previousPage ?? RouterPath.home,
          );
          return zeroTransitionPage(page, context);
        },
      ),
      // ユーザ情報編集
      GoRoute(
        path: RouterPath.edit,
        builder: (BuildContext context, GoRouterState state) {
          return const RegistrationPage();
        },
      ),
    ],
    redirect: (state) {
      ref.read(loggerProvider).d(state.location);
      // サインイン状態によって遷移先を変える
      final loginState = ref.watch(loginStateProvider);
      if (loginState == null) {
        if (state.location != RouterPath.signIn) {
          return RouterPath.signIn;
        }
      } else {
        switch (loginState) {
          // ユーザが作成済みの時
          // 基本的にはここにページ遷移を記載する
          case UserStatus.created:
            return null;
          // ユーザ情報が登録途中の時
          case UserStatus.temporary:
            if (state.location != RouterPath.registration) {
              return RouterPath.registration;
            }
            break;
          // 削除済みの時
          case UserStatus.deleted:
            // TODO(s14t284): Handle this case.
            break;
        }
      }

      return null;
    },
  ),
);
