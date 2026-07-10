import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/app_loader.dart';
import '../controllers/portfolio_providers.dart';
import '../widgets/holding_tile.dart';
import '../widgets/portfolio_summary_card.dart';

/// The main Portfolio screen displaying the user's holdings and summary.
class PortfolioPage extends ConsumerWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final summaryAsync = ref.watch(portfolioSummaryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Portfolio'), elevation: 0),
      body: summaryAsync.when(
        loading: () => const AppLoader(message: 'Loading portfolio...'),
        error:
            (error, stackTrace) => AppErrorWidget(
              title: 'Failed to Load Portfolio',
              message: 'Please check your internet connection and try again.',
              icon: Icons.cloud_off_rounded,
              onRetry: () => ref.invalidate(portfolioSummaryProvider),
            ),
        data:
            (summary) => RefreshIndicator(
              onRefresh: () async {
                final refresh = ref.read(portfolioRefreshProvider);
                await refresh();
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.lg,
                ),
                children: [
                  // 1. Portfolio Summary Card
                  PortfolioSummaryCard(summary: summary),

                  const SizedBox(height: AppSpacing.xl),

                  // 2. Holdings Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Holdings (${summary.holdingsCount})',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // 3. Holdings List
                  if (summary.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
                        child: Text(
                          'No holdings found. Start investing to see them here!',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: summary.holdings.length,
                      separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
                      itemBuilder: (context, index) {
                        final holding = summary.holdings[index];
                        return HoldingTile(
                          holding: holding,
                          onTap: () {
                            // Navigate to stock details
                            context.goNamed(
                              'stock_detail',
                              pathParameters: {'symbol': holding.symbol},
                            );
                          },
                        );
                      },
                    ),

                  const SizedBox(height: AppSpacing.xxl),

                  // 4. Last Updated Timestamp
                  if (summary.lastUpdated != null)
                    Center(
                      child: Text(
                        'Last updated: ${_formatTimestamp(summary.lastUpdated!)}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                ],
              ),
            ),
      ),
    );
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
