import 'package:flutter/material.dart';

class AppFonts {
  static const String kantumruyPro = 'Kantumruy_Pro';

  static TextTheme textTheme([TextTheme? base]) {
    final theme = base ?? ThemeData.light().textTheme;
    return theme.apply(fontFamily: kantumruyPro);
  }

  static TextStyle style({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: kantumruyPro,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }
}
