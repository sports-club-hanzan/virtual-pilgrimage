import 'package:flutter/material.dart';

import 'color.dart';

extension AppTheme on ThemeData {
  static final theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: ColorStyle.primary),
    unselectedWidgetColor: ColorStyle.grey,
    iconTheme: const IconThemeData(color: ColorStyle.primary),
    // ref. https://zenn.dev/pressedkonbu/articles/copy-paste-text-form-field
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      focusColor: ColorStyle.primary,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: ColorStyle.grey,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: ColorStyle.primaryDark,
          width: 2,
        ),
      ),
    ),
  );
}
