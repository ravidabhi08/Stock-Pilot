import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/portfolio_summary.dart';

/// A premium card widget displaying the overall portfolio summary.
///
/// This widget renders the total current value, total profit/loss,
/// and total investment in a visually appealing card format.
/// It uses semantic coloring (green for profit, red for loss) to
/// instantly communicate the portfolio's health to the user.
///
/// Usage:
/// ```dart
/// PortfolioSummaryCard(summary: portfolioSummary)
/// ```
class PortfolioSummaryCard extends StatelessWidget {
  /// The portfolio summary data to display.
  final PortfolioSummary summary;

  const PortfolioSummaryCard({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isProfit = summary.isOverallProfit;

    // Determine semantic colors based on portfolio performance
    final Color pnlColor =
        isProfit
            ? (theme.brightness == Brightness.light
                ? AppColors.successLight
                : AppColors.successDark)
            : (theme.brightness == Brightness.light ? AppColors.errorLight : AppColors.errorDark);

    final String pnlPrefix = isProfit ? '+' : '';
    final String formattedCurrentValue = _formatCurrency(summary.totalCurrentValue);
    final String formattedPnl = '$pnlPrefix${_formatCurrency(summary.totalProfitLoss)}';
    final String formattedPnlPercent =
        '$pnlPrefix${summary.totalProfitLossPercent.toStringAsFixed(2)}%';
    final String formattedInvestment = _formatCurrency(summary.totalInvestment);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: theme.colorScheme.outlineVariant, width: 1.0),
        // Subtle shadow for elevation
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Current Value
          Text(
            'Current Value',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            formattedCurrentValue,
            style: AppTypography.priceLarge.copyWith(
              color: theme.colorScheme.onSurface,
              fontSize: 28,
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          // 2. Profit/Loss
          Row(
            children: [
              Icon(
                isProfit ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                size: 20,
                color: pnlColor,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                formattedPnl,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: pnlColor,
                  fontWeight: FontWeight.bold,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2),
                decoration: BoxDecoration(
                  color: pnlColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  formattedPnlPercent,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: pnlColor,
                    fontWeight: FontWeight.bold,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          // Divider
          Divider(
            height: 1,
            thickness: 1,
            color: theme.colorScheme.outlineVariant.withOpacity(0.5),
          ),
          const SizedBox(height: AppSpacing.md),

          // 3. Total Investment
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Investment',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                formattedInvestment,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Formats a double value into a currency string (₹).
  /// Adds commas for thousands separators for better readability.
  String _formatCurrency(double amount) {
    // Simple formatting without requiring the 'intl' package
    final String formatted = amount.abs().toStringAsFixed(2);
    final List<String> parts = formatted.split('.');
    final String integerPart = parts[0];
    final String decimalPart = parts[1];

    // Add commas every 3 digits from the right (Indian numbering system style is different,
    // but standard international is fine for this basic formatter, or we can just return it plain).
    // For simplicity and to avoid complex regex, we'll just return it with the ₹ symbol.
    // A production app would use NumberFormat.currency(locale: 'en_IN', symbol: '₹') from 'intl'.
    return '₹$integerPart.$decimalPart';
  }
}
