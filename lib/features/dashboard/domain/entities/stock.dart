import 'package:flutter/foundation.dart';

/// Represents an individual stock/security in the Indian stock market.
///
/// This is a Domain layer entity containing pure business data with no
/// framework dependencies. It models the core concept of a stock as
/// understood by the application's business rules, independent of how
/// the data is fetched (API, database, mock) or displayed (UI).
///
/// Entities are immutable value objects that form the foundation of the
/// domain model. They are mapped from/to data models in the data layer.
@immutable
class Stock {
  /// The stock ticker symbol (e.g., "RELIANCE", "TCS", "INFY").
  final String symbol;

  /// The full name of the company (e.g., "Reliance Industries Ltd.").
  final String companyName;

  /// The current market price (Last Traded Price - LTP).
  final double currentPrice;

  /// The absolute change in price from the previous close.
  /// Positive values indicate gains, negative values indicate losses.
  final double change;

  /// The percentage change from the previous close.
  final double changePercent;

  /// The total trading volume (number of shares traded).
  final double volume;

  /// The market capitalization of the company (in INR).
  final double? marketCap;

  /// The 52-week high price of the stock.
  final double? high52Week;

  /// The 52-week low price of the stock.
  final double? low52Week;

  /// Optional historical data points for rendering a sparkline chart.
  final List<double>? sparklineData;

  /// Creates a new [Stock] instance.
  const Stock({
    required this.symbol,
    required this.companyName,
    required this.currentPrice,
    required this.change,
    required this.changePercent,
    required this.volume,
    this.marketCap,
    this.high52Week,
    this.low52Week,
    this.sparklineData,
  });

  /// Returns true if the stock is in positive territory (gain).
  bool get isPositive => change >= 0;

  /// Returns true if the stock is in negative territory (loss).
  bool get isNegative => change < 0;

  /// Creates a copy of this [Stock] with the given fields replaced.
  Stock copyWith({
    String? symbol,
    String? companyName,
    double? currentPrice,
    double? change,
    double? changePercent,
    double? volume,
    double? marketCap,
    double? high52Week,
    double? low52Week,
    List<double>? sparklineData,
  }) {
    return Stock(
      symbol: symbol ?? this.symbol,
      companyName: companyName ?? this.companyName,
      currentPrice: currentPrice ?? this.currentPrice,
      change: change ?? this.change,
      changePercent: changePercent ?? this.changePercent,
      volume: volume ?? this.volume,
      marketCap: marketCap ?? this.marketCap,
      high52Week: high52Week ?? this.high52Week,
      low52Week: low52Week ?? this.low52Week,
      sparklineData: sparklineData ?? this.sparklineData,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Stock &&
        other.symbol == symbol &&
        other.companyName == companyName &&
        other.currentPrice == currentPrice &&
        other.change == change &&
        other.changePercent == changePercent &&
        other.volume == volume &&
        other.marketCap == marketCap &&
        other.high52Week == high52Week &&
        other.low52Week == low52Week &&
        listEquals(other.sparklineData, sparklineData);
  }

  @override
  int get hashCode {
    return symbol.hashCode ^
        companyName.hashCode ^
        currentPrice.hashCode ^
        change.hashCode ^
        changePercent.hashCode ^
        volume.hashCode ^
        marketCap.hashCode ^
        high52Week.hashCode ^
        low52Week.hashCode ^
        sparklineData.hashCode;
  }

  @override
  String toString() {
    return 'Stock(symbol: $symbol, companyName: $companyName, '
        'currentPrice: $currentPrice, change: $change, '
        'changePercent: $changePercent)';
  }
}
