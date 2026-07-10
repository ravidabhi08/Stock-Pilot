import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/app_loader.dart';
import '../controllers/dashboard_providers.dart';
import '../widgets/market_index_card.dart';
import '../widgets/stock_list_section.dart';

/// The main Dashboard screen displaying market overview.
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final overviewAsync = ref.watch(marketOverviewProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Market Overview'), elevation: 0),
      body: overviewAsync.when(
        loading: () => const AppLoader(message: 'Loading market data...'),
        error:
            (error, stackTrace) => AppErrorWidget(
              title: 'Failed to Load Market Data',
              message: 'Please check your internet connection and try again.',
              icon: Icons.cloud_off_rounded,
              onRetry: () => ref.invalidate(marketOverviewProvider),
            ),
        data:
            (overview) => RefreshIndicator(
              onRefresh: () async {
                final refresh = ref.read(marketOverviewRefreshProvider);
                await refresh();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Market Indices Section
                    _buildIndicesSection(context, overview.indices),

                    const SizedBox(height: AppSpacing.xl),

                    // 2. Top Gainers Section
                    StockListSection(
                      title: 'Top Gainers',
                      stocks: overview.topGainers,
                      onViewAll: () {
                        // TODO: Navigate to full gainers list
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(const SnackBar(content: Text('View All Gainers')));
                      },
                      onStockTap: (stock) {
                        // Navigate to stock details
                        context.goNamed('stock_detail', pathParameters: {'symbol': stock.symbol});
                      },
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // 3. Top Losers Section
                    StockListSection(
                      title: 'Top Losers',
                      stocks: overview.topLosers,
                      onViewAll: () {
                        // TODO: Navigate to full losers list
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(const SnackBar(content: Text('View All Losers')));
                      },
                      onStockTap: (stock) {
                        // Navigate to stock details
                        context.goNamed('stock_detail', pathParameters: {'symbol': stock.symbol});
                      },
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    // 4. Last Updated Timestamp
                    if (overview.lastUpdated != null)
                      Center(
                        child: Text(
                          'Last updated: ${_formatTimestamp(overview.lastUpdated!)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
      ),
    );
  }

  /// Builds the market indices section with responsive layout.
  Widget _buildIndicesSection(BuildContext context, List<dynamic> indices) {
    final isMobile = context.isMobile;

    if (isMobile) {
      return SizedBox(
        height: 200,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          itemCount: indices.length,
          separatorBuilder: (context, index) => const SizedBox(width: AppSpacing.md),
          itemBuilder: (context, index) {
            return SizedBox(width: 200, child: MarketIndexCard(index: indices[index]));
          },
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: context.isTablet ? 2 : 3,
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: 1.2,
          ),
          itemCount: indices.length,
          itemBuilder: (context, index) {
            return MarketIndexCard(index: indices[index]);
          },
        ),
      );
    }
  }

  /// Formats the timestamp for display.
  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hr ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}
