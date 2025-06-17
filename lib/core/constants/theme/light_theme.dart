import 'package:flutter/material.dart';
import '../color/app_colorscheme.dart';

final ThemeData lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(fontSize: 16, color: Colors.black),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: lightColorScheme.secondary,
      foregroundColor: lightColorScheme.onSecondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: lightColorScheme.primary,
    foregroundColor: lightColorScheme.onPrimary,
    elevation: 0,
  ),
);
