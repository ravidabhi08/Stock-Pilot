import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/stock_detail.dart';

part 'stock_detail_model.freezed.dart';
part 'stock_detail_model.g.dart';

/// Data model representing comprehensive stock details from external sources.
///
/// This model is part of the Data layer and handles JSON serialization/deserialization.
/// It uses Freezed for immutable data classes and json_serializable for automatic
/// JSON parsing, ensuring type safety and reducing boilerplate when dealing with
/// complex API responses containing fundamental metrics and chart data.
///
/// To convert this model to a domain entity, use the [toEntity] method.
@freezed
class StockDetailModel with _$StockDetailModel {
  /// Creates a new [StockDetailModel] instance.
  const factory StockDetailModel({
    /// The stock ticker symbol.
    required String symbol,

    /// The full name of the company.
    required String companyName,

    /// The current market price.
    required double currentPrice,

    /// The absolute change in price.
    required double change,

    /// The percentage change.
    required double changePercent,

    /// The total trading volume for the day.
    required double volume,

    /// The market capitalization (in INR).
    required double marketCap,

    /// The Price-to-Earnings (P/E) ratio.
    required double peRatio,

    /// The Price-to-Book (P/B) ratio.
    required double pbRatio,

    /// The 52-week high price.
    required double high52Week,

    /// The 52-week low price.
    required double low52Week,

    /// The highest price traded today.
    required double dayHigh,

    /// The lowest price traded today.
    required double dayLow,

    /// The opening price today.
    required double openPrice,

    /// The previous day's closing price.
    required double prevClose,

    /// The sector the company belongs to.
    required String sector,

    /// The specific industry.
    required String industry,

    /// A brief description of the company.
    required String description,

    /// Historical price data for the main chart.
    required List<double> chartData,
  }) = _StockDetailModel;

  /// Creates a [StockDetailModel] from a JSON map.
  factory StockDetailModel.fromJson(Map<String, dynamic> json) =>
      _$StockDetailModelFromJson(json);
}

/// Extension methods for [StockDetailModel] to convert to domain entities.
extension StockDetailModelExtension on StockDetailModel {
  /// Converts this data model to a domain [StockDetail] entity.
  StockDetail toEntity() {
    return StockDetail(
      symbol: symbol,
      companyName: companyName,
      currentPrice: currentPrice,
      change: change,
      changePercent: changePercent,
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
}