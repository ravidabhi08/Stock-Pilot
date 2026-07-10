import 'package:flutter/material.dart';

/// Defines the border radius scale for the StockPilot application.
///
/// Provides both a raw numerical scale and semantic border radius
/// constants to ensure consistent rounding across all UI components,
/// aligning with Material 3 design principles.
class AppRadius {
  const AppRadius._();

  // ─── Raw Scale ───────────────────────────────────────────

  /// 4.0 logical pixels. Used for very subtle rounding.
  static const double xs = 4.0;

  /// 8.0 logical pixels. Standard small rounding (e.g., buttons, inputs).
  static const double sm = 8.0;

  /// 12.0 logical pixels. Standard medium rounding (e.g., cards).
  static const double md = 12.0;

  /// 16.0 logical pixels. Large rounding (e.g., dialogs, modals).
  static const double lg = 16.0;

  /// 24.0 logical pixels. Extra large rounding (e.g., bottom sheets).
  static const double xl = 24.0;

  /// 100.0 logical pixels. Used for fully rounded elements (pills, chips).
  static const double pill = 100.0;

  // ─── Semantic Border Radii ───────────────────────────────

  /// Standard border radius for buttons.
  static const BorderRadius button = BorderRadius.all(Radius.circular(sm));

  /// Standard border radius for cards and containers.
  static const BorderRadius card = BorderRadius.all(Radius.circular(md));

  /// Standard border radius for dialogs and alerts.
  static const BorderRadius dialog = BorderRadius.all(Radius.circular(lg));

  /// Standard border radius for text fields and search bars.
  static const BorderRadius textField = BorderRadius.all(Radius.circular(sm));

  /// Fully rounded border radius for chips, tags, and pill buttons.
  static const BorderRadius chip = BorderRadius.all(Radius.circular(pill));

  /// Top-rounded border radius for bottom sheets and modal bottom bars.
  static const BorderRadius bottomSheet = BorderRadius.only(
    topLeft: Radius.circular(xl),
    topRight: Radius.circular(xl),
  );

  /// Top-rounded border radius for navigation bars.
  static const BorderRadius navigationBar = BorderRadius.only(
    topLeft: Radius.circular(lg),
    topRight: Radius.circular(lg),
  );
}
