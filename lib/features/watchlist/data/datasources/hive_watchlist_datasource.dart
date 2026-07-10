import 'package:hive/hive.dart';

import '../../domain/entities/watchlist_item.dart';

/// Local data source for watchlist data using Hive.
///
/// This datasource handles all local persistence operations for the watchlist.
/// It stores [WatchlistItem] data as Maps in a Hive box, ensuring that the
/// user's tracked stocks are saved on the device and persist across app restarts.
///
/// By using Hive (a lightweight, fast key-value database), we avoid the need
/// for network calls for basic watchlist management, providing an instant,
/// offline-first user experience.
class HiveWatchlistDatasource {
  /// The name of the Hive box used to store watchlist items.
  static const String _boxName = 'watchlist_box';

  /// Opens the Hive box if it isn't already open, and returns the [Box] instance.
  Future<Box<Map>> _openBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box<Map>(_boxName);
    }
    return await Hive.openBox<Map>(_boxName);
  }

  /// Fetches all items currently in the user's watchlist.
  ///
  /// Returns a list of [WatchlistItem] sorted by the date they were added
  /// (newest first).
  Future<List<WatchlistItem>> getWatchlist() async {
    final box = await _openBox();

    // Extract all values from the box
    final List<Map> rawItems = box.values.toList();

    // Map the raw data back to domain entities
    final List<WatchlistItem> items =
        rawItems.map((map) {
          return WatchlistItem(
            symbol: map['symbol'] as String,
            companyName: map['companyName'] as String,
            addedAt: DateTime.parse(map['addedAt'] as String),
          );
        }).toList();

    // Sort by addedAt descending (newest first)
    items.sort((a, b) => b.addedAt.compareTo(a.addedAt));

    return items;
  }

  /// Adds a new stock to the user's watchlist.
  ///
  /// Uses the stock [symbol] as the unique key in the Hive box.
  Future<void> addToWatchlist(WatchlistItem item) async {
    final box = await _openBox();

    await box.put(item.symbol, {
      'symbol': item.symbol,
      'companyName': item.companyName,
      'addedAt': item.addedAt.toIso8601String(),
    });
  }

  /// Removes a stock from the user's watchlist.
  Future<void> removeFromWatchlist(String symbol) async {
    final box = await _openBox();
    await box.delete(symbol);
  }

  /// Checks if a specific stock is currently in the watchlist.
  Future<bool> isInWatchlist(String symbol) async {
    final box = await _openBox();
    return box.containsKey(symbol);
  }
}
