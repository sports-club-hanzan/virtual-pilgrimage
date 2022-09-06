import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color.dart';

extension AppTheme on ThemeData {
  static final theme = ThemeData(
    unselectedWidgetColor: ColorStyle.grey,
    focusColor: ColorStyle.primary,
    primaryColor: ColorStyle.primary,
    primaryColorDark: ColorStyle.primaryDark,
    primaryColorLight: ColorStyle.primaryLight,
    backgroundColor: ColorStyle.white,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      centerTitle: true,
      backgroundColor: ColorStyle.white,
      elevation: 0,
    ),
    // ダークモードにしても通常色にしてもバッテリーなどの表示に支障を与えないようにしている
    // ref. https://zenn.dev/sugitlab/articles/d49a056941d511
    primarySwatch: MaterialColor(
      ColorStyle.white.value,
      <int, Color>{
        50: Color(ColorStyle.white.value),
        100: Color(ColorStyle.white.value),
        200: Color(ColorStyle.white.value),
        300: Color(ColorStyle.white.value),
        400: Color(ColorStyle.white.value),
        500: Color(ColorStyle.white.value),
        600: Color(ColorStyle.white.value),
        700: Color(ColorStyle.white.value),
        800: Color(ColorStyle.white.value),
        900: Color(ColorStyle.white.value),
      },
    ),
  );
}
