import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontUtils {
  static TextStyle getFontApp(
      {double fontSize = 30,
      Color color = Colors.black,
      bool shadows = false,
      FontWeight fontWeight = FontWeight.normal}) {
    // Cette fonction permet de réutiliser la police principale
    return GoogleFonts.oswald(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      shadows: shadows
          ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 6,
                offset: Offset(4, 4),
              )
            ]
          : null,
    );
  }
}
