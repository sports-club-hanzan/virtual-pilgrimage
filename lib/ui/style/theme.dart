import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color.dart';

class AppTheme {
  static final theme = ThemeData(
    primaryColor: ColorStyle.primary,
    primaryColorDark: ColorStyle.primaryDark,
    primaryColorLight: ColorStyle.primaryLight,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      centerTitle: true,
      backgroundColor: ColorStyle.lightGrey,
      // color: ColorStyle.lightGrey,
      elevation: 0.0,
    ),
    // ダークモードにしても通常色にしてもバッテリーなどの表示に支障を与えないようにしている
    // ref. https://zenn.dev/sugitlab/articles/d49a056941d511
    primarySwatch: MaterialColor(
      ColorStyle.lightGrey.value,
      <int, Color>{
        50: Color(ColorStyle.lightGrey.value),
        100: Color(ColorStyle.lightGrey.value),
        200: Color(ColorStyle.lightGrey.value),
        300: Color(ColorStyle.lightGrey.value),
        400: Color(ColorStyle.lightGrey.value),
        500: Color(ColorStyle.lightGrey.value),
        600: Color(ColorStyle.lightGrey.value),
        700: Color(ColorStyle.lightGrey.value),
        800: Color(ColorStyle.lightGrey.value),
        900: Color(ColorStyle.lightGrey.value),
      },
    ),
  );
}
