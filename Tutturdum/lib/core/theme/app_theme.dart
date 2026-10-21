import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// Tutturdum Material 3 Tema Yapılandırması
class AppTheme {
  // Football Night - Koyu Tema
  static ThemeData get darkTheme {
    final interFont = GoogleFonts.inter().fontFamily;

    return ThemeData(
      useMaterial3: true,
      fontFamily: interFont,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.darkPrimaryAccent,
        secondary: AppColors.darkSecondaryAccent,
        surface: AppColors.darkCardSurface,
        error: AppColors.darkError,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: AppColors.darkPrimaryText,
      ),
      cardColor: AppColors.darkCardSurface,
      cardTheme: CardThemeData(
        color: AppColors.darkCardSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: AppColors.darkDivider, width: 1),
        ),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.darkPrimaryText,
        ),
        iconTheme: const IconThemeData(color: AppColors.darkPrimaryText),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSecondaryBackground,
        selectedItemColor: AppColors.darkPrimaryAccent,
        unselectedItemColor: AppColors.darkSecondaryText,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.darkSecondaryBackground,
        indicatorColor: AppColors.darkPrimaryAccent.withValues(alpha: 0.15),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.darkPrimaryAccent,
            );
          }
          return GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.darkSecondaryText,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.darkPrimaryAccent);
          }
          return const IconThemeData(color: AppColors.darkSecondaryText);
        }),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSecondaryBackground,
        hintStyle: const TextStyle(color: AppColors.darkSecondaryText, fontSize: 14),
        labelStyle: const TextStyle(color: AppColors.darkSecondaryText, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.darkDivider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.darkDivider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.darkPrimaryAccent, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.darkError),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      dividerColor: AppColors.darkDivider,
      dividerTheme: const DividerThemeData(
        color: AppColors.darkDivider,
        thickness: 1,
      ),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.outfit(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.darkPrimaryText,
        ),
        headlineMedium: GoogleFonts.outfit(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.darkPrimaryText,
        ),
        titleLarge: GoogleFonts.outfit(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.darkPrimaryText,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.darkPrimaryText,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 15,
          color: AppColors.darkPrimaryText,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 13,
          color: AppColors.darkSecondaryText,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.darkPrimaryText,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkPrimaryAccent,
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Stadium Light - Açık Tema
  static ThemeData get lightTheme {
    final interFont = GoogleFonts.inter().fontFamily;

    return ThemeData(
      useMaterial3: true,
      fontFamily: interFont,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.lightPrimaryAccent,
        secondary: AppColors.lightSecondaryAccent,
        surface: AppColors.lightCardSurface,
        error: AppColors.lightError,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.lightPrimaryText,
      ),
      cardColor: AppColors.lightCardSurface,
      cardTheme: CardThemeData(
        color: AppColors.lightCardSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: AppColors.lightDivider, width: 1),
        ),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightCardSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.lightPrimaryText,
        ),
        iconTheme: const IconThemeData(color: AppColors.lightPrimaryText),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: AppColors.lightPrimaryAccent.withValues(alpha: 0.15),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.lightPrimaryAccent,
            );
          }
          return GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.lightSecondaryText,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.lightPrimaryAccent);
          }
          return const IconThemeData(color: AppColors.lightSecondaryText);
        }),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(color: AppColors.lightSecondaryText, fontSize: 14),
        labelStyle: const TextStyle(color: AppColors.lightSecondaryText, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.lightDivider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.lightDivider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.lightPrimaryAccent, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.lightError),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      dividerColor: AppColors.lightDivider,
      dividerTheme: const DividerThemeData(
        color: AppColors.lightDivider,
        thickness: 1,
      ),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.outfit(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.lightPrimaryText,
        ),
        headlineMedium: GoogleFonts.outfit(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.lightPrimaryText,
        ),
        titleLarge: GoogleFonts.outfit(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.lightPrimaryText,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.lightPrimaryText,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 15,
          color: AppColors.lightPrimaryText,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 13,
          color: AppColors.lightSecondaryText,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.lightPrimaryText,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightPrimaryAccent,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
