import 'package:bitbust/src/utils/utils.dart';
import 'package:flutter/material.dart';

class ThemeConfig {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(
      weight: 1,
      size: 20,
      color: AppColors.grey500,
    ),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
    fontFamily: "SF-Pro",
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.grey50, width: 0),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primary400),
        borderRadius: BorderRadius.circular(10),
      ),
      hintStyle: normalStyle(16, AppColors.grey400),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primary400),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      fillColor: AppColors.grey50,
      filled: true,
    ),
  );
}
