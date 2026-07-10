import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/stock_tile.dart';
import '../../domain/entities/stock.dart';

/// A horizontal scrollable section for displaying a list of stocks.
///
/// This widget renders a section with a title header and a horizontally
/// scrollable list of [StockTile] widgets. It is designed to display
/// "Top Gainers" and "Top Losers" on the Dashboard screen.
///
/// Features:
/// - Section header with title and optional "View All" action
/// - Horizontal scrolling with proper spacing between items
/// - Uses the premium [StockTile] widget for consistent stock display
/// - Responsive design that works on mobile and tablet
///
/// Usage:
/// ```dart
/// StockListSection(
///   title: 'Top Gainers',
///   stocks: topGainers,
///   onViewAll: () => context.go('/gainers'),
/// )
/// ```
class StockListSection extends StatelessWidget {
  /// The title of the section (e.g., "Top Gainers", "Top Losers").
  final String title;

  /// The list of stocks to display.
  final List<Stock> stocks;

  /// Optional callback when "View All" is tapped.
  /// If null, the "View All" button is hidden.
  final VoidCallback? onViewAll;

  /// Optional callback when a stock tile is tapped.
  final void Function(Stock stock)? onStockTap;

  const StockListSection({
    super.key,
    required this.title,
    required this.stocks,
    this.onViewAll,
    this.onStockTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              if (onViewAll != null)
                TextButton(
                  onPressed: onViewAll,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'View All',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),

        // 2. Horizontal Stock List
        SizedBox(
          height: 90, // Fixed height for consistent layout
          child:
              stocks.isEmpty
                  ? Center(
                    child: Text(
                      'No stocks available',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  )
                  : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    itemCount: stocks.length,
                    separatorBuilder: (context, index) => const SizedBox(width: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final stock = stocks[index];
                      return SizedBox(
                        width: 280, // Fixed width for each stock tile
                        child: StockTile(
                          symbol: stock.symbol,
                          companyName: stock.companyName,
                          currentPrice: stock.currentPrice,
                          change: stock.change,
                          changePercent: stock.changePercent,
                          onTap: onStockTap != null ? () => onStockTap!(stock) : null,
                        ),
                      );
                    },
                  ),
        ),
      ],
    );
  }
}
