
import '../entities/stock_detail.dart';

/// Abstract repository interface for stock detail data operations.
///
/// This interface defines the contract for fetching comprehensive stock
/// data in the Domain layer. It is implemented by the Data layer to provide
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
abstract class StockDetailRepository {
  /// Fetches comprehensive details for a specific stock.
  ///
  /// Takes a stock [symbol] (e.g., "RELIANCE", "TCS") and returns a
  /// [StockDetail] entity containing fundamental metrics, company info,
  /// and historical chart data.
  ///
  /// Throws an [Exception] if the data cannot be fetched or if the
  /// symbol is invalid.
  Future<StockDetail> getStockDetail(String symbol);

  /// Refreshes the stock detail data with the latest market prices.
  ///
  /// This method is typically called when the user performs a pull-to-refresh
  /// action on the Stock Details screen.
  ///
  /// Returns the updated [StockDetail] with current prices.
  /// Throws an [Exception] if the refresh fails.
  Future<StockDetail> refreshStockDetail(String symbol);
}
