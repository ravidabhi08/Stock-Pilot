import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../domain/entities/watchlist_item.dart';
import '../controllers/watchlist_providers.dart';
import '../widgets/watchlist_filter_sheet.dart';

/// The main Watchlist screen displaying the user's tracked stocks.
class WatchlistPage extends ConsumerWidget {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final watchlistAsync = ref.watch(watchlistProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface,
        ),
        actions: [
          // Filter/Sort Icon
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            tooltip: 'Filter & Sort',
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                builder: (context) => const WatchlistFilterSheet(),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed('search'); // FIXED
        },
        child: const Icon(Icons.add_rounded),
      ),
      body: watchlistAsync.when(
        loading: () => const AppLoader(message: 'Loading watchlist...'),
        error:
            (error, stackTrace) => AppErrorWidget(
              title: 'Failed to Load Watchlist',
              message: 'Please check your internet connection and try again.',
              icon: Icons.cloud_off_rounded,
              onRetry: () => ref.read(watchlistProvider.notifier).refresh(),
            ),
        data: (items) {
          if (items.isEmpty) {
            return AppEmptyState(
              title: 'Your watchlist is empty',
              message: 'Add stocks to track their performance in real-time.',
              icon: Icons.star_outline_rounded,
              actionLabel: 'Add Stocks',
              onAction: () => _showAddStockPlaceholder(context),
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.read(watchlistProvider.notifier).refresh(),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return _buildWatchlistTile(context, ref, item);
              },
            ),
          );
        },
      ),
    );
  }

  /// Builds an individual watchlist tile with swipe-to-delete functionality.
  Widget _buildWatchlistTile(BuildContext context, WidgetRef ref, WatchlistItem item) {
    final theme = Theme.of(context);

    return Dismissible(
      key: Key(item.symbol),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSpacing.lg),
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        decoration: BoxDecoration(
          color: theme.colorScheme.error,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Icon(Icons.delete_outline_rounded, color: theme.colorScheme.onError),
      ),
      confirmDismiss: (direction) async {
        return true;
      },
      onDismissed: (direction) {
        ref.read(watchlistProvider.notifier).removeItem(item.symbol);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.symbol} removed from watchlist'),
            duration: const Duration(seconds: 2),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                ref.read(watchlistProvider.notifier).addItem(item);
              },
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // FIXED: Changed goNamed to pushNamed
              context.pushNamed('stock_detail', pathParameters: {'symbol': item.symbol});
            },
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: theme.colorScheme.outlineVariant, width: 1.0),
              ),
              child: Row(
                children: [
                  // 1. Leading: Stock Badge
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      item.symbol.length > 4 ? item.symbol.substring(0, 3) : item.symbol,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),

                  // 2. Center: Company Name & Symbol
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.companyName,
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.symbol,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 3. Trailing: Added Date & Icon
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(Icons.star_rounded, size: 20, color: theme.colorScheme.primary),
                      const SizedBox(height: 4),
                      Text(
                        'Added ${_formatDate(item.addedAt)}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Formats the date for display.
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) return 'Today';
    if (difference.inDays == 1) return 'Yesterday';
    if (difference.inDays < 7) return '${difference.inDays} days ago';

    return '${date.day} ${_getMonthName(date.month)}';
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  /// Temporary placeholder for the Add Stock functionality.
  void _showAddStockPlaceholder(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Stock Search & Add feature coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
