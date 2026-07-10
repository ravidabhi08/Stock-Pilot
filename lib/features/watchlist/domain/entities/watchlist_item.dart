import 'package:flutter/foundation.dart';

/// Represents a stock added to the user's watchlist.
///
/// This is a Domain layer entity. It contains pure business data with no
/// framework dependencies. It models a stock that the user is tracking
/// but does not necessarily own (unlike a Portfolio Holding).
@immutable
class WatchlistItem {
  /// The stock ticker symbol (e.g., "RELIANCE", "TCS").
  final String symbol;

  /// The full name of the company.
  final String companyName;

  /// The date and time the stock was added to the watchlist.
  final DateTime addedAt;

  /// Creates a new [WatchlistItem] instance.
  const WatchlistItem({required this.symbol, required this.companyName, required this.addedAt});

  /// Creates a copy of this [WatchlistItem] with the given fields replaced.
  WatchlistItem copyWith({String? symbol, String? companyName, DateTime? addedAt}) {
    return WatchlistItem(
      symbol: symbol ?? this.symbol,
      companyName: companyName ?? this.companyName,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WatchlistItem &&
        other.symbol == symbol &&
        other.companyName == companyName &&
        other.addedAt == addedAt;
  }

  @override
  int get hashCode => symbol.hashCode ^ companyName.hashCode ^ addedAt.hashCode;

  @override
  String toString() {
    return 'WatchlistItem(symbol: $symbol, companyName: $companyName, addedAt: $addedAt)';
  }
}
