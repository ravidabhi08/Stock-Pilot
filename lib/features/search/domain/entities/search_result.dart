import 'package:flutter/foundation.dart';

/// Represents a stock search result from the market database.
///
/// This is a Domain layer entity. It contains the essential information 
/// needed to display a stock in a search list and add it to the user's 
/// watchlist.
@immutable
class SearchResult {
  /// The stock ticker symbol (e.g., "RELIANCE", "TCS").
  final String symbol;

  /// The full name of the company.
  final String companyName;

  /// The stock exchange it is listed on (e.g., "NSE", "BSE").
  final String exchange;

  /// The sector the company belongs to (e.g., "Energy", "IT").
  final String sector;

  /// Creates a new [SearchResult] instance.
  const SearchResult({
    required this.symbol,
    required this.companyName,
    required this.exchange,
    required this.sector,
  });

  /// Creates a copy of this [SearchResult] with the given fields replaced.
  SearchResult copyWith({
    String? symbol,
    String? companyName,
    String? exchange,
    String? sector,
  }) {
    return SearchResult(
      symbol: symbol ?? this.symbol,
      companyName: companyName ?? this.companyName,
      exchange: exchange ?? this.exchange,
      sector: sector ?? this.sector,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchResult &&
        other.symbol == symbol &&
        other.companyName == companyName &&
        other.exchange == exchange &&
        other.sector == sector;
  }

  @override
  int get hashCode =>
      symbol.hashCode ^
      companyName.hashCode ^
      exchange.hashCode ^
      sector.hashCode;

  @override
  String toString() {
    return 'SearchResult(symbol: $symbol, companyName: $companyName, exchange: $exchange)';
  }
}