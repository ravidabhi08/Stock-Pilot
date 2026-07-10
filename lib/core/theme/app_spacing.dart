import 'package:flutter/material.dart';

/// Defines the spacing scale for the StockPilot application.
///
/// Uses an 8-point grid system (with 4-point subdivisions) to ensure
/// consistent margins, paddings, and gaps across the UI.
/// This aligns with Material 3 design guidelines and promotes a
/// harmonious, premium layout.
class AppSpacing {
  const AppSpacing._();

  /// 2.0 logical pixels. Used for very tight spacing (e.g., icon to text).
  static const double xxs = 2.0;

  /// 4.0 logical pixels. Used for minimal spacing (e.g., inner padding).
  static const double xs = 4.0;

  /// 8.0 logical pixels. Standard small spacing (e.g., list item padding).
  static const double sm = 8.0;

  /// 12.0 logical pixels. Used for standard component padding.
  static const double md = 12.0;

  /// 16.0 logical pixels. Standard medium spacing (e.g., screen horizontal padding).
  static const double lg = 16.0;

  /// 20.0 logical pixels. Used for larger gaps between sections.
  static const double xl = 20.0;

  /// 24.0 logical pixels. Standard large spacing (e.g., screen vertical padding).
  static const double xxl = 24.0;

  /// 32.0 logical pixels. Used for major section separations.
  static const double xxxl = 32.0;

  /// 48.0 logical pixels. Used for hero sections or large empty spaces.
  static const double xxxxl = 48.0;

  // ─── Screen Padding ──────────────────────────────────────

  /// Standard horizontal padding for screens.
  static const double screenHorizontal = lg; // 16.0

  /// Standard vertical padding for screens.
  static const double screenVertical = xxl; // 24.0

  /// Standard screen padding (symmetric).
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: screenHorizontal,
    vertical: screenVertical,
  );

  /// Standard horizontal screen padding.
  static const EdgeInsets screenHorizontalPadding = EdgeInsets.symmetric(
    horizontal: screenHorizontal,
  );

  // ─── Component Padding ───────────────────────────────────

  /// Standard padding for cards and containers.
  static const double cardPadding = md; // 12.0

  /// Standard padding for buttons.
  static const double buttonPaddingHorizontal = lg; // 16.0
  static const double buttonPaddingVertical = md; // 12.0

  // ─── Gaps ────────────────────────────────────────────────

  /// Standard gap between items in a row or column.
  static const double gapSmall = sm; // 8.0
  static const double gapMedium = md; // 12.0
  static const double gapLarge = lg; // 16.0
  static const double gapXLarge = xl; // 20.0
}
