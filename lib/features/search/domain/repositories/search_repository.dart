import '../entities/search_result.dart';

/// Abstract repository interface for stock search operations.
///
/// This interface defines the contract for searching stocks in the Domain layer.
/// It is implemented by the Data layer to provide the actual search logic
/// (from a local database, API, or mock data).
///
/// By keeping this in the Domain layer, we ensure that the UI and business logic
/// don't care *how* the search is performed, only *what* it returns.
abstract class SearchRepository {
  /// Searches for stocks matching the given [query].
  ///
  /// The search should match against the company name or symbol.
  /// Returns a list of [SearchResult] entities.
  /// Returns an empty list if no matches are found.
  Future<List<SearchResult>> searchStocks(String query);
}