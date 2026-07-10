import 'package:flutter/foundation.dart';

/// Represents a single stock holding in the user's portfolio.
///
/// This is a Domain layer entity containing pure business data with no
/// framework dependencies. It models the core concept of a stock holding
/// as understood by the application's business rules.
///
/// A holding represents shares of a specific stock that the user owns,
/// including purchase details and current market value.
@immutable
class Holding {
  /// The stock ticker symbol (e.g., "RELIANCE", "TCS").
  final String symbol;

  /// The full name of the company.
  final String companyName;

  /// The number of shares held.
  final double quantity;

  /// The average purchase price per share.
  final double avgBuyPrice;

  /// The current market price per share.
  final double currentPrice;

  /// Creates a new [Holding] instance.
  const Holding({
    required this.symbol,
    required this.companyName,
    required this.quantity,
    required this.avgBuyPrice,
    required this.currentPrice,
  });

  /// The total investment amount (quantity × avg buy price).
  double get totalInvestment => quantity * avgBuyPrice;

  /// The current market value (quantity × current price).
  double get currentValue => quantity * currentPrice;

  /// The absolute profit or loss (current value - total investment).
  /// Positive values indicate profit, negative values indicate loss.
  double get profitLoss => currentValue - totalInvestment;

  /// The profit/loss percentage relative to the total investment.
  double get profitLossPercent => totalInvestment > 0 ? (profitLoss / totalInvestment) * 100 : 0.0;

  /// Returns true if the holding is in profit.
  bool get isProfit => profitLoss >= 0;

  /// Returns true if the holding is in loss.
  bool get isLoss => profitLoss < 0;

  /// Creates a copy of this [Holding] with updated current price.
  ///
  /// This is useful when refreshing market data without changing
  /// the purchase details.
  Holding withCurrentPrice(double newPrice) {
    return Holding(
      symbol: symbol,
      companyName: companyName,
      quantity: quantity,
      avgBuyPrice: avgBuyPrice,
      currentPrice: newPrice,
    );
  }

  /// Creates a copy of this [Holding] with the given fields replaced.
  Holding copyWith({
    String? symbol,
    String? companyName,
    double? quantity,
    double? avgBuyPrice,
    double? currentPrice,
  }) {
    return Holding(
      symbol: symbol ?? this.symbol,
      companyName: companyName ?? this.companyName,
      quantity: quantity ?? this.quantity,
      avgBuyPrice: avgBuyPrice ?? this.avgBuyPrice,
      currentPrice: currentPrice ?? this.currentPrice,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Holding &&
        other.symbol == symbol &&
        other.companyName == companyName &&
        other.quantity == quantity &&
        other.avgBuyPrice == avgBuyPrice &&
        other.currentPrice == currentPrice;
  }

  @override
  int get hashCode {
    return symbol.hashCode ^
        companyName.hashCode ^
        quantity.hashCode ^
        avgBuyPrice.hashCode ^
        currentPrice.hashCode;
  }

  @override
  String toString() {
    return 'Holding(symbol: $symbol, quantity: $quantity, '
        'avgBuyPrice: $avgBuyPrice, currentPrice: $currentPrice, '
        'profitLoss: $profitLoss)';
  }
}
