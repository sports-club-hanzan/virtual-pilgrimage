import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/ui/components/molecules/my_drawer.dart';

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
      actions: [
        if (isLogin)
          userIcon(
            ref.watch(userStateProvider)?.userIconUrl,
            () => MyDrawer.globalScaffoldKey.currentState?.openEndDrawer(),
          ),
      ],
    );
  }

  Widget userIcon(String? iconUrl, VoidCallback onPressed) {
    const iconSize = 32.0;
    return IconButton(
      icon: iconUrl != null
          ? CircleAvatar(
              backgroundImage: NetworkImage(iconUrl),
              backgroundColor: Colors.transparent,
              radius: iconSize / 2,
            )
          : const Icon(
              Icons.account_circle_outlined,
              size: iconSize,
            ),
      onPressed: onPressed,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
