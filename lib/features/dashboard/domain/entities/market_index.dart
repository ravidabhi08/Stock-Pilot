import 'package:flutter/foundation.dart';

/// Represents a stock market index (e.g., Nifty 50, Sensex, Bank Nifty).
///
/// This is a Domain layer entity that contains pure business logic data
/// with no framework dependencies. It represents the core concept of a
/// market index as understood by the application's business rules.
///
/// Entities are immutable value objects that form the foundation of the
/// domain model. They are used throughout the application layers and are
/// typically mapped from/to data models in the data layer.
@immutable
class MarketIndex {
  /// The display name of the index (e.g., "Nifty 50", "S&P BSE Sensex").
  final String name;

  /// The ticker symbol or short code (e.g., "NIFTY", "SENSEX").
  final String symbol;

  /// The current value of the index.
  final double value;

  /// The absolute change in the index value from the previous close.
  /// Positive values indicate gains, negative values indicate losses.
  final double change;

  /// The percentage change from the previous close.
  /// Positive values indicate gains, negative values indicate losses.
  final double changePercent;

  /// Optional historical data points for rendering a sparkline chart.
  /// Typically contains the last 30-60 data points intraday or daily.
  final List<double>? sparklineData;

  /// Creates a new [MarketIndex] instance.
  const MarketIndex({
    required this.name,
    required this.symbol,
    required this.value,
    required this.change,
    required this.changePercent,
    this.sparklineData,
  });

  /// Returns true if the index is in positive territory (gain).
  bool get isPositive => change >= 0;

  /// Returns true if the index is in negative territory (loss).
  bool get isNegative => change < 0;

  /// Creates a copy of this [MarketIndex] with the given fields replaced.
  MarketIndex copyWith({
    String? name,
    String? symbol,
    double? value,
    double? change,
    double? changePercent,
    List<double>? sparklineData,
  }) {
    return MarketIndex(
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      value: value ?? this.value,
      change: change ?? this.change,
      changePercent: changePercent ?? this.changePercent,
      sparklineData: sparklineData ?? this.sparklineData,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MarketIndex &&
        other.name == name &&
        other.symbol == symbol &&
        other.value == value &&
        other.change == change &&
        other.changePercent == changePercent &&
        listEquals(other.sparklineData, sparklineData);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        symbol.hashCode ^
        value.hashCode ^
        change.hashCode ^
        changePercent.hashCode ^
        sparklineData.hashCode;
  }

  @override
  String toString() {
    return 'MarketIndex(name: $name, symbol: $symbol, value: $value, '
        'change: $change, changePercent: $changePercent)';
  }
}