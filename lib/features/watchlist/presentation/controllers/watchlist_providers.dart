import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/app_logger.dart';
import '../../data/datasources/hive_watchlist_datasource.dart';
import '../../data/repositories/watchlist_repository_impl.dart';
import '../../domain/entities/watchlist_item.dart';
import '../../domain/repositories/watchlist_repository.dart';

/// Provides the [HiveWatchlistDatasource] instance.
///
/// This datasource handles local persistence using Hive.
final hiveWatchlistDatasourceProvider = Provider<HiveWatchlistDatasource>((ref) {
  return HiveWatchlistDatasource();
});

/// Provides the [WatchlistRepository] implementation.
final watchlistRepositoryProvider = Provider<WatchlistRepository>((ref) {
  final datasource = ref.watch(hiveWatchlistDatasourceProvider);
  return WatchlistRepositoryImpl(datasource);
});

/// The state notifier for the Watchlist feature.
///
/// Manages the list of watched stocks, handling loading, adding,
/// and removing items. It uses [AsyncNotifier] to properly handle
/// the asynchronous initial load from the local Hive database.
class WatchlistNotifier extends AsyncNotifier<List<WatchlistItem>> {
  @override
  Future<List<WatchlistItem>> build() async {
    // This method is called when the provider is first initialized.
    // It loads the watchlist from the local database.
    AppLogger.instance.i('🔄 WatchlistNotifier: Initializing and loading data...');
    return _loadWatchlist();
  }

  /// Fetches the watchlist from the repository.
  Future<List<WatchlistItem>> _loadWatchlist() async {
    final repository = ref.read(watchlistRepositoryProvider);
    return await repository.getWatchlist();
  }

  /// Adds a new stock to the watchlist.
  ///
  /// Updates the local database and then immediately updates the UI state
  /// by appending the new item to the current list.
  Future<void> addItem(WatchlistItem item) async {
    AppLogger.instance.i('➕ WatchlistNotifier: Adding ${item.symbol}...');

    final repository = ref.read(watchlistRepositoryProvider);

    try {
      // 1. Save to local database
      await repository.addToWatchlist(item);

      // 2. Update UI state
      state = AsyncValue.data([
        item, // Add new item to the top
        ...?state.value, // Keep existing items
      ]);

      AppLogger.instance.i('✅ WatchlistNotifier: Successfully added ${item.symbol}');
    } catch (e, stackTrace) {
      AppLogger.instance.e(
        '❌ WatchlistNotifier: Error adding item',
        error: e,
        stackTrace: stackTrace,
      );
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Removes a stock from the watchlist.
  ///
  /// Updates the local database and then immediately updates the UI state
  /// by filtering out the removed item.
  Future<void> removeItem(String symbol) async {
    AppLogger.instance.i('➖ WatchlistNotifier: Removing $symbol...');

    final repository = ref.read(watchlistRepositoryProvider);

    try {
      // 1. Remove from local database
      await repository.removeFromWatchlist(symbol);

      // 2. Update UI state
      state = AsyncValue.data(state.value?.where((item) => item.symbol != symbol).toList() ?? []);

      AppLogger.instance.i('✅ WatchlistNotifier: Successfully removed $symbol');
    } catch (e, stackTrace) {
      AppLogger.instance.e(
        '❌ WatchlistNotifier: Error removing item',
        error: e,
        stackTrace: stackTrace,
      );
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Refreshes the watchlist from the database.
  ///
  /// Useful if data might have been changed from another part of the app.
  Future<void> refresh() async {
    AppLogger.instance.i('🔄 WatchlistNotifier: Refreshing data...');
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_loadWatchlist);
  }
}

/// The provider for the [WatchlistNotifier].
///
/// Use this in your UI to watch the state of the watchlist:
/// ```dart
/// final watchlistAsync = ref.watch(watchlistProvider);
/// ```
final watchlistProvider = AsyncNotifierProvider<WatchlistNotifier, List<WatchlistItem>>(() {
  return WatchlistNotifier();
});

/// A provider to quickly check if a specific stock is in the watchlist.
///
/// This is a [FutureProvider.family] that takes a stock [symbol] as input.
/// It is highly useful for the Dashboard or Search screens to determine
/// whether to show a filled or unfilled "star" icon for a stock.
final isInWatchlistProvider = FutureProvider.family<bool, String>((ref, symbol) async {
  final repository = ref.watch(watchlistRepositoryProvider);
  return await repository.isInWatchlist(symbol);
});
