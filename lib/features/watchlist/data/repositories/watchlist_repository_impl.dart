import '../../../../core/utils/app_logger.dart';
import '../../domain/entities/watchlist_item.dart';
import '../../domain/repositories/watchlist_repository.dart';
import '../datasources/hive_watchlist_datasource.dart';

/// Implementation of [WatchlistRepository] for the Watchlist feature.
///
/// This class is part of the Data layer and handles the actual persistence logic.
/// It uses [HiveWatchlistDatasource] to read/write data to local storage,
/// ensuring the user's watchlist is saved on the device and available offline.
///
/// The repository pattern allows us to:
/// - Swap storage mechanisms easily (Hive → Drift → Cloud API)
/// - Handle data transformation (raw data → domain entities)
/// - Centralize logging and error handling for the feature
/// - Keep the domain layer independent of persistence details
class WatchlistRepositoryImpl implements WatchlistRepository {
  /// The local data source used for persistence.
  final HiveWatchlistDatasource _datasource;

  /// Creates a new [WatchlistRepositoryImpl] with the given data source.
  WatchlistRepositoryImpl(this._datasource);

  @override
  Future<List<WatchlistItem>> getWatchlist() async {
    AppLogger.instance.d('📦 WatchlistRepository: Fetching from Hive...');

    try {
      final items = await _datasource.getWatchlist();
      AppLogger.instance.d('📦 WatchlistRepository: Found ${items.length} items in watchlist');
      return items;
    } catch (e, stackTrace) {
      AppLogger.instance.e(
        '❌ WatchlistRepository: Error fetching watchlist',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> addToWatchlist(WatchlistItem item) async {
    AppLogger.instance.d('📦 WatchlistRepository: Adding ${item.symbol} to watchlist...');

    try {
      await _datasource.addToWatchlist(item);
      AppLogger.instance.i('✅ WatchlistRepository: Successfully added ${item.symbol}');
    } catch (e, stackTrace) {
      AppLogger.instance.e(
        '❌ WatchlistRepository: Error adding to watchlist',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> removeFromWatchlist(String symbol) async {
    AppLogger.instance.d(' WatchlistRepository: Removing $symbol from watchlist...');

    try {
      await _datasource.removeFromWatchlist(symbol);
      AppLogger.instance.i('✅ WatchlistRepository: Successfully removed $symbol');
    } catch (e, stackTrace) {
      AppLogger.instance.e(
        '❌ WatchlistRepository: Error removing from watchlist',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<bool> isInWatchlist(String symbol) async {
    AppLogger.instance.d('📦 WatchlistRepository: Checking if $symbol is in watchlist...');

    try {
      final exists = await _datasource.isInWatchlist(symbol);
      AppLogger.instance.d(
        '📦 WatchlistRepository: $symbol is ${exists ? 'in' : 'not in'} watchlist',
      );
      return exists;
    } catch (e, stackTrace) {
      AppLogger.instance.e(
        '❌ WatchlistRepository: Error checking watchlist status',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
