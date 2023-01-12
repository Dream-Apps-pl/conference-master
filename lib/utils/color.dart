import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

extension ColorExt on String {
  Color? hexToColor() {
    if (this == '') return null;

    return Color(int.parse(substring(1, 7), radix: 16) + 0xFF000000);
  }
}

class AppThemes {
  static const int lightBlue = 0;
  static const int lightOrange = 1;
  static const int dark = 2;
}

final themeCollection = ThemeCollection(
  themes: {
    AppThemes.lightBlue: ThemeData(primarySwatch: Colors.blue),
    AppThemes.lightOrange: ThemeData.from(
      colorScheme: const ColorScheme.dark(
        primary: Colors.red,
        secondary: Colors.red,
      ),
    ),
    AppThemes.dark: ThemeData.dark(),
  },
  fallbackTheme: ThemeData.light(),
);
