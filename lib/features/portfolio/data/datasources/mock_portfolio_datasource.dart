import 'dart:math';

import '../models/holding_model.dart';

/// Mock data source for portfolio data.
///
/// Provides realistic portfolio holdings data to simulate API responses during
/// development and testing. This datasource generates a diversified portfolio
/// with various Indian stocks, including purchase details and current prices.
///
/// The data is hardcoded with realistic values to demonstrate different scenarios:
/// - Profitable holdings (current price > avg buy price)
/// - Loss-making holdings (current price < avg buy price)
/// - Break-even holdings (current price ≈ avg buy price)
///
/// A simulated network delay is added to mimic real API behavior.
///
/// In production, this would be replaced with actual API calls to fetch
/// the user's real portfolio from their broker (e.g., Zerodha, Upstox).
class MockPortfolioDatasource {
  final Random _random = Random();

  /// Simulates fetching portfolio data with a network delay.
  ///
  /// Returns a list of [HoldingModel] representing the user's holdings.
  ///
  /// Throws an [Exception] if the simulated request fails (5% chance).
  Future<List<HoldingModel>> getPortfolio() async {
    // Simulate network delay (300-800ms)
    await Future.delayed(Duration(milliseconds: 300 + _random.nextInt(500)));

    // Simulate occasional network failures (5% chance)
    // Commented out for development - uncomment to test error states
    /*
    if (_random.nextDouble() < 0.05) {
      throw Exception('Simulated network error');
    }
    */

    return _generatePortfolio();
  }

  /// Generates a realistic portfolio with diversified holdings.
  List<HoldingModel> _generatePortfolio() {
    return [
      // Profitable holdings
      const HoldingModel(
        symbol: 'RELIANCE',
        companyName: 'Reliance Industries Ltd.',
        quantity: 50,
        avgBuyPrice: 2450.00,
        currentPrice: 2850.50,
      ),
      const HoldingModel(
        symbol: 'TCS',
        companyName: 'Tata Consultancy Services Ltd.',
        quantity: 30,
        avgBuyPrice: 3650.00,
        currentPrice: 3950.75,
      ),
      const HoldingModel(
        symbol: 'INFY',
        companyName: 'Infosys Ltd.',
        quantity: 75,
        avgBuyPrice: 1420.00,
        currentPrice: 1580.25,
      ),
      const HoldingModel(
        symbol: 'HDFCBANK',
        companyName: 'HDFC Bank Ltd.',
        quantity: 100,
        avgBuyPrice: 1550.00,
        currentPrice: 1650.50,
      ),
      const HoldingModel(
        symbol: 'ICICIBANK',
        companyName: 'ICICI Bank Ltd.',
        quantity: 80,
        avgBuyPrice: 1100.00,
        currentPrice: 1250.75,
      ),

      // Loss-making holdings
      const HoldingModel(
        symbol: 'TATAMOTORS',
        companyName: 'Tata Motors Ltd.',
        quantity: 200,
        avgBuyPrice: 1050.00,
        currentPrice: 950.25,
      ),
      const HoldingModel(
        symbol: 'ADANIENT',
        companyName: 'Adani Enterprises Ltd.',
        quantity: 40,
        avgBuyPrice: 3200.00,
        currentPrice: 2850.50,
      ),

      // Small holdings
      const HoldingModel(
        symbol: 'WIPRO',
        companyName: 'Wipro Ltd.',
        quantity: 150,
        avgBuyPrice: 450.00,
        currentPrice: 480.75,
      ),
      const HoldingModel(
        symbol: 'SUNPHARMA',
        companyName: 'Sun Pharmaceutical Inds. Ltd.',
        quantity: 60,
        avgBuyPrice: 1580.00,
        currentPrice: 1650.25,
      ),
      const HoldingModel(
        symbol: 'BAJAJ-AUTO',
        companyName: 'Bajaj Auto Ltd.',
        quantity: 20,
        avgBuyPrice: 8200.00,
        currentPrice: 8500.50,
      ),
    ];
  }
}
