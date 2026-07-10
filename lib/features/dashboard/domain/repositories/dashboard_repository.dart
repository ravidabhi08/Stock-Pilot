import '../entities/market_overview.dart';

/// Abstract repository interface for dashboard data operations.
///
/// This interface defines the contract for fetching market overview data
/// in the Domain layer. It is implemented by the Data layer to provide
/// the actual data fetching logic (from APIs, databases, or mock sources).
///
/// The repository pattern separates the business logic (Domain) from the
/// data fetching implementation (Data), allowing for:
/// - Easy testing with mock implementations
/// - Swapping data sources without changing business logic
/// - Clear separation of concerns in Clean Architecture
///
/// All methods return domain entities, not data models, ensuring the
/// Domain layer remains independent of external concerns.
abstract class DashboardRepository {
  /// Fetches the complete market overview including indices and top movers.
  ///
  /// Returns a [MarketOverview] containing:
  /// - Major market indices (Nifty 50, Sensex, Bank Nifty)
  /// - Top gaining stocks
  /// - Top losing stocks
  ///
  /// Throws an [Exception] if the data cannot be fetched.
  /// The specific exception type depends on the implementation
  /// (e.g., [ServerException], [NetworkException], [CacheException]).
  Future<MarketOverview> getMarketOverview();

  /// Refreshes the market overview data.
  ///
  /// This method is typically called when the user performs a pull-to-refresh
  /// action or when the data needs to be updated from the server.
  ///
  /// Returns the updated [MarketOverview].
  /// Throws an [Exception] if the refresh fails.
  Future<MarketOverview> refreshMarketOverview();
}