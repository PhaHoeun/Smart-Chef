import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color canvas = Color(0xFF0A0D14);
  static const Color surface = Color(0xFF121622);
  static const Color surfaceContainer = Color(0xFF1A202E);
  static const Color surfaceContainerHigh = Color(0xFF242C3E);
  static const Color surfaceBright = Color(0xFF323B50);

  // Accents
  static const Color primary = Color(0xFFFF6B00); // Electric Warm Orange
  static const Color primaryGlow = Color(0xFFFF8533);
  static const Color secondary = Color(0xFFFFAA33);
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);

  // Typography Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  // Glassmorphism Tokens
  static const Color glassFill = Color(0xB31A202E); // 70% opacity
  static const Color glassBorder = Color(0x1FFFFFFF); // 12% white border
  static const Color glassFillLight = Color(0x33242C3E);

  static LinearGradient primaryGradient = const LinearGradient(
    colors: [Color(0xFFFF6B00), Color(0xFFFF8F3D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient glassCardGradient = const LinearGradient(
    colors: [Color(0xB31A202E), Color(0x80121622)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static List<BoxShadow> orangeGlow = [
    BoxShadow(
      color: primary.withValues(alpha: 0.35),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> glassShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.45),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  static ThemeData get darkTheme {
    final baseTextTheme = GoogleFonts.plusJakartaSansTextTheme();

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: canvas,
      primaryColor: primary,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        error: error,
      ),
      textTheme: baseTextTheme.copyWith(
        displayLarge: baseTextTheme.displayLarge?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w800,
          letterSpacing: -1.0,
        ),
        headlineLarge: baseTextTheme.headlineLarge?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        headlineMedium: baseTextTheme.headlineMedium?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: baseTextTheme.headlineSmall?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(
          color: textPrimary,
        ),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(
          color: textSecondary,
        ),
        bodySmall: baseTextTheme.bodySmall?.copyWith(
          color: textMuted,
        ),
      ),
    );
  }
}
