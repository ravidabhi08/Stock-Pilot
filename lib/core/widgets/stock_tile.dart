import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// A premium, specialized list tile for displaying stock market data.
///
/// Designed to be used in lists such as Watchlists, Search Results,
/// and Portfolio Holdings. It displays the stock symbol, company name,
/// current price, and the daily change (amount and percentage) with
/// appropriate semantic coloring (Green for profit, Red for loss).
///
/// The widget automatically adapts to Light and Dark themes and uses
/// tabular figures to ensure numbers align perfectly in lists.
class StockTile extends StatelessWidget {
  /// The stock ticker symbol (e.g., 'RELIANCE', 'TCS').
  final String symbol;

  /// The full name of the company (e.g., 'Reliance Industries Ltd.').
  final String companyName;

  /// The current market price of the stock.
  final double currentPrice;

  /// The absolute change in price (e.g., 45.50 or -12.30).
  final double change;

  /// The percentage change (e.g., 1.25 or -0.85).
  final double changePercent;

  /// Optional callback when the tile is tapped.
  final VoidCallback? onTap;

  const StockTile({
    super.key,
    required this.symbol,
    required this.companyName,
    required this.currentPrice,
    required this.change,
    required this.changePercent,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isPositive = change >= 0;

    // Determine semantic colors based on market movement and theme
    final Color changeColor =
        isPositive
            ? (theme.brightness == Brightness.light
                ? AppColors.successLight
                : AppColors.successDark)
            : (theme.brightness == Brightness.light ? AppColors.errorLight : AppColors.errorDark);

    final String changePrefix = isPositive ? '+' : '';
    final String formattedPrice = currentPrice.toStringAsFixed(2);
    final String formattedChange = '$changePrefix${change.toStringAsFixed(2)}';
    final String formattedPercent = '$changePrefix${changePercent.toStringAsFixed(2)}%';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.card,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
          child: Row(
            children: [
              // 1. Leading: Symbol Badge
              _buildSymbolBadge(theme),
              const SizedBox(width: AppSpacing.md),

              // 2. Center: Company Name & Symbol
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      companyName,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      symbol,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              // 3. Trailing: Price & Change
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹$formattedPrice',
                    style: AppTypography.priceMedium.copyWith(color: theme.colorScheme.onSurface),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$formattedChange ($formattedPercent)',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: changeColor,
                      fontWeight: FontWeight.w600,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the circular badge displaying the stock symbol.
  Widget _buildSymbolBadge(ThemeData theme) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: AppRadius.chip,
      ),
      alignment: Alignment.center,
      child: Text(
        symbol.length > 4 ? symbol.substring(0, 3) : symbol,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
