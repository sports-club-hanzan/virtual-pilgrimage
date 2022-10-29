import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/analytics.dart';
import 'package:virtualpilgrimage/domain/auth/sign_in_usecase.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

class MyAppBar extends ConsumerWidget with PreferredSizeWidget {
  const MyAppBar({this.isLogin = true, super.key});

  final bool isLogin;
  static const appTitle = '巡礼ウォーク';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme.onPrimaryContainer;
    final textStyle = TextStyle(color: color);
    return AppBar(
      title: Text(appTitle, style: textStyle),
      actions: <Widget>[
        if (isLogin)
          TextButton(
            onPressed: () => _logout(ref),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Icon(Icons.login_outlined, color: color),
                ),
                Text('ログアウト', style: textStyle)
              ],
            ),
          )
      ],
    );
  }

  Future<void> _logout(WidgetRef ref) async {
    await ref.read(analyticsProvider).logEvent(eventName: AnalyticsEvent.logout);
    await ref.read(signInUsecaseProvider).logout();
    ref.read(userStateProvider.state).state = null;
    // loginState を変更するとページが遷移するので更新順を後ろにしている
    ref.read(loginStateProvider.state).state = null;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
