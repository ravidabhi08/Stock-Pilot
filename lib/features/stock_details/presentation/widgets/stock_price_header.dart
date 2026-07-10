// ignore_for_file: deprecated_member_use

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/stock_detail.dart';

/// A premium widget displaying the stock's price header and interactive chart.
///
/// This is the hero section of the Stock Details screen. It features:
/// - Large, prominent current price with semantic coloring (green/red)
/// - Absolute and percentage change indicators
/// - Interactive time-period selector (1D, 1W, 1M, 3M, 1Y, 5Y)
/// - Full-width interactive price chart with touch crosshair and tooltip
///
/// The chart uses [fl_chart] to render a smooth, curved area chart with
/// a gradient fill. Touch interactions display a vertical crosshair and
/// a floating tooltip showing the exact price and date for that point.
///
/// Usage:
/// ```dart
/// StockPriceHeader(detail: stockDetail)
/// ```
class StockPriceHeader extends StatefulWidget {
  /// The comprehensive stock detail data.
  final StockDetail detail;

  const StockPriceHeader({super.key, required this.detail});

  @override
  State<StockPriceHeader> createState() => _StockPriceHeaderState();
}

class _StockPriceHeaderState extends State<StockPriceHeader> {
  /// Currently selected time period for the chart.
  String _selectedPeriod = '1D';

  /// Index of the currently touched spot on the chart.
  int? _touchedIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isPositive = widget.detail.isPositive;

    // Semantic colors based on price movement
    final Color priceColor =
        isPositive
            ? (theme.brightness == Brightness.light
                ? AppColors.successLight
                : AppColors.successDark)
            : (theme.brightness == Brightness.light ? AppColors.errorLight : AppColors.errorDark);

    final String changePrefix = isPositive ? '+' : '';
    final String formattedPrice = '₹${widget.detail.currentPrice.toStringAsFixed(2)}';
    final String formattedChange = '$changePrefix${widget.detail.change.toStringAsFixed(2)}';
    final String formattedPercent =
        '($changePrefix${widget.detail.changePercent.toStringAsFixed(2)}%)';

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Current Price & Change
          Text(
            formattedPrice,
            style: AppTypography.priceLarge.copyWith(
              color: theme.colorScheme.onSurface,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Icon(
                isPositive ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                size: 18,
                color: priceColor,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                '$formattedChange $formattedPercent',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: priceColor,
                  fontWeight: FontWeight.bold,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Today',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          // 2. Time Period Selector
          _buildPeriodSelector(theme),

          const SizedBox(height: AppSpacing.md),

          // 3. Interactive Price Chart
          SizedBox(height: 220, child: _buildPriceChart(theme, priceColor)),
        ],
      ),
    );
  }

  /// Builds the time-period selector (segmented control).
  Widget _buildPeriodSelector(ThemeData theme) {
    final periods = ['1D', '1W', '1M', '3M', '1Y', '5Y'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            periods.map((period) {
              final isSelected = period == _selectedPeriod;
              return Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: InkWell(
                  onTap: () => setState(() => _selectedPeriod = period),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected ? theme.colorScheme.primaryContainer : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      period,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color:
                            isSelected
                                ? theme.colorScheme.onPrimaryContainer
                                : theme.colorScheme.onSurfaceVariant,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  /// Builds the interactive price chart using fl_chart.
  Widget _buildPriceChart(ThemeData theme, Color lineColor) {
    final data = widget.detail.chartData;
    if (data.isEmpty) {
      return Center(
        child: Text(
          'No chart data available',
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
      );
    }

    // Convert data to FlSpots
    final spots = <FlSpot>[];
    for (int i = 0; i < data.length; i++) {
      spots.add(FlSpot(i.toDouble(), data[i]));
    }

    final minY = data.reduce((a, b) => a < b ? a : b);
    final maxY = data.reduce((a, b) => a > b ? a : b);
    final padding = (maxY - minY) * 0.1;

    return LineChart(
      LineChartData(
        minY: minY - padding,
        maxY: maxY + padding,
        minX: 0,
        maxX: (data.length - 1).toDouble(),
        clipData: const FlClipData.all(),
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            // tooltipBgColor: theme.colorScheme.inverseSurface.withOpacity(0.9),
            tooltipRoundedRadius: 8,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                final price = spot.y;
                final index = spot.x.toInt();
                final date = _getDateForIndex(index);
                return LineTooltipItem(
                  '₹${price.toStringAsFixed(2)}\n$date',
                  TextStyle(
                    color: theme.colorScheme.onInverseSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                );
              }).toList();
            },
          ),
          getTouchedSpotIndicator: (barData, spotIndexes) {
            return spotIndexes.map((index) {
              return TouchedSpotIndicatorData(
                const FlLine(color: Colors.white70, strokeWidth: 2, dashArray: [5, 5]),
                FlDotData(
                  show: true,
                  getDotPainter:
                      (spot, percent, barData, index) => FlDotCirclePainter(
                        radius: 5,
                        color: lineColor,
                        strokeWidth: 2,
                        strokeColor: Colors.white,
                      ),
                ),
              );
            }).toList();
          },
          handleBuiltInTouches: true,
          touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
            if (response == null || response.lineBarSpots == null) {
              setState(() => _touchedIndex = null);
              return;
            }
            setState(() => _touchedIndex = response.lineBarSpots!.first.x.toInt());
          },
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            curveSmoothness: 0.35,
            color: lineColor,
            barWidth: 2.5,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [lineColor.withOpacity(0.25), lineColor.withOpacity(0.0)],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper to generate a mock date string for the chart tooltip.
  String _getDateForIndex(int index) {
    // In production, this would map to actual trading dates from the API
    final now = DateTime.now();
    final date = now.subtract(Duration(days: widget.detail.chartData.length - 1 - index));
    return '${date.day}/${date.month}';
  }
}
