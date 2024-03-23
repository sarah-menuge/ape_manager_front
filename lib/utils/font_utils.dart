import 'package:flutter/material.dart';

class FontUtils {
  static TextStyle getFontApp({
    double fontSize = 30,
    Color color = Colors.black,
    bool shadows = false,
    double letterSpacing = 0,
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fontstyle = FontStyle.normal,
  }) {
    return TextStyle(
      fontStyle: fontstyle,
      fontFamily: 'Oswald',
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      letterSpacing: letterSpacing,
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
