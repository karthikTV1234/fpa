import 'package:flutter/material.dart';
import '../color/app_colorscheme.dart';

final ThemeData darkTheme = ThemeData(
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