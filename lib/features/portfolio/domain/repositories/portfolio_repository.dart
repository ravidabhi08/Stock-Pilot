import 'dart:async';

import '../entities/portfolio_summary.dart';

/// Abstract repository interface for portfolio data operations.
abstract class PortfolioRepository {
  /// Fetches the complete portfolio summary including all holdings once.
  Future<PortfolioSummary> getPortfolio();

  /// Watches the portfolio summary as a continuous live stream.
  ///
  /// Returns a [Stream] that emits a new [PortfolioSummary] every time
  /// live market prices are updated. This powers the real-time ticking
  /// of the Portfolio's total value and P&L.
  Stream<PortfolioSummary> watchPortfolio();

  /// Refreshes the portfolio data with latest market prices.
  Future<PortfolioSummary> refreshPortfolio();
}