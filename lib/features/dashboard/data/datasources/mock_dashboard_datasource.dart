import 'dart:math';

import '../models/market_index_model.dart';
import '../models/stock_model.dart';

/// Mock data source for dashboard data.
///
/// Provides realistic Indian market data to simulate API responses during
/// development and testing.
class MockDashboardDatasource {
  final Random _random = Random();

  /// Fetches market overview data with a simulated network delay.
  Future<
    ({List<MarketIndexModel> indices, List<StockModel> topGainers, List<StockModel> topLosers})
  >
  getMarketOverview() async {
    // Simulate network delay (300-800ms)
    await Future.delayed(Duration(milliseconds: 300 + _random.nextInt(500)));

    return (
      indices: _generateIndices(),
      topGainers: _generateTopGainers(),
      topLosers: _generateTopLosers(),
    );
  }

  List<MarketIndexModel> _generateIndices() {
    return [
      MarketIndexModel(
        name: 'Nifty 50',
        symbol: 'NIFTY',
        value: 22450.75 + (_random.nextDouble() * 100 - 50),
        change: 125.40 + (_random.nextDouble() * 50 - 25),
        changePercent: 0.56 + (_random.nextDouble() * 0.2 - 0.1),
        sparklineData: _generateSparklineData(22400, 22500, 30),
      ),
      MarketIndexModel(
        name: 'S&P BSE Sensex',
        symbol: 'SENSEX',
        value: 73850.25 + (_random.nextDouble() * 150 - 75),
        change: 380.60 + (_random.nextDouble() * 80 - 40),
        changePercent: 0.52 + (_random.nextDouble() * 0.15 - 0.075),
        sparklineData: _generateSparklineData(73700, 74000, 30),
      ),
      MarketIndexModel(
        name: 'Nifty Bank',
        symbol: 'BANKNIFTY',
        value: 48250.50 + (_random.nextDouble() * 120 - 60),
        change: -85.30 + (_random.nextDouble() * 40 - 20),
        changePercent: -0.18 + (_random.nextDouble() * 0.1 - 0.05),
        sparklineData: _generateSparklineData(48200, 48350, 30),
      ),
    ];
  }

  List<StockModel> _generateTopGainers() {
    final List<Map<String, dynamic>> gainersData = [
      {'symbol': 'TATAMOTORS', 'name': 'Tata Motors Ltd.', 'basePrice': 950.0},
      {'symbol': 'ADANIENT', 'name': 'Adani Enterprises Ltd.', 'basePrice': 2850.0},
      {'symbol': 'BAJAJ-AUTO', 'name': 'Bajaj Auto Ltd.', 'basePrice': 8500.0},
      {'symbol': 'SUNPHARMA', 'name': 'Sun Pharmaceutical Inds. Ltd.', 'basePrice': 1650.0},
      {'symbol': 'WIPRO', 'name': 'Wipro Ltd.', 'basePrice': 480.0},
      {'symbol': 'ICICIBANK', 'name': 'ICICI Bank Ltd.', 'basePrice': 1250.0},
    ];

    return gainersData.map((data) {
      final double basePrice = data['basePrice'] as double;
      final double changePercent = 2.0 + _random.nextDouble() * 5.0;
      final double change = basePrice * (changePercent / 100);
      final double currentPrice = basePrice + change;

      return StockModel(
        symbol: data['symbol'] as String,
        companyName: data['name'] as String,
        currentPrice: currentPrice,
        change: change,
        changePercent: changePercent,
        volume: _generateVolume(),
        marketCap: basePrice * 1000000000,
        high52Week: basePrice * 1.3,
        low52Week: basePrice * 0.7,
        sparklineData: _generateSparklineData(basePrice * 0.98, currentPrice, 30),
      );
    }).toList();
  }

  List<StockModel> _generateTopLosers() {
    final List<Map<String, dynamic>> losersData = [
      {'symbol': 'RELIANCE', 'name': 'Reliance Industries Ltd.', 'basePrice': 2850.0},
      {'symbol': 'HDFCBANK', 'name': 'HDFC Bank Ltd.', 'basePrice': 1650.0},
      {'symbol': 'INFY', 'name': 'Infosys Ltd.', 'basePrice': 1580.0},
      {'symbol': 'TCS', 'name': 'Tata Consultancy Services Ltd.', 'basePrice': 3950.0},
      {'symbol': 'LT', 'name': 'Larsen & Toubro Ltd.', 'basePrice': 3450.0},
      {'symbol': 'HINDUNILVR', 'name': 'Hindustan Unilever Ltd.', 'basePrice': 2650.0},
    ];

    return losersData.map((data) {
      final double basePrice = data['basePrice'] as double;
      final double changePercent = -(2.0 + _random.nextDouble() * 5.0);
      final double change = basePrice * (changePercent / 100);
      final double currentPrice = basePrice + change;

      return StockModel(
        symbol: data['symbol'] as String,
        companyName: data['name'] as String,
        currentPrice: currentPrice,
        change: change,
        changePercent: changePercent,
        volume: _generateVolume(),
        marketCap: basePrice * 1000000000,
        high52Week: basePrice * 1.3,
        low52Week: basePrice * 0.7,
        sparklineData: _generateSparklineData(currentPrice, basePrice * 1.02, 30),
      );
    }).toList();
  }

  double _generateVolume() {
    return 1000000 + _random.nextDouble() * 49000000;
  }

  List<double> _generateSparklineData(double minValue, double maxValue, int points) {
    final List<double> data = [];
    double currentValue = (minValue + maxValue) / 2;
    final double range = maxValue - minValue;

    for (int i = 0; i < points; i++) {
      final double change = (_random.nextDouble() - 0.5) * range * 0.1;
      currentValue += change;
      currentValue = currentValue.clamp(minValue, maxValue);
      data.add(currentValue);
    }

    return data;
  }
}
