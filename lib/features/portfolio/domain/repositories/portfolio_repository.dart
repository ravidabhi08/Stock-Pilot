import '../entities/portfolio_summary.dart';

/// Abstract repository interface for portfolio data operations.
///
/// This interface defines the contract for fetching portfolio data
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
abstract class PortfolioRepository {
  /// Fetches the complete portfolio summary including all holdings.
  ///
  /// Returns a [PortfolioSummary] containing:
  /// - List of all holdings with purchase details
  /// - Aggregated portfolio metrics (total investment, current value, P&L)
  ///
  /// Throws an [Exception] if the data cannot be fetched.
  /// The specific exception type depends on the implementation
  /// (e.g., [ServerException], [NetworkException], [CacheException]).
  Future<PortfolioSummary> getPortfolio();

  /// Refreshes the portfolio data with latest market prices.
  ///
  /// This method is typically called when the user performs a pull-to-refresh
  /// action or when the data needs to be updated from the server.
  ///
  /// Returns the updated [PortfolioSummary] with current prices.
  /// Throws an [Exception] if the refresh fails.
  Future<PortfolioSummary> refreshPortfolio();
}
