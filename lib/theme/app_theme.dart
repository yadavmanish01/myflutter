import 'package:flutter/material.dart';

enum AppThemeMode { light, dark }

final appThemeData = {
  AppThemeMode.light: ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    // Modern Material 3 configuration using colorScheme
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF02569B),
      secondary: Color(0xFF0175C2),
      background: Color(0xFFF8FAFC),
      surface: Color(0xFFFFFFFF),
    ),
    scaffoldBackgroundColor: const Color(0xFFF8FAFC),
  ),

  AppThemeMode.dark: ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF4BB1F5),
      secondary: Color(0xFF02569B),
      background: Color(0xFF0F172A),
      surface: Color(0xFF1E293B),
    ),
    scaffoldBackgroundColor: const Color(0xFF0F172A),
  ),
};