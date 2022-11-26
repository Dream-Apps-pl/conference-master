import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

extension ColorExt on String {
  Color? hexToColor() {
    if (this == '') return null;

    return new Color(int.parse(this.substring(1, 7), radix: 16) + 0xFF000000);
  }
}

class AppThemes {
  static const int LightBlue = 0;
  static const int LightOrange = 1;
  static const int Dark = 2;
}

final themeCollection = ThemeCollection(
  themes: {
    AppThemes.LightBlue: ThemeData(primarySwatch: Colors.blue),
    AppThemes.LightOrange: ThemeData(primarySwatch: Colors.deepOrange),
    AppThemes.Dark: ThemeData.dark(),
  },
  fallbackTheme: ThemeData.light(),
);
