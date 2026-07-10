import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/market_index.dart';

/// A premium card widget for displaying a market index with sparkline chart.
///
/// This widget renders a market index (e.g., Nifty 50, Sensex, Bank Nifty)
/// in a visually appealing card format with:
/// - Index name and symbol
/// - Current value prominently displayed
/// - Change amount and percentage with semantic coloring
/// - Mini sparkline chart showing recent price movement
///
/// The widget automatically adapts to Light and Dark themes and uses
/// tabular figures to ensure numbers align perfectly.
///
/// Usage:
/// ```dart
/// MarketIndexCard(index: marketIndex)
/// ```
class MarketIndexCard extends StatelessWidget {
  /// The market index data to display.
  final MarketIndex index;

  /// Optional callback when the card is tapped.
  final VoidCallback? onTap;

  const MarketIndexCard({super.key, required this.index, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isPositive = index.isPositive;

    // Determine semantic colors based on market movement and theme
    final Color changeColor =
        isPositive
            ? (theme.brightness == Brightness.light
                ? AppColors.successLight
                : AppColors.successDark)
            : (theme.brightness == Brightness.light ? AppColors.errorLight : AppColors.errorDark);

    final String changePrefix = isPositive ? '+' : '';
    final String formattedValue = index.value.toStringAsFixed(2);
    final String formattedChange = '$changePrefix${index.change.toStringAsFixed(2)}';
    final String formattedPercent = '$changePrefix${index.changePercent.toStringAsFixed(2)}%';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.card,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: AppRadius.card,
            border: Border.all(color: theme.colorScheme.outlineVariant, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 1. Index Name & Symbol
              Text(
                index.name,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                index.symbol,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                ),
              ),

              const SizedBox(height: AppSpacing.sm), // Changed from md to sm
              // 2. Current Value
              Text(
                formattedValue,
                style: AppTypography.priceLarge.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontSize: 24,
                ),
              ),

              const SizedBox(height: AppSpacing.sm),

              // 3. Change & Percentage
              Row(
                children: [
                  Icon(
                    isPositive ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                    size: 16,
                    color: changeColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    formattedChange,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: changeColor,
                      fontWeight: FontWeight.w600,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '($formattedPercent)',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: changeColor,
                      fontWeight: FontWeight.w600,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),

              // 4. Sparkline Chart (if data available)
              if (index.sparklineData != null && index.sparklineData!.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.sm), // Changed from md to sm
                SizedBox(height: 40, child: _buildSparklineChart(theme, changeColor)),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the sparkline mini-chart using fl_chart.
  Widget _buildSparklineChart(ThemeData theme, Color lineColor) {
    final List<FlSpot> spots = [];
    final data = index.sparklineData!;
    final double minY = data.reduce((a, b) => a < b ? a : b);
    final double maxY = data.reduce((a, b) => a > b ? a : b);

    for (int i = 0; i < data.length; i++) {
      spots.add(FlSpot(i.toDouble(), data[i]));
    }

    return LineChart(
      LineChartData(
        minY: minY - (maxY - minY) * 0.1,
        maxY: maxY + (maxY - minY) * 0.1,
        minX: 0,
        maxX: (data.length - 1).toDouble(),
        clipData: const FlClipData.all(),
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            curveSmoothness: 0.3,
            color: lineColor,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(show: true, color: lineColor.withOpacity(0.1)),
          ),
        ],
        lineTouchData: const LineTouchData(enabled: false),
      ),
    );
  }
}
