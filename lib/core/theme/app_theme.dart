import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// Central theme configuration for StockPilot.
///
/// Stitches together [AppColors], [AppTypography], [AppSpacing], and [AppRadius]
/// into cohesive Material 3 [ThemeData] for both Light and Dark modes.
/// Designed to deliver a premium, clean fintech aesthetic similar to
/// Groww and Zerodha Kite.
class AppTheme {
  const AppTheme._();

  /// The application's light theme.
  static ThemeData get lightTheme => _buildTheme(Brightness.light);

  /// The application's dark theme.
  static ThemeData get darkTheme => _buildTheme(Brightness.dark);

  /// Builds the core [ThemeData] based on the given [brightness].
  static ThemeData _buildTheme(Brightness brightness) {
    final bool isLight = brightness == Brightness.light;

    // 1. Construct the Material 3 ColorScheme
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: isLight ? AppColors.primaryLight : AppColors.primaryDark,
      brightness: brightness,
      primary: isLight ? AppColors.primaryLight : AppColors.primaryDark,
      secondary: isLight ? AppColors.secondaryLight : AppColors.secondaryDark,
      tertiary: isLight ? AppColors.tertiaryLight : AppColors.tertiaryDark,
      error: isLight ? AppColors.errorLight : AppColors.errorDark,
      surface: isLight ? AppColors.surfaceLight : AppColors.surfaceDark,
    ).copyWith(
      surface: isLight ? AppColors.backgroundLight : AppColors.backgroundDark,
      onSurface: isLight ? AppColors.textPrimaryLight : AppColors.textPrimaryDark,
      surfaceContainerHighest:
          isLight ? AppColors.surfaceVariantLight : AppColors.surfaceVariantDark,
      onSurfaceVariant: isLight ? AppColors.textSecondaryLight : AppColors.textSecondaryDark,
      outline: isLight ? AppColors.outlineLight : AppColors.outlineDark,
      outlineVariant: isLight ? AppColors.dividerLight : AppColors.dividerDark,
    );

    // 2. Assemble ThemeData
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: _buildTextTheme(colorScheme),

      // --- Component Themes ---
      appBarTheme: _buildAppBarTheme(colorScheme),
      cardTheme: _buildCardTheme(colorScheme),
      elevatedButtonTheme: _buildElevatedButtonTheme(colorScheme),
      inputDecorationTheme: _buildInputDecorationTheme(colorScheme),
      navigationBarTheme: _buildNavigationBarTheme(colorScheme),
      dividerTheme: DividerThemeData(color: colorScheme.outlineVariant, thickness: 1.0, space: 0.0),
    );
  }

  // ─── Text Theme ──────────────────────────────────────────

  static TextTheme _buildTextTheme(ColorScheme colorScheme) {
    final Color primaryText = colorScheme.onSurface;
    final Color secondaryText = colorScheme.onSurfaceVariant;

    return TextTheme(
      displayLarge: AppTypography.displayLarge.copyWith(color: primaryText),
      displayMedium: AppTypography.displayMedium.copyWith(color: primaryText),
      displaySmall: AppTypography.displaySmall.copyWith(color: primaryText),
      headlineLarge: AppTypography.headlineLarge.copyWith(color: primaryText),
      headlineMedium: AppTypography.headlineMedium.copyWith(color: primaryText),
      headlineSmall: AppTypography.headlineSmall.copyWith(color: primaryText),
      titleLarge: AppTypography.titleLarge.copyWith(color: primaryText),
      titleMedium: AppTypography.titleMedium.copyWith(color: primaryText),
      titleSmall: AppTypography.titleSmall.copyWith(color: secondaryText),
      bodyLarge: AppTypography.bodyLarge.copyWith(color: primaryText),
      bodyMedium: AppTypography.bodyMedium.copyWith(color: secondaryText),
      bodySmall: AppTypography.bodySmall.copyWith(color: secondaryText),
      labelLarge: AppTypography.labelLarge.copyWith(color: primaryText),
      labelMedium: AppTypography.labelMedium.copyWith(color: secondaryText),
      labelSmall: AppTypography.labelSmall.copyWith(color: secondaryText),
    );
  }

  // ─── Component Themes ────────────────────────────────────

  static AppBarTheme _buildAppBarTheme(ColorScheme colorScheme) {
    return AppBarTheme(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      elevation: 0,
      scrolledUnderElevation: 1.0,
      centerTitle: true,
      titleTextStyle: AppTypography.titleLarge.copyWith(color: colorScheme.onSurface),
    );
  }

  static CardTheme _buildCardTheme(ColorScheme colorScheme) {
    return CardTheme(
      color: colorScheme.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.card,
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.buttonPaddingHorizontal,
          vertical: AppSpacing.buttonPaddingVertical,
        ),
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.button),
        textStyle: AppTypography.labelLarge,
      ),
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme(ColorScheme colorScheme) {
    return InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surfaceContainerHighest,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      border: const OutlineInputBorder(
        borderRadius: AppRadius.textField,
        borderSide: BorderSide.none,
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: AppRadius.textField,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.textField,
        borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
      ),
      hintStyle: AppTypography.bodyMedium.copyWith(
        color: colorScheme.onSurfaceVariant.withOpacity(0.6),
      ),
    );
  }

  static NavigationBarThemeData _buildNavigationBarTheme(ColorScheme colorScheme) {
    return NavigationBarThemeData(
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surface,
      elevation: 0,
      indicatorColor: colorScheme.primaryContainer,
      labelTextStyle: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return AppTypography.labelSmall.copyWith(color: colorScheme.onSurface);
        }
        return AppTypography.labelSmall.copyWith(color: colorScheme.onSurfaceVariant);
      }),
      iconTheme: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: colorScheme.primary);
        }
        return IconThemeData(color: colorScheme.onSurfaceVariant);
      }),
    );
  }
}
