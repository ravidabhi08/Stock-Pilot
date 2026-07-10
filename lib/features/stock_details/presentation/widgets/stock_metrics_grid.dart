import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/stock_detail.dart';

/// A premium grid widget displaying fundamental stock metrics.
///
/// This widget renders key financial indicators (Market Cap, P/E Ratio,
/// 52-Week High/Low, Volume, etc.) in a clean, modern 2-column grid layout.
/// It is designed to be highly readable, using distinct typography for
/// labels and values, and automatically formats large numbers into
/// Indian numbering abbreviations (Cr, L, K) for better UX.
///
/// Usage:
/// ```dart
/// StockMetricsGrid(detail: stockDetail)
/// ```
class StockMetricsGrid extends StatelessWidget {
  /// The comprehensive stock detail data.
  final StockDetail detail;

  const StockMetricsGrid({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: Text(
            'Fundamentals',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),

        // Metrics Grid
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: AppSpacing.md,
          crossAxisSpacing: AppSpacing.md,
          childAspectRatio: 2.2, // Makes the cards wide and short
          children: [
            _MetricCard(
              label: 'Market Cap',
              value: _formatLargeCurrency(detail.marketCap),
              theme: theme,
            ),
            _MetricCard(label: 'P/E Ratio', value: detail.peRatio.toStringAsFixed(2), theme: theme),
            _MetricCard(label: 'P/B Ratio', value: detail.pbRatio.toStringAsFixed(2), theme: theme),
            _MetricCard(label: '52W High', value: _formatCurrency(detail.high52Week), theme: theme),
            _MetricCard(label: '52W Low', value: _formatCurrency(detail.low52Week), theme: theme),
            _MetricCard(label: 'Volume', value: _formatLargeNumber(detail.volume), theme: theme),
            _MetricCard(label: 'Day High', value: _formatCurrency(detail.dayHigh), theme: theme),
            _MetricCard(label: 'Day Low', value: _formatCurrency(detail.dayLow), theme: theme),
            _MetricCard(
              label: 'Prev. Close',
              value: _formatCurrency(detail.prevClose),
              theme: theme,
            ),
            _MetricCard(
              label: 'Open Price',
              value: _formatCurrency(detail.openPrice),
              theme: theme,
            ),
          ],
        ),
      ],
    );
  }

  /// Formats a standard currency value (e.g., ₹2,450.50).
  String _formatCurrency(double amount) {
    return '₹${amount.toStringAsFixed(2)}';
  }

  /// Formats large currency values into Indian abbreviations (Cr, L, K).
  String _formatLargeCurrency(double amount) {
    if (amount >= 10000000) {
      return '${(amount / 10000000).toStringAsFixed(2)} Cr';
    } else if (amount >= 100000) {
      return '₹${(amount / 100000).toStringAsFixed(2)} L';
    } else if (amount >= 1000) {
      return '₹${(amount / 1000).toStringAsFixed(2)} K';
    }
    return '₹${amount.toStringAsFixed(2)}';
  }

  /// Formats large non-currency numbers (like Volume) into abbreviations.
  String _formatLargeNumber(double amount) {
    if (amount >= 10000000) {
      return '${(amount / 10000000).toStringAsFixed(2)} Cr';
    } else if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(2)} L';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(2)} K';
    }
    return amount.toStringAsFixed(0);
  }
}

/// A private widget representing a single metric card in the grid.
class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final ThemeData theme;

  const _MetricCard({required this.label, required this.value, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: AppRadius.card,
        border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.5), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
