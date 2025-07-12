import 'dart:ui';

class AppColors {
  // Light Theme Colors
  static const Color lightPrimaryColor = Color(0xFF6200EE);
  static const Color lightAccentColor = Color(0xFF03DAC5);
  static const Color lightBackgroundColor = Color(0xFFF5F5F5);
  static const Color lightTextColor = Color(0xFF212121);
  static const Color lightErrorColor = Color(0xFFB00020);
  static Color cblackColor = hexToColors("#000000");
  //White Colors
  static Color cwhiteColor = hexToColors("#FFFFFF");

  // Dark Theme Colors
  static const Color darkPrimaryColor = Color(0xFFBB86FC);
  static const Color darkAccentColor = Color(0xFF03DAC5);
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color darkTextColor = Color(0xFFE1E1E1);
  static const Color darkErrorColor = Color(0xFFCF6679);
}

Color hexToColors(String s) {
  return Color(int.parse(s.substring(1, 7), radix: 16) + 0xFF000000);
}