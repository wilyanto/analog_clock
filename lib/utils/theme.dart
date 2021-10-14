import 'package:flutter/material.dart';

class CustomTextTheme {
  final String fontFamily = 'Poppins';

  static TextStyle getTextStyle({
    double fontSize = 12,
    FontStyle fontStyle = FontStyle.normal,
    Color color = Colors.black87,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
