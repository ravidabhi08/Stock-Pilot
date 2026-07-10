import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
///
/// This page is the destination when a user taps on a stock from the Dashboard,
/// Portfolio, or Watchlist. It features:
/// - An interactive price chart header.
/// - Company information and description.
/// - A grid of fundamental metrics (P/E, Market Cap, etc.).
/// - Persistent Buy/Sell action buttons at the bottom.
/// - A toggleable "Star" icon to add/remove the stock from the Watchlist.
class StockDetailPage extends ConsumerWidget {
  /// The stock ticker symbol to load details for.
  final String symbol;

  const StockDetailPage({super.key, required this.symbol});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // Watch the stock detail data for the specific symbol
    final detailAsync = ref.watch(stockDetailProvider(symbol));

    // Watch the watchlist status to toggle the star icon
    final isInWatchlistAsync = ref.watch(isInWatchlistProvider(symbol));

    return Scaffold(
      // 1. App Bar with Watchlist Toggle
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          // Watchlist Toggle Button
          IconButton(
            icon: isInWatchlistAsync.when(
              data:
                  (isInWatchlist) => Icon(
                    isInWatchlist ? Icons.star_rounded : Icons.star_outline_rounded,
                    color: isInWatchlist ? Colors.amber : theme.colorScheme.onSurface,
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
      extendBodyBehindAppBar: true, // Allows chart to go behind the app bar
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
                  // Spacer for the transparent app bar
                  const SliverToBoxAdapter(child: SizedBox(height: 60)),

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

                  // Bottom padding to prevent content from hiding behind action buttons
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

    // We need the company name. In a real app, this comes from the detail entity.
    // For now, we'll just use the symbol as a placeholder name if needed.
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
                    Navigator.pop(ctx);
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
