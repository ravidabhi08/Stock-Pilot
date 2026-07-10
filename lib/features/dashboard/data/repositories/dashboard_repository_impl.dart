import 'package:stock_pilot/features/dashboard/data/models/market_index_model.dart';
import 'package:stock_pilot/features/dashboard/data/models/stock_model.dart';

import '../../../../core/utils/app_logger.dart';
import '../../domain/entities/market_overview.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/mock_dashboard_datasource.dart';

/// Implementation of [DashboardRepository] for the Dashboard feature.
class DashboardRepositoryImpl implements DashboardRepository {
  final MockDashboardDatasource _datasource;

  DashboardRepositoryImpl(this._datasource);

  @override
  Future<MarketOverview> getMarketOverview() async {
    AppLogger.instance.d('📦 Repository: Fetching from datasource...');

    try {
      final response = await _datasource.getMarketOverview();
      AppLogger.instance.d('📦 Repository: Got response from datasource');

      AppLogger.instance.d('📦 Repository: Mapping ${response.indices.length} indices...');
      final indices = response.indices.map((model) => model.toEntity()).toList();

      AppLogger.instance.d('📦 Repository: Mapping ${response.topGainers.length} gainers...');
      final topGainers = response.topGainers.map((model) => model.toEntity()).toList();

      AppLogger.instance.d('📦 Repository: Mapping ${response.topLosers.length} losers...');
      final topLosers = response.topLosers.map((model) => model.toEntity()).toList();

      AppLogger.instance.d('📦 Repository: Creating MarketOverview entity...');
      final overview = MarketOverview(
        indices: indices,
        topGainers: topGainers,
        topLosers: topLosers,
        lastUpdated: DateTime.now(),
      );

      AppLogger.instance.i('✅ Repository: Successfully created MarketOverview');
      return overview;
    } catch (e, stackTrace) {
      AppLogger.instance.e(
        '❌ Repository: Error in getMarketOverview',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<MarketOverview> refreshMarketOverview() async {
    return getMarketOverview();
  }
}
