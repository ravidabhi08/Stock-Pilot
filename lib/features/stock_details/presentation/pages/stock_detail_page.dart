import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart'; // Added for context.pop()

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../watchlist/domain/entities/watchlist_item.dart';
import '../../../watchlist/presentation/controllers/watchlist_providers.dart';
import '../../domain/entities/stock_detail.dart';
import '../controllers/stock_detail_providers.dart';
import '../widgets/stock_action_buttons.dart';
import '../widgets/stock_metrics_grid.dart';
import '../widgets/stock_price_header.dart';

/// The main Stock Details screen displaying comprehensive stock information.
class StockDetailPage extends ConsumerWidget {
  final String symbol;

  const StockDetailPage({super.key, required this.symbol});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final detailAsync = ref.watch(stockDetailProvider(symbol));
    final isInWatchlistAsync = ref.watch(isInWatchlistProvider(symbol));

    return Scaffold(
      // 1. Fixed Premium AppBar
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface, // Seamless background
        elevation: 0,
        scrolledUnderElevation: 0, // No shadow on scroll
        centerTitle: false,
        titleTextStyle: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(), // FIXED: Use GoRouter pop instead of Navigator
        ),
        actions: [
          // Watchlist Toggle Button
          IconButton(
            icon: isInWatchlistAsync.when(
              data:
                  (isInWatchlist) => Icon(
                    isInWatchlist ? Icons.star_rounded : Icons.star_outline_rounded,
                    color: isInWatchlist ? Colors.amber : theme.colorScheme.onSurfaceVariant,
                  ),
              loading:
                  () => const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              error: (_, __) => const Icon(Icons.star_outline_rounded),
            ),
            onPressed: () => _toggleWatchlist(ref, isInWatchlistAsync.value ?? false),
          ),
          IconButton(
            icon: const Icon(Icons.share_rounded),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Share feature coming soon!')));
            },
          ),
        ],
      ),

      // Removed extendBodyBehindAppBar: true so content doesn't hide behind status bar

      // 2. Main Content
      body: detailAsync.when(
        loading: () => const AppLoader(message: 'Loading stock details...'),
        error:
            (error, stackTrace) => AppErrorWidget(
              title: 'Failed to Load Stock',
              message: 'Could not fetch details for $symbol. Please try again.',
              icon: Icons.error_outline_rounded,
              onRetry: () => ref.invalidate(stockDetailProvider(symbol)),
            ),
        data:
            (detail) => RefreshIndicator(
              onRefresh: () async {
                final refresh = ref.read(stockDetailRefreshProvider(symbol));
                await refresh();
              },
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  // Removed the 60px spacer since the AppBar is no longer transparent

                  // Hero Section: Price & Chart
                  SliverToBoxAdapter(child: StockPriceHeader(detail: detail)),

                  const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),

                  // Company Info Section
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    sliver: SliverToBoxAdapter(child: _buildCompanyInfo(context, detail)),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),

                  // Fundamentals Grid
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    sliver: SliverToBoxAdapter(child: StockMetricsGrid(detail: detail)),
                  ),

                  // Bottom padding for action buttons
                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              ),
            ),
      ),

      // 3. Persistent Action Buttons
      bottomSheet: StockActionButtons(
        onBuy: () => _showTradeSheet(context, 'Buy', detailAsync.value),
        onSell: () => _showTradeSheet(context, 'Sell', detailAsync.value),
      ),
    );
  }

  /// Builds the company information section.
  Widget _buildCompanyInfo(BuildContext context, StockDetail detail) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          detail.companyName,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
            _buildTag(context, detail.sector),
            const SizedBox(width: AppSpacing.sm),
            _buildTag(context, detail.industry),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          detail.description,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  /// Builds a small pill-shaped tag for Sector/Industry.
  Widget _buildTag(BuildContext context, String text) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// Toggles the stock's presence in the watchlist.
  void _toggleWatchlist(WidgetRef ref, bool isInWatchlist) {
    final notifier = ref.read(watchlistProvider.notifier);
    final detail = ref.read(stockDetailProvider(symbol)).value;
    final companyName = detail?.companyName ?? symbol;

    if (isInWatchlist) {
      notifier.removeItem(symbol);
    } else {
      notifier.addItem(
        WatchlistItem(symbol: symbol, companyName: companyName, addedAt: DateTime.now()),
      );
    }
  }

  /// Shows a placeholder bottom sheet for Buy/Sell actions.
  void _showTradeSheet(BuildContext context, String action, StockDetail? detail) {
    if (detail == null) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            MediaQuery.of(ctx).viewInsets.bottom + AppSpacing.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                '$action ${detail.symbol}',
                style: Theme.of(ctx).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Current Price: ₹${detail.currentPrice.toStringAsFixed(2)}',
                style: Theme.of(ctx).textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSpacing.xl),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: () {
                    context.pop(); // Close the bottom sheet
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Order placed for $action ${detail.symbol}')),
                    );
                  },
                  child: Text('Confirm $action'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
