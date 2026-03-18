import 'package:flutter/material.dart';

class AppTheme {
  // Arctic Mist palette
  static const Color primary = Color(0xFF374151);
  static const Color primaryDark = Color(0xFF1F2937);
  static const Color secondary = Color(0xFF56B3E0);
  static const Color accent = Color(0xFFE8A54B);
  static const Color success = Color(0xFF10B981);

  static const Color surface = Color(0xFFF3F4F6);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color divider = Color(0xFFE5E7EB);

  // Weather condition colors
  static const Color sunny = Color(0xFFE8A54B);
  static const Color cloudy = Color(0xFF94A3B8);
  static const Color rainy = Color(0xFF56B3E0);
  static const Color stormy = Color(0xFF6366F1);
  static const Color snowy = Color(0xFF93C5FD);
  static const Color foggy = Color(0xFFCBD5E1);

  static Color conditionColor(String condition) {
    switch (condition) {
      case 'Sunny': return sunny;
      case 'Partly Cloudy': return secondary;
      case 'Cloudy': return cloudy;
      case 'Rainy': return rainy;
      case 'Stormy': return stormy;
      case 'Snowy': return snowy;
      case 'Foggy': return foggy;
      case 'Windy': return secondary;
      default: return secondary;
    }
  }

  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: primary.withOpacity(0.06),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: primary,
      brightness: Brightness.light,
      scaffoldBackgroundColor: surface,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(color: textPrimary),
      ),
      cardTheme: CardTheme(
        color: cardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
