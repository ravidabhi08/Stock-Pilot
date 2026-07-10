import 'package:flutter/foundation.dart';

import 'market_index.dart';
import 'stock.dart';

/// Represents the complete market overview for the dashboard.
///
/// This is a Domain layer entity that aggregates all the data needed
/// to render the main dashboard screen. It contains market indices
/// (Nifty 50, Sensex, Bank Nifty) and the top performing/declining
/// stocks (gainers and losers).
///
/// This entity serves as the primary data contract between the
/// DashboardRepository and the presentation layer, providing a
/// complete snapshot of market conditions.
@immutable
class MarketOverview {
  /// List of major market indices (e.g., Nifty 50, Sensex, Bank Nifty).
  final List<MarketIndex> indices;

  /// List of top gaining stocks, sorted by percentage change (descending).
  final List<Stock> topGainers;

  /// List of top losing stocks, sorted by percentage change (ascending).
  final List<Stock> topLosers;

  /// The timestamp when this market overview data was last updated.
  /// Useful for displaying "Last updated: X minutes ago" in the UI.
  final DateTime? lastUpdated;

  /// Creates a new [MarketOverview] instance.
  const MarketOverview({
    required this.indices,
    required this.topGainers,
    required this.topLosers,
    this.lastUpdated,
  });

  /// Returns true if the market overview contains no data.
  bool get isEmpty => indices.isEmpty && topGainers.isEmpty && topLosers.isEmpty;

  /// Returns true if the market overview contains any data.
  bool get isNotEmpty => !isEmpty;

  /// Creates a copy of this [MarketOverview] with the given fields replaced.
  MarketOverview copyWith({
    List<MarketIndex>? indices,
    List<Stock>? topGainers,
    List<Stock>? topLosers,
    DateTime? lastUpdated,
  }) {
    return MarketOverview(
      indices: indices ?? this.indices,
      topGainers: topGainers ?? this.topGainers,
      topLosers: topLosers ?? this.topLosers,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MarketOverview &&
        listEquals(other.indices, indices) &&
        listEquals(other.topGainers, topGainers) &&
        listEquals(other.topLosers, topLosers) &&
        other.lastUpdated == lastUpdated;
  }

  @override
  int get hashCode {
    return indices.hashCode ^ topGainers.hashCode ^ topLosers.hashCode ^ lastUpdated.hashCode;
  }

  @override
  String toString() {
    return 'MarketOverview(indices: ${indices.length}, '
        'topGainers: ${topGainers.length}, '
        'topLosers: ${topLosers.length}, '
        'lastUpdated: $lastUpdated)';
  }
}
