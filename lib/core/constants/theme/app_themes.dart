import 'package:flutter/material.dart';
import '../color/app_colorscheme.dart';

/// Central theme definitions using predefined color schemes.
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: lightColorScheme,
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,//for background screen color
    //for text color
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 16, color: Colors.black),
    ),
    //For button background color and text color
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightColorScheme.secondary,       // green
        foregroundColor: lightColorScheme.onSecondary,     // black (or whatever matches well)
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: lightColorScheme.primary,
      foregroundColor: lightColorScheme.onPrimary,
      elevation: 0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: darkColorScheme,
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkColorScheme.secondary,       // green
        foregroundColor: darkColorScheme.onSecondary,     // black (or whatever matches well)
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: darkColorScheme.primary,
      foregroundColor: darkColorScheme.onPrimary,
      elevation: 0,
    ),
  );
}
