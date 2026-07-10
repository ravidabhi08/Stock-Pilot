import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../watchlist/domain/entities/watchlist_item.dart';
import '../../../watchlist/presentation/controllers/watchlist_providers.dart';
import '../../domain/entities/search_result.dart';

/// A premium list tile for displaying a single stock search result.
///
/// It automatically checks if the stock is already in the user's watchlist
/// using Riverpod, and updates the button state instantly when added.
/// The entire tile is tappable to navigate to the stock details page.
class SearchTile extends ConsumerWidget {
  /// The search result data to display.
  final SearchResult result;

  const SearchTile({super.key, required this.result});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // Watch the watchlist status for this specific stock symbol
    final isInWatchlistAsync = ref.watch(isInWatchlistProvider(result.symbol));

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navigate to stock details when tapping the tile
            context.pushNamed('stock_detail', pathParameters: {'symbol': result.symbol});
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
            ),
            child: Row(
              children: [
                // 1. Leading: Stock Badge
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    result.symbol.length > 4 ? result.symbol.substring(0, 3) : result.symbol,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),

                // 2. Center: Company Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result.companyName,
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${result.symbol} • ${result.exchange}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),

                // 3. Trailing: Add/Added Button
                isInWatchlistAsync.when(
                  data: (isInWatchlist) => _buildButton(context, ref, isInWatchlist),
                  loading:
                      () => const SizedBox(
                        width: 80,
                        height: 36,
                        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                      ),
                  error: (_, __) => _buildButton(context, ref, false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the dynamic Add/Added button.
  Widget _buildButton(BuildContext context, WidgetRef ref, bool isInWatchlist) {
    final theme = Theme.of(context);

    if (isInWatchlist) {
      // State: Already Added
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 8),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_rounded, size: 16, color: theme.colorScheme.primary),
            const SizedBox(width: 4),
            Text(
              'Added',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    // State: Not Added
    return TextButton(
      onPressed: () {
        // Add to watchlist instantly
        ref
            .read(watchlistProvider.notifier)
            .addItem(
              WatchlistItem(
                symbol: result.symbol,
                companyName: result.companyName,
                addedAt: DateTime.now(),
              ),
            );
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        '+ Add',
        style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
