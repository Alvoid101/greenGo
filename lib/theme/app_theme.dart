import 'package:flutter/material.dart';

class AppTheme {
  // Colores de la marca GreenGo
  static const Color primaryGreen = Color(0xFF2ECC71);
  static const Color darkGreen = Color(0xFF27AE60);
  static const Color lightGreen = Color(0xFF58D68D);
  static const Color accentOrange = Color(0xFFF39C12);
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF2C3E50);
  static const Color textGrey = Color(0xFF7F8C8D);
  static const Color successGreen = Color(0xFF27AE60);
  static const Color warningOrange = Color(0xFFE67E22);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        primary: primaryGreen,
        secondary: accentOrange,
        background: backgroundLight,
        surface: cardWhite,
      ),
      scaffoldBackgroundColor: backgroundLight,
      
      // AppBar Theme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: cardWhite,
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // Text Theme
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: textDark,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: textGrey,
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: accentOrange,
        foregroundColor: Colors.white,
        elevation: 4,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: primaryGreen,
      ),
    );
  }
}
