import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/analytics.dart';
import 'package:virtualpilgrimage/domain/auth/sign_in_usecase.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/router.dart';
import 'package:virtualpilgrimage/ui/style/font.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({super.key});

  /// drawerを開くためにログイン後に遷移できる各ページに設定すべきkey
  static final globalScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.read(userStateProvider);

    Widget drawerChild = Container();
    if (userState != null) {
      drawerChild = ListView(
        children: [
          _headerWidget(context, userState),
          _menuWidget(context, Icons.edit_outlined, 'ユーザ情報編集', () => _moveEditPage(context, ref)),
          _menuWidget(context, Icons.logout_outlined, 'ログアウト', () => _logout(context, ref)),
        ],
      );
    }

    return Drawer(
      width: 220,
      child: drawerChild,
    );
  }

  Widget _headerWidget(BuildContext context, VirtualPilgrimageUser user) => DrawerHeader(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.userIconUrl),
                backgroundColor: Colors.transparent,
                radius: 48,
              ),
            ),
            Text(
              '${user.nickname} さん',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );

  Widget _menuWidget(BuildContext context, IconData icon, String text, VoidCallback onPressed) {
    final color = Theme.of(context).colorScheme.onPrimaryContainer;
    return TextButton(
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Icon(icon, color: color),
          ),
          Text(
            text,
            style:
                TextStyle(color: color, fontSize: FontSize.mediumSize, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  /// ユーザ情報編集ページに移動
  Future<void> _moveEditPage(BuildContext context, WidgetRef ref) async {
    Navigator.of(context).pop();
    unawaited(ref.read(analyticsProvider).logEvent(eventName: AnalyticsEvent.moveEditPage));
    ref.read(routerProvider).push(RouterPath.edit);
  }

  /// ログアウトを実行
  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    Navigator.of(context).pop();
    await ref.read(analyticsProvider).logEvent(eventName: AnalyticsEvent.logout);
    await ref.read(signInUsecaseProvider).logout();
    ref.read(userStateProvider.state).state = null;
    // loginState を変更するとページが遷移するので更新順を後ろにしている
    ref.read(loginStateProvider.state).state = null;
  }
}
