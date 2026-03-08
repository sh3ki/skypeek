import 'package:flutter/material.dart';

class AppTheme {
  // SkyPeek Brand Colors — Sky Blue Palette
  static const Color primary = Color(0xFF0EA5E9);
  static const Color primaryDark = Color(0xFF0284C7);
  static const Color secondary = Color(0xFF7C3AED);
  static const Color accent = Color(0xFFF59E0B);
  static const Color surface = Color(0xFFF0F9FF);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color divider = Color(0xFFE8F4FD);

  static BoxShadow get cardShadow => BoxShadow(
        color: const Color(0xFF0EA5E9).withOpacity(0.10),
        blurRadius: 16,
        offset: const Offset(0, 4),
      );

  // Weather condition colors
  static const Color sunny = Color(0xFFF59E0B);
  static const Color cloudy = Color(0xFF94A3B8);
  static const Color rainy = Color(0xFF3B82F6);
  static const Color stormy = Color(0xFF6366F1);
  static const Color snowy = Color(0xFF93C5FD);
  static const Color foggy = Color(0xFFCBD5E1);

  // Gradient backgrounds per weather
  static const LinearGradient sunnyGradient = LinearGradient(
    colors: [Color(0xFF0EA5E9), Color(0xFF0284C7)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cloudyGradient = LinearGradient(
    colors: [Color(0xFF64748B), Color(0xFF475569)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient rainyGradient = LinearGradient(
    colors: [Color(0xFF1E40AF), Color(0xFF1D4ED8)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient nightGradient = LinearGradient(
    colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.light,
        primary: primary,
        secondary: secondary,
        surface: surface,
      ),
    );
    return base.copyWith(
      scaffoldBackgroundColor: surface,
      textTheme: base.textTheme.copyWith(
        displayLarge: TextStyle(
            fontSize: 72, fontWeight: FontWeight.w900, color: Colors.white),
        displayMedium: TextStyle(
            fontSize: 48, fontWeight: FontWeight.w800, color: Colors.white),
        headlineLarge: TextStyle(
            fontSize: 32, fontWeight: FontWeight.w800, color: textPrimary),
        headlineMedium: TextStyle(
            fontSize: 22, fontWeight: FontWeight.w700, color: textPrimary),
        titleLarge: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w700, color: textPrimary),
        bodyLarge: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w500, color: textPrimary),
        bodyMedium: TextStyle(
            fontSize: 13, fontWeight: FontWeight.w400, color: textSecondary),
        labelLarge: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w700, color: textPrimary),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
    );
  }
}
