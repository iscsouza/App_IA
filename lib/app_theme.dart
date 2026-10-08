import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF222D15);
  static const Color secondary = Color(0xFF0C100D);
  static const Color tertiary = Color(0xFF141915);
  static const Color background = Color(0xFF2C342D);
  static const Color cardBg = Color(0xFF141915);
  static const Color textLight = Color(0xFFF0F4EC);
  static const Color accent = Color(0xFFB0F320);
  static const Color textMuted = Color(0xFFA0ABA0);
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.tertiary,
        surface: AppColors.cardBg,
        onSurface: AppColors.textLight,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textLight,
        elevation: 0,
        centerTitle: true,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.textLight),
        bodyMedium: TextStyle(color: AppColors.textLight),
      ),
    );
  }
}
