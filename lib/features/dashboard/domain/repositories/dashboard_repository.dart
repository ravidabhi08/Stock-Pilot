import 'dart:async';

import '../entities/market_overview.dart';

/// Abstract repository interface for dashboard data operations.
///
/// This interface defines the contract for fetching market overview data
/// in the Domain layer. It supports both one-time fetches and continuous
/// live data streams.
abstract class DashboardRepository {
  /// Fetches the market overview data once.
  Future<MarketOverview> getMarketOverview();

  /// Watches the market overview data as a continuous stream.
  ///
  /// This method returns a [Stream] that emits a new [MarketOverview]
  /// whenever live price updates are received. This is used to power
  /// the real-time ticking prices on the Dashboard.
  Stream<MarketOverview> watchMarketOverview();
}