import 'package:flutter/material.dart';

import 'color.dart';

extension AppTheme on ThemeData {
  static final theme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: ColorStyle.primary,
    unselectedWidgetColor: ColorStyle.grey,
    focusColor: ColorStyle.primary,
    primaryColorDark: ColorStyle.primaryDark,
    primaryColorLight: ColorStyle.primaryLight,
    backgroundColor: ColorStyle.white,
  );
}
