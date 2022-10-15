import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  const MyAppBar({super.key});

  static const appTitle = '巡礼ウォーク';

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(appTitle),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
