// import 'dart:ui';

import 'package:child_health_story/core/constants/color/app_colors.dart';
import 'package:flutter/material.dart';

class TextStyleWidget {
  static TextStyle textStyleWidget(Color textColor,
      {double? fontSize = 10.0,
      FontWeight? fontWeight = FontWeight.normal,
      String? fontFamily = 'Roboto',
      TextDecoration? decoration = TextDecoration.none,
      Color? decorationColor = AppColors.darkBackgroundColor}) {
    return TextStyle(
        decoration: decoration,
        decorationColor: decorationColor,
        color: textColor,
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight);
  }
}
