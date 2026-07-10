import 'dart:async';

import '../../../../core/services/market_stream_service.dart';
import '../../../../core/utils/app_logger.dart';
import '../../domain/entities/market_index.dart';
import '../../domain/entities/market_overview.dart';
import '../../domain/entities/stock.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/mock_dashboard_datasource.dart';

/// Implementation of [DashboardRepository] for the Dashboard feature.
class DashboardRepositoryImpl implements DashboardRepository {
  final MockDashboardDatasource _datasource;
  final MarketStreamService _streamService = MarketStreamService.instance;

  DashboardRepositoryImpl(this._datasource);

  @override
  Future<MarketOverview> getMarketOverview() async {
    AppLogger.instance.d('📦 DashboardRepository: Fetching initial data...');

    // 1. Fetch the raw data (Models/Records) from the datasource
    final rawData = await _datasource.getMarketOverview();

    // 2. Map the raw data models to pure Domain entities
    final indices =
        rawData.indices
            .map(
              (m) => MarketIndex(
                name: m.name,
                symbol: m.symbol,
                value: m.value,
                change: m.change,
                changePercent: m.changePercent,
                sparklineData: m.sparklineData,
              ),
            )
            .toList();

    final topGainers =
        rawData.topGainers
            .map(
              (m) => Stock(
                symbol: m.symbol,
                companyName: m.companyName,
                currentPrice: m.currentPrice,
                change: m.change,
                changePercent: m.changePercent,
                volume: m.volume,
              ),
            )
            .toList();

    final topLosers =
        rawData.topLosers
            .map(
              (m) => Stock(
                symbol: m.symbol,
                companyName: m.companyName,
                currentPrice: m.currentPrice,
                change: m.change,
                changePercent: m.changePercent,
                volume: m.volume,
              ),
            )
            .toList();

    // 3. Return the clean Domain entity
    return MarketOverview(
      indices: indices,
      topGainers: topGainers,
      topLosers: topLosers,
      lastUpdated: DateTime.now(),
    );
  }

  @override
  Stream<MarketOverview> watchMarketOverview() {
    AppLogger.instance.i('📡 DashboardRepository: Starting live market stream...');

    // We use a StreamController to manage the live updates
    final controller = StreamController<MarketOverview>();

    // 1. Fetch initial data to populate the first state
    getMarketOverview().then((initialOverview) {
      controller.add(initialOverview);

      // 2. Collect all symbols we want to track live
      final List<String> symbolsToTrack = [
        ...initialOverview.indices.map((i) => i.symbol),
        ...initialOverview.topGainers.map((s) => s.symbol),
        ...initialOverview.topLosers.map((s) => s.symbol),
      ];

      // 3. Subscribe to the live price stream
      final subscription = _streamService.getPriceStream(symbolsToTrack).listen((priceUpdates) {
        // 4. Map the price updates to a new MarketOverview entity
        final updatedOverview = _applyPriceUpdates(initialOverview, priceUpdates);

        // Emit the updated overview to the UI
        controller.add(updatedOverview);
      });

      // Clean up subscription when the stream is closed
      controller.onCancel = () {
        subscription.cancel();
        AppLogger.instance.d('📡 DashboardRepository: Stream subscription cancelled.');
      };
    });

    return controller.stream;
  }

  /// Helper method to apply live price ticks to the initial overview data.
  MarketOverview _applyPriceUpdates(MarketOverview original, Map<String, double> priceUpdates) {
    // Update Indices
    final updatedIndices =
        original.indices.map((index) {
          if (priceUpdates.containsKey(index.symbol)) {
            final newPrice = priceUpdates[index.symbol]!;
            return MarketIndex(
              name: index.name,
              symbol: index.symbol,
              value: newPrice,
              change: index.change, // Keeping change static for mock simplicity
              changePercent: index.changePercent,
              sparklineData: index.sparklineData,
            );
          }
          return index;
        }).toList();

    // Update Stocks (Gainers/Losers)
    List<Stock> updateStocks(List<Stock> stocks) {
      return stocks.map((stock) {
        if (priceUpdates.containsKey(stock.symbol)) {
          return stock.copyWith(currentPrice: priceUpdates[stock.symbol]!);
        }
        return stock;
      }).toList();
    }

    return MarketOverview(
      indices: updatedIndices,
      topGainers: updateStocks(original.topGainers),
      topLosers: updateStocks(original.topLosers),
      lastUpdated: DateTime.now(),
    );
  }
}
