import 'dart:async';
import 'dart:math';

import '../utils/app_logger.dart';

/// A core service that simulates a live market data feed (WebSocket).
///
/// This service generates continuous price updates (ticks) for a given list
/// of stock symbols. It is used to make the Dashboard and Portfolio feel
/// "alive" by updating prices in real-time.
///
/// In a production environment, this would be replaced by a real WebSocket
/// connection to a market data provider (e.g., Zerodha Kite Connect, Upstox).
class MarketStreamService {
  MarketStreamService._();
  static final MarketStreamService instance = MarketStreamService._();

  final Random _random = Random();

  /// A cache of the "last known price" for each symbol to ensure
  /// ticks are relative to the current price, not random jumps.
  final Map<String, double> _priceCache = {};

  /// Starts a live stream of price updates for the given [symbols].
  ///
  /// Returns a [Stream] that emits a [Map] of `{symbol: currentPrice}`
  /// every [interval] milliseconds (default: 2 seconds).
  ///
  /// The prices fluctuate by a small random percentage (-0.5% to +0.5%)
  /// on each tick to simulate realistic market movement.
  Stream<Map<String, double>> getPriceStream(
    List<String> symbols, {
    Duration interval = const Duration(seconds: 2),
  }) {
    AppLogger.instance.i(
      '📡 MarketStreamService: Starting live stream for ${symbols.length} symbols...',
    );

    // Initialize the cache with base prices if not already present
    for (var symbol in symbols) {
      if (!_priceCache.containsKey(symbol)) {
        // Generate a realistic base price (500 to 5000)
        _priceCache[symbol] = 500 + _random.nextDouble() * 4500;
      }
    }

    // Create a periodic stream that emits updates
    return Stream.periodic(interval, (count) {
      final Map<String, double> updates = {};

      for (var symbol in symbols) {
        final currentPrice = _priceCache[symbol]!;

        // Calculate a random fluctuation between -0.5% and +0.5%
        final fluctuationPercent = (_random.nextDouble() * 1.0) - 0.5;
        final change = currentPrice * (fluctuationPercent / 100);
        final newPrice = currentPrice + change;

        // Update the cache
        _priceCache[symbol] = newPrice;
        updates[symbol] = newPrice;
      }

      AppLogger.instance.d(
        '📡 MarketStreamService: Tick #$count - Updated ${updates.length} prices.',
      );
      return updates;
    });
  }

  /// Gets the current cached price for a symbol.
  /// Returns null if the symbol hasn't been streamed yet.
  double? getCurrentPrice(String symbol) {
    return _priceCache[symbol];
  }

  /// Seeds the internal price cache with known current prices.
  ///
  /// This is crucial for the Portfolio feature so that the live stream
  /// starts exactly at the user's actual current market price, rather
  /// than generating a random base price.
  void seedPrices(Map<String, double> prices) {
    _priceCache.addAll(prices);
    AppLogger.instance.d('💧 MarketStreamService: Seeded ${prices.length} initial prices.');
  }
}
