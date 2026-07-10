import 'package:flutter/foundation.dart';

/// Represents comprehensive details for a single stock.
///
/// This is a Domain layer entity containing pure business data. It extends
/// the basic stock information with deep fundamental metrics, company details,
/// and a large dataset for rendering the main interactive price chart.
@immutable
class StockDetail {
  /// The stock ticker symbol (e.g., "RELIANCE").
  final String symbol;

  /// The full name of the company.
  final String companyName;

  /// The current market price (Last Traded Price).
  final double currentPrice;

  /// The absolute change in price from the previous close.
  final double change;

  /// The percentage change from the previous close.
  final double changePercent;

  /// The total trading volume for the day.
  final double volume;

  /// The market capitalization of the company (in INR).
  final double marketCap;

  /// The Price-to-Earnings (P/E) ratio.
  final double peRatio;

  /// The Price-to-Book (P/B) ratio.
  final double pbRatio;

  /// The 52-week high price of the stock.
  final double high52Week;

  /// The 52-week low price of the stock.
  final double low52Week;

  /// The highest price traded today.
  final double dayHigh;

  /// The lowest price traded today.
  final double dayLow;

  /// The opening price today.
  final double openPrice;

  /// The previous day's closing price.
  final double prevClose;

  /// The sector the company belongs to (e.g., "Energy", "IT").
  final String sector;

  /// The specific industry (e.g., "Oil & Gas", "Software").
  final String industry;

  /// A brief description of the company's business.
  final String description;

  /// Historical price data for the main chart (e.g., last 90 days).
  /// Each double represents the closing price for a specific day.
  final List<double> chartData;

  /// Creates a new [StockDetail] instance.
  const StockDetail({
    required this.symbol,
    required this.companyName,
    required this.currentPrice,
    required this.change,
    required this.changePercent,
    required this.volume,
    required this.marketCap,
    required this.peRatio,
    required this.pbRatio,
    required this.high52Week,
    required this.low52Week,
    required this.dayHigh,
    required this.dayLow,
    required this.openPrice,
    required this.prevClose,
    required this.sector,
    required this.industry,
    required this.description,
    required this.chartData,
  });

  /// Returns true if the stock is in positive territory.
  bool get isPositive => change >= 0;

  /// Returns true if the stock is in negative territory.
  bool get isNegative => change < 0;

  /// Creates a copy of this [StockDetail] with updated current price and change.
  /// Useful for live price updates without losing fundamental data.
  StockDetail withPriceUpdate(double newPrice, double newChange, double newChangePercent) {
    return StockDetail(
      symbol: symbol,
      companyName: companyName,
      currentPrice: newPrice,
      change: newChange,
      changePercent: newChangePercent,
      volume: volume,
      marketCap: marketCap,
      peRatio: peRatio,
      pbRatio: pbRatio,
      high52Week: high52Week,
      low52Week: low52Week,
      dayHigh: dayHigh,
      dayLow: dayLow,
      openPrice: openPrice,
      prevClose: prevClose,
      sector: sector,
      industry: industry,
      description: description,
      chartData: chartData,
    );
  }

  /// Creates a copy of this [StockDetail] with the given fields replaced.
  StockDetail copyWith({
    String? symbol,
    String? companyName,
    double? currentPrice,
    double? change,
    double? changePercent,
    double? volume,
    double? marketCap,
    double? peRatio,
    double? pbRatio,
    double? high52Week,
    double? low52Week,
    double? dayHigh,
    double? dayLow,
    double? openPrice,
    double? prevClose,
    String? sector,
    String? industry,
    String? description,
    List<double>? chartData,
  }) {
    return StockDetail(
      symbol: symbol ?? this.symbol,
      companyName: companyName ?? this.companyName,
      currentPrice: currentPrice ?? this.currentPrice,
      change: change ?? this.change,
      changePercent: changePercent ?? this.changePercent,
      volume: volume ?? this.volume,
      marketCap: marketCap ?? this.marketCap,
      peRatio: peRatio ?? this.peRatio,
      pbRatio: pbRatio ?? this.pbRatio,
      high52Week: high52Week ?? this.high52Week,
      low52Week: low52Week ?? this.low52Week,
      dayHigh: dayHigh ?? this.dayHigh,
      dayLow: dayLow ?? this.dayLow,
      openPrice: openPrice ?? this.openPrice,
      prevClose: prevClose ?? this.prevClose,
      sector: sector ?? this.sector,
      industry: industry ?? this.industry,
      description: description ?? this.description,
      chartData: chartData ?? this.chartData,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StockDetail &&
        other.symbol == symbol &&
        other.companyName == companyName &&
        other.currentPrice == currentPrice &&
        other.change == change &&
        other.changePercent == changePercent &&
        other.volume == volume &&
        other.marketCap == marketCap &&
        other.peRatio == peRatio &&
        other.pbRatio == pbRatio &&
        other.high52Week == high52Week &&
        other.low52Week == low52Week &&
        other.dayHigh == dayHigh &&
        other.dayLow == dayLow &&
        other.openPrice == openPrice &&
        other.prevClose == prevClose &&
        other.sector == sector &&
        other.industry == industry &&
        other.description == description &&
        listEquals(other.chartData, chartData);
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
        peRatio.hashCode ^
        pbRatio.hashCode ^
        high52Week.hashCode ^
        low52Week.hashCode ^
        dayHigh.hashCode ^
        dayLow.hashCode ^
        openPrice.hashCode ^
        prevClose.hashCode ^
        sector.hashCode ^
        industry.hashCode ^
        description.hashCode ^
        chartData.hashCode;
  }

  @override
  String toString() {
    return 'StockDetail(symbol: $symbol, companyName: $companyName, '
        'currentPrice: $currentPrice, change: $change)';
  }
}
