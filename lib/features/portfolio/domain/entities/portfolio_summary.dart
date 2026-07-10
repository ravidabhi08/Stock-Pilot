import 'package:flutter/foundation.dart';

import 'holding.dart';

/// Represents the complete portfolio summary.
///
/// This is a Domain layer entity that aggregates all holdings and calculates
/// portfolio-wide statistics. It provides a comprehensive view of the user's
/// total investment, current value, and overall profit/loss.
///
/// This entity serves as the primary data contract for the Portfolio screen,
/// combining individual holdings with aggregated metrics.
@immutable
class PortfolioSummary {
  /// List of all holdings in the portfolio.
  final List<Holding> holdings;

  /// The timestamp when this data was last updated.
  final DateTime? lastUpdated;

  /// Creates a new [PortfolioSummary] instance.
  const PortfolioSummary({required this.holdings, this.lastUpdated});

  /// The total amount invested across all holdings.
  /// Calculated as the sum of (quantity × avg buy price) for each holding.
  double get totalInvestment => holdings.fold(0.0, (sum, holding) => sum + holding.totalInvestment);

  /// The current total market value of the portfolio.
  /// Calculated as the sum of (quantity × current price) for each holding.
  double get totalCurrentValue => holdings.fold(0.0, (sum, holding) => sum + holding.currentValue);

  /// The absolute profit or loss across the entire portfolio.
  /// Positive values indicate overall profit, negative values indicate loss.
  double get totalProfitLoss => totalCurrentValue - totalInvestment;

  /// The overall profit/loss percentage.
  /// Calculated relative to the total investment.
  double get totalProfitLossPercent =>
      totalInvestment > 0 ? (totalProfitLoss / totalInvestment) * 100 : 0.0;

  /// The number of holdings in the portfolio.
  int get holdingsCount => holdings.length;

  /// Returns true if the portfolio is in overall profit.
  bool get isOverallProfit => totalProfitLoss >= 0;

  /// Returns true if the portfolio is in overall loss.
  bool get isOverallLoss => totalProfitLoss < 0;

  /// Returns true if the portfolio is empty (no holdings).
  bool get isEmpty => holdings.isEmpty;

  /// Returns true if the portfolio has holdings.
  bool get isNotEmpty => !isEmpty;

  /// The best performing holding (highest profit/loss percentage).
  /// Returns null if portfolio is empty.
  Holding? get bestPerformer {
    if (holdings.isEmpty) return null;
    return holdings.reduce((a, b) => a.profitLossPercent > b.profitLossPercent ? a : b);
  }

  /// The worst performing holding (lowest profit/loss percentage).
  /// Returns null if portfolio is empty.
  Holding? get worstPerformer {
    if (holdings.isEmpty) return null;
    return holdings.reduce((a, b) => a.profitLossPercent < b.profitLossPercent ? a : b);
  }

  /// Creates a copy of this [PortfolioSummary] with the given fields replaced.
  PortfolioSummary copyWith({List<Holding>? holdings, DateTime? lastUpdated}) {
    return PortfolioSummary(
      holdings: holdings ?? this.holdings,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PortfolioSummary &&
        listEquals(other.holdings, holdings) &&
        other.lastUpdated == lastUpdated;
  }

  @override
  int get hashCode => holdings.hashCode ^ lastUpdated.hashCode;

  @override
  String toString() {
    return 'PortfolioSummary(holdings: ${holdings.length}, '
        'totalInvestment: $totalInvestment, '
        'totalCurrentValue: $totalCurrentValue, '
        'totalProfitLoss: $totalProfitLoss, '
        'totalProfitLossPercent: $totalProfitLossPercent)';
  }
}
