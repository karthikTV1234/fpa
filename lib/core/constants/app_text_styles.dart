import 'package:flutter/material.dart';
import 'app_colors.dart';

class MyAppTextStyles {
  static const TextStyle headingStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
  );

  static const TextStyle errorStyle = TextStyle(
    fontSize: 14,
    color: MyAppColors.lightErrorColor,
  );
}
