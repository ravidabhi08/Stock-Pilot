import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/holding.dart';

/// A premium list tile for displaying an individual stock holding.
///
/// Designed specifically for the Portfolio screen, this widget displays
/// the stock's company name, symbol, quantity, average buy price, current
/// market price, and the profit/loss (both absolute and percentage).
///
/// It uses semantic coloring (green for profit, red for loss) to instantly
/// communicate the performance of the holding.
///
/// Usage:
/// ```dart
/// HoldingTile(holding: myHolding)
/// ```
class HoldingTile extends StatelessWidget {
  /// The holding data to display.
  final Holding holding;

  /// Optional callback when the tile is tapped.
  final VoidCallback? onTap;

  const HoldingTile({super.key, required this.holding, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isProfit = holding.isProfit;

    // Determine semantic colors based on performance and theme
    final Color pnlColor =
        isProfit
            ? (theme.brightness == Brightness.light
                ? AppColors.successLight
                : AppColors.successDark)
            : (theme.brightness == Brightness.light ? AppColors.errorLight : AppColors.errorDark);

    final String pnlPrefix = isProfit ? '+' : '';
    final String formattedCurrentPrice = _formatCurrency(holding.currentPrice);
    final String formattedPnl = '$pnlPrefix${_formatCurrency(holding.profitLoss)}';
    final String formattedPnlPercent = '$pnlPrefix${holding.profitLossPercent.toStringAsFixed(2)}%';
    final String formattedAvgPrice = _formatCurrency(holding.avgBuyPrice);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.card,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: AppRadius.card,
            border: Border.all(color: theme.colorScheme.outlineVariant, width: 1.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Leading: Stock Info (Name, Symbol, Qty, Avg Price)
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      holding.companyName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            holding.symbol,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          'Qty: ${holding.quantity.toStringAsFixed(0)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Avg: $formattedAvgPrice',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Trailing: Current Price & P&L
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formattedCurrentPrice,
                      style: AppTypography.priceMedium.copyWith(color: theme.colorScheme.onSurface),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          formattedPnl,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: pnlColor,
                            fontWeight: FontWeight.w600,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '($formattedPnlPercent)',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: pnlColor,
                            fontWeight: FontWeight.w600,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Formats a double value into a currency string (₹).
  String _formatCurrency(double amount) {
    final String formatted = amount.abs().toStringAsFixed(2);
    return '$formatted';
  }
}
