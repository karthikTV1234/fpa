import 'package:flutter/material.dart';
import '../color/app_colors.dart';

class MyAppTextStyles {
  // Heading Style
  static const TextStyle headingStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black, // Default color, can be overridden
  );

  // Subheading Style
  static const TextStyle subheadingStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  // Body Text Style
  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
  );

  // Caption Style (For small text or captions)
  static const TextStyle captionStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.grey, // For less emphasized text
  );

  // Button Text Style
  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white, // For buttons, typically white text
  );

  // App Bar Title Style
  static const TextStyle appBarTitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white, // Assuming app bar is dark
  );

  // Customizable style for text with ability to modify color or other properties
  static TextStyle customStyle({
    double fontSize = 14.0,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black87,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}

