import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

/// A premium widget displaying the primary Buy and Sell action buttons.
///
/// This widget is typically placed at the bottom of the Stock Details screen
/// inside a [SafeArea]. It features two large, distinct buttons with semantic
/// coloring (Green for Buy, Red for Sell) and icons, mimicking the UX of
/// top-tier Indian trading apps like Zerodha Kite and Groww.
///
/// Usage:
/// ```dart
/// StockActionButtons(
///   onBuy: () => print('Buy tapped'),
///   onSell: () => print('Sell tapped'),
/// )
/// ```
class StockActionButtons extends StatelessWidget {
  /// Callback when the Buy button is tapped.
  final VoidCallback onBuy;

  /// Callback when the Sell button is tapped.
  final VoidCallback onSell;

  const StockActionButtons({super.key, required this.onBuy, required this.onSell});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLightTheme = theme.brightness == Brightness.light;

    // Determine semantic colors for the buttons
    final Color buyColor = isLightTheme ? AppColors.successLight : AppColors.successDark;
    final Color sellColor = isLightTheme ? AppColors.errorLight : AppColors.errorDark;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.md),
        child: Row(
          children: [
            // 1. Buy Button
            Expanded(
              child: _ActionButton(
                label: 'Buy',
                icon: Icons.add_shopping_cart_rounded,
                backgroundColor: buyColor,
                textColor: Colors.white,
                onPressed: onBuy,
              ),
            ),
            const SizedBox(width: AppSpacing.md),

            // 2. Sell Button
            Expanded(
              child: _ActionButton(
                label: 'Sell',
                icon: Icons.sell_rounded,
                backgroundColor: sellColor,
                textColor: Colors.white,
                onPressed: onSell,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A private, reusable styled button for the action bar.
class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52, // Standard premium touch target height
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 20, color: textColor),
        label: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.button),
          elevation: 2, // Subtle shadow for depth
        ),
      ),
    );
  }
}
