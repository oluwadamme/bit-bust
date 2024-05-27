import 'package:bitbust/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConfig {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(
      weight: 1,
      size: 20,
      color: AppColors.grey61,
    ),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white, elevation: 0),
    fontFamily: GoogleFonts.outfit().fontFamily,
    splashColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.greyF0, width: 0),
        borderRadius: BorderRadius.zero,
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.grey900),
        borderRadius: BorderRadius.zero,
      ),
      hintStyle: normalStyle(12, AppColors.grey97),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.grey900),
        borderRadius: BorderRadius.zero,
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.zero,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      fillColor: AppColors.greyF2,
      filled: true,
    ),
  );
}
