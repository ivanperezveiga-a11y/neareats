import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFE85D26);
  static const Color primaryLight = Color(0xFFF0997B);
  static const Color primaryDark = Color(0xFF993C1D);
  static const Color background = Color(0xFFF8F6F3);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF2C2C2A);
  static const Color textSecondary = Color(0xFF5F5E5A);
  static const Color textHint = Color(0xFF888780);
  static const Color border = Color(0xFFD3D1C7);
  static const Color success = Color(0xFF3B6D11);
  static const Color error = Color(0xFFA32D2D);
  static const Color warning = Color(0xFFBA7517);
}

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary);
  static const TextStyle heading2 = TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary);
  static const TextStyle heading3 = TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
  static const TextStyle body = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textPrimary);
  static const TextStyle bodySecondary = TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.textSecondary);
  static const TextStyle caption = TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: AppColors.textHint);
}

class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

class AppRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double full = 999;
}

class AppResponsive {
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  static double horizontalPadding(BuildContext context) =>
      isTablet(context) ? 48 : 16;

  static int gridColumns(BuildContext context) =>
      isTablet(context) ? 2 : 1;
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        background: AppColors.background,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
    );
  }
}