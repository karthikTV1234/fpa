import 'package:flutter/material.dart';

/// Light ColorScheme for the app.
const ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Colors.blueAccent,
  onPrimary: Colors.white,
  secondary: Colors.green,
  onSecondary: Colors.black,
  surface: Colors.white,
  onSurface: Colors.black,
  onSurfaceVariant: Colors.black87,
  primaryContainer: Color(0xFFB3E5FC),
  onPrimaryContainer: Colors.black,
  secondaryContainer: Color(0xFFA5D6A7),
  onSecondaryContainer: Colors.black,
  error: Colors.red,
  onError: Colors.white,
);

/// Dark ColorScheme for the app.
const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Colors.blueAccent,
  onPrimary: Colors.white,
  secondary: Colors.green,
  onSecondary: Colors.white,
  surface: Color(0xFF121212),
  onSurface: Colors.white,
  onSurfaceVariant: Colors.white70,
  primaryContainer: Color(0xFF0288D1),
  onPrimaryContainer: Colors.white,
  secondaryContainer: Color(0xFF388E3C),
  onSecondaryContainer: Colors.white,
  error: Colors.red,
  onError: Colors.white,
);
