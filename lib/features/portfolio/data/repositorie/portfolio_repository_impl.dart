import 'dart:async';

import 'package:stock_pilot/features/portfolio/data/models/holding_model.dart';

import '../../../../core/services/market_stream_service.dart';
import '../../../../core/utils/app_logger.dart';
import '../../domain/entities/holding.dart';
import '../../domain/entities/portfolio_summary.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/mock_portfolio_datasource.dart';

/// Implementation of [PortfolioRepository] for the Portfolio feature.
class PortfolioRepositoryImpl implements PortfolioRepository {
  final MockPortfolioDatasource _datasource;
  final MarketStreamService _streamService = MarketStreamService.instance;

  PortfolioRepositoryImpl(this._datasource);

  @override
  Future<PortfolioSummary> getPortfolio() async {
    AppLogger.instance.d('📦 PortfolioRepository: Fetching from datasource...');
    
    try {
      final models = await _datasource.getPortfolio();
      final List<Holding> holdings = models.map((model) => model.toEntity()).toList();

      final summary = PortfolioSummary(
        holdings: holdings,
        lastUpdated: DateTime.now(),
      );
      
      return summary;
    } catch (e, stackTrace) {
      AppLogger.instance.e('❌ PortfolioRepository: Error in getPortfolio', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Stream<PortfolioSummary> watchPortfolio() {
    AppLogger.instance.i('📡 PortfolioRepository: Starting live portfolio stream...');

    final controller = StreamController<PortfolioSummary>();

    // 1. Fetch initial data
    getPortfolio().then((initialSummary) {
      controller.add(initialSummary);

      // 2. Seed the stream service with actual current prices to prevent random jumps
      final initialPrices = {
        for (var h in initialSummary.holdings) h.symbol: h.currentPrice
      };
      _streamService.seedPrices(initialPrices);

      // 3. Collect symbols to track
      final symbolsToTrack = initialSummary.holdings.map((h) => h.symbol).toList();

      // 4. Subscribe to the live stream
      final subscription = _streamService
          .getPriceStream(symbolsToTrack, interval: const Duration(seconds: 2))
          .listen((priceUpdates) {
        
        final updatedSummary = _applyPriceUpdates(initialSummary, priceUpdates);
        controller.add(updatedSummary);
      });

      controller.onCancel = () {
        subscription.cancel();
        AppLogger.instance.d('📡 PortfolioRepository: Stream subscription cancelled.');
      };
    });

    return controller.stream;
  }

  @override
  Future<PortfolioSummary> refreshPortfolio() async {
    return getPortfolio();
  }

  /// Helper method to apply live price ticks to the holdings.
  PortfolioSummary _applyPriceUpdates(
    PortfolioSummary original, 
    Map<String, double> priceUpdates,
  ) {
    final updatedHoldings = original.holdings.map((holding) {
      if (priceUpdates.containsKey(holding.symbol)) {
        return holding.withCurrentPrice(priceUpdates[holding.symbol]!);
      }
      return holding;
    }).toList();

    // PortfolioSummary automatically recalculates total P&L 
    // and current value based on the new holding prices!
    return PortfolioSummary(
      holdings: updatedHoldings,
      lastUpdated: DateTime.now(),
    );
  }
}