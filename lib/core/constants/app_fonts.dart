import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static const String kantumruyPro = 'Kantumruy Pro';

  static TextTheme textTheme([TextTheme? base]) =>
      GoogleFonts.kantumruyProTextTheme(base);

  static TextStyle style({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
  }) =>
      GoogleFonts.kantumruyPro(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );
}
