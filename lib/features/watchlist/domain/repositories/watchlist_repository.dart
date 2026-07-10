import '../entities/watchlist_item.dart';

/// Abstract repository interface for watchlist data operations.
///
/// This interface defines the contract for managing the user's watchlist
/// in the Domain layer. It is implemented by the Data layer to provide
/// the actual persistence logic (in our case, using Hive for local storage).
///
/// The repository pattern separates the business logic (Domain) from the
/// data persistence implementation (Data), allowing for:
/// - Easy testing with mock implementations
/// - Swapping storage mechanisms without changing business logic
/// - Clear separation of concerns in Clean Architecture
abstract class WatchlistRepository {
  /// Fetches all items currently in the user's watchlist.
  ///
  /// Returns a list of [WatchlistItem] sorted by the date they were added
  /// (newest first). Returns an empty list if the watchlist is empty.
  Future<List<WatchlistItem>> getWatchlist();

  /// Adds a new stock to the user's watchlist.
  ///
  /// Takes a [WatchlistItem] and persists it to local storage.
  /// If the stock is already in the watchlist, this method should
  /// either do nothing or update the existing item, depending on
  /// the implementation.
  Future<void> addToWatchlist(WatchlistItem item);

  /// Removes a stock from the user's watchlist.
  ///
  /// Takes the [symbol] of the stock to remove.
  /// Does nothing if the symbol is not found in the watchlist.
  Future<void> removeFromWatchlist(String symbol);

  /// Checks if a specific stock is currently in the watchlist.
  ///
  /// Returns `true` if the stock with the given [symbol] exists,
  /// otherwise `false`. This is useful for updating UI state
  /// (e.g., toggling a filled/unfilled star icon).
  Future<bool> isInWatchlist(String symbol);
}
