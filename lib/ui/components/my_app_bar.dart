import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const MyAppBar({this.isLogin = true, this.tabBar, super.key});

  final bool isLogin;
  final PreferredSizeWidget? tabBar;
  static const appTitle = '巡礼ウォーク';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme.onPrimaryContainer;
    final textStyle = TextStyle(color: color, fontFamily: GoogleFonts.kosugiMaru().fontFamily);
    return AppBar(
      title: Text(appTitle, style: textStyle),
      bottom: tabBar,
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }

  @override
  Size get preferredSize =>
      // tabBar が存在するときは tabBar のサイズを加算して AppBar の高さとする
      Size.fromHeight(kToolbarHeight + (tabBar?.preferredSize.height ?? 0));
}
