import 'package:flutter/material.dart';

/// Defines the color palette for the StockPilot application.
///
/// Colors are divided into semantic categories (Primary, Surface, Text, etc.)
/// and environment-specific variants (Light and Dark) to support Material 3
/// theming and ensure a premium, accessible UI.
///
/// Financial context colors (Success/Error) are specifically tuned for
/// stock market data visualization (Green for profit, Red for loss).
class AppColors {
  const AppColors._();

  // ─── Brand & Core Colors ─────────────────────────────────
  static const Color primaryLight = Color(0xFF2563EB); // Blue 600 (Trust, Finance)
  static const Color primaryDark = Color(0xFF60A5FA); // Blue 400

  static const Color secondaryLight = Color(0xFF0D9488); // Teal 600
  static const Color secondaryDark = Color(0xFF2DD4BF); // Teal 400

  static const Color tertiaryLight = Color(0xFF7C3AED); // Violet 600
  static const Color tertiaryDark = Color(0xFFA78BFA); // Violet 400

  // ─── Semantic Colors (Financial Context) ─────────────────
  /// Used for positive stock movements, profits, and success states.
  static const Color successLight = Color(0xFF059669); // Green 600
  static const Color successDark = Color(0xFF34D399); // Green 400

  /// Used for negative stock movements, losses, and error states.
  static const Color errorLight = Color(0xFFDC2626); // Red 600
  static const Color errorDark = Color(0xFFF87171); // Red 400

  /// Used for warnings, pending states, and neutral alerts.
  static const Color warningLight = Color(0xFFF59E0B); // Amber 500
  static const Color warningDark = Color(0xFFFBBF24); // Amber 400

  // ─── Background & Surface ────────────────────────────────
  static const Color backgroundLight = Color(0xFFF8FAFC); // Slate 50
  static const Color backgroundDark = Color(0xFF0F172A); // Slate 900

  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E293B); // Slate 800

  static const Color surfaceVariantLight = Color(0xFFF1F5F9); // Slate 100
  static const Color surfaceVariantDark = Color(0xFF334155); // Slate 700

  // ─── Text Colors ─────────────────────────────────────────
  static const Color textPrimaryLight = Color(0xFF0F172A); // Slate 900
  static const Color textPrimaryDark = Color(0xFFF8FAFC); // Slate 50

  static const Color textSecondaryLight = Color(0xFF475569); // Slate 600
  static const Color textSecondaryDark = Color(0xFF94A3B8); // Slate 400

  static const Color textDisabledLight = Color(0xFF94A3B8); // Slate 400
  static const Color textDisabledDark = Color(0xFF475569); // Slate 600

  // ─── Borders, Dividers & Outlines ────────────────────────
  static const Color dividerLight = Color(0xFFE2E8F0); // Slate 200
  static const Color dividerDark = Color(0xFF334155); // Slate 700

  static const Color outlineLight = Color(0xFFCBD5E1); // Slate 300
  static const Color outlineDark = Color(0xFF475569); // Slate 600

  // ─── Overlays & Scrims ───────────────────────────────────
  static const Color scrimLight = Color(0x80000000); // 50% Black
  static const Color scrimDark = Color(0x80000000);

  // ─── Chart Specific Colors ───────────────────────────────
  static const Color chartGridLight = Color(0xFFE2E8F0);
  static const Color chartGridDark = Color(0xFF334155);

  static const Color chartTooltipLight = Color(0xFFFFFFFF);
  static const Color chartTooltipDark = Color(0xFF1E293B);

  // ─── Common Utility Colors ───────────────────────────────
  static const Color transparent = Colors.transparent;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
}
