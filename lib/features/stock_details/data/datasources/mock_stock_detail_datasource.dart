import 'dart:math';

import '../models/stock_detail_model.dart';

/// Mock data source for stock detail data.
///
/// Provides realistic fundamental metrics, company information, and 
/// historical chart data to simulate API responses during development.
/// 
/// The data generation scales metrics (like Market Cap, P/E, 52W High/Low) 
/// relative to a base price to ensure the numbers look financially coherent.
class MockStockDetailDatasource {
  final Random _random = Random();

  /// Fetches comprehensive details for a specific stock symbol.
  ///
  /// Simulates a network delay and returns a [StockDetailModel] populated
  /// with realistic data scaled to a generated base price.
  Future<StockDetailModel> getStockDetail(String symbol) async {
    // Simulate network delay (400-900ms)
    await Future.delayed(Duration(milliseconds: 400 + _random.nextInt(500)));

    return _generateStockDetail(symbol);
  }

  /// Generates a realistic [StockDetailModel] for the given [symbol].
  StockDetailModel _generateStockDetail(String symbol) {
    // Generate a deterministic base price based on the symbol length 
    // to keep it consistent during the same session, or just random.
    final double basePrice = 500 + _random.nextDouble() * 4500; // 500 to 5000
    final double changePercent = (_random.nextDouble() * 6) - 3; // -3% to +3%
    final double change = basePrice * (changePercent / 100);
    final double currentPrice = basePrice + change;

    // Generate 90 days of historical chart data
    final List<double> chartData = _generateChartData(basePrice, 90);

    // Calculate realistic fundamental metrics
    final double marketCap = basePrice * (_random.nextDouble() * 500000000 + 100000000); // Large cap range
    final double peRatio = 15 + _random.nextDouble() * 65; // 15 to 80
    final double pbRatio = 2 + _random.nextDouble() * 13;  // 2 to 15
    final double high52Week = basePrice * (1.1 + _random.nextDouble() * 0.4); // 10% to 50% higher
    final double low52Week = basePrice * (0.5 + _random.nextDouble() * 0.4);  // 50% to 90% of base
    final double dayHigh = currentPrice * (1 + _random.nextDouble() * 0.02);
    final double dayLow = currentPrice * (1 - _random.nextDouble() * 0.02);
    final double volume = 1000000 + _random.nextDouble() * 49000000;

    // Hardcoded sectors/industries for realism, fallback to generic
    final String sector = _getSector(symbol);
    final String industry = _getIndustry(symbol);

    return StockDetailModel(
      symbol: symbol,
      companyName: _getCompanyName(symbol),
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
      openPrice: basePrice * (0.98 + _random.nextDouble() * 0.04),
      prevClose: basePrice,
      sector: sector,
      industry: industry,
      description: _getDescription(symbol),
      chartData: chartData,
    );
  }

  /// Generates historical chart data using a random walk algorithm.
  List<double> _generateChartData(double currentPrice, int days) {
    final List<double> data = [];
    double price = currentPrice * 0.85; // Start 15% lower to show some trend
    
    for (int i = 0; i < days; i++) {
      // Random daily movement between -2% and +2%
      final double dailyChange = price * ((_random.nextDouble() * 0.04) - 0.02);
      price += dailyChange;
      
      // Ensure price doesn't go below 10% of current price
      if (price < currentPrice * 0.1) price = currentPrice * 0.1;
      
      data.add(price);
    }
    
    // Ensure the last data point matches the current price closely
    data.add(currentPrice);
    return data;
  }

  // --- Helper methods for realistic text data ---

  String _getCompanyName(String symbol) {
    // In a real app, this comes from the API. Here we just format it nicely.
    return symbol.split(RegExp(r'(?=[A-Z])')).join(' ').trim() + ' Ltd.';
  }

  String _getSector(String symbol) {
    final sectors = ['Financial Services', 'Information Technology', 'Energy', 'Consumer Goods', 'Automobile', 'Healthcare'];
    return sectors[_random.nextInt(sectors.length)];
  }

  String _getIndustry(String symbol) {
    final industries = ['Banks', 'Software', 'Oil & Gas', 'FMCG', 'Passenger Cars', 'Pharmaceuticals'];
    return industries[_random.nextInt(industries.length)];
  }

  String _getDescription(String symbol) {
    return '$symbol is a leading company in its sector, known for its strong market presence, '
        'consistent financial performance, and innovative approach to business. '
        'The company has a widespread distribution network and a strong brand value across the country.';
  }
}