import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Defines the typography scale and text styles for StockPilot.
///
/// Follows Material 3 type scale guidelines while adding specific
/// styles for financial data (prices, percentages) which are critical
/// for the application's core use case.
///
/// Font family is set to the system default sans-serif for maximum
/// compatibility. To use a custom font (e.g., Inter, Poppins),
/// update the [fontFamily] constant and add the font assets to pubspec.yaml.
class AppTypography {
  const AppTypography._();

  /// The primary font family for the application.
  /// Change this to 'Inter', 'Poppins', etc. if custom fonts are added.
  static const String fontFamily = '.SF Pro Text'; // Fallback to system default

  // ─── Display Styles ──────────────────────────────────────
  // Used for large, impactful numbers or hero sections.
  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    height: 1.12,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 45,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.16,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.22,
  );

  // ─── Headline Styles ─────────────────────────────────────
  // Used for page titles and major section headers.
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
    height: 1.25,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
    height: 1.29,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
    height: 1.33,
  );

  // ─── Title Styles ────────────────────────────────────────
  // Used for card titles, list items, and medium emphasis text.
  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
    height: 1.27,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.50,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.43,
  );

  // ─── Body Styles ─────────────────────────────────────────
  // Used for primary content, descriptions, and paragraphs.
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.50,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  );

  // ─── Label Styles ────────────────────────────────────────
  // Used for buttons, tabs, and small UI elements.
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.43,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.33,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.45,
  );

  // ─── Financial Specific Styles ───────────────────────────
  // Optimized for displaying stock prices, percentages, and numbers.
  // Uses tabular nums for aligned columns in lists/tables.

  static const TextStyle priceLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.2,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static const TextStyle priceMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
    height: 1.2,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static const TextStyle percentagePositive = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.successLight,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static const TextStyle percentageNegative = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.errorLight,
    fontFeatures: [FontFeature.tabularFigures()],
  );
}
