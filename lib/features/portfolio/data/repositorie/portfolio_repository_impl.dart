import 'package:stock_pilot/features/portfolio/data/models/holding_model.dart';

import '../../../../core/utils/app_logger.dart';
import '../../domain/entities/holding.dart';
import '../../domain/entities/portfolio_summary.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/mock_portfolio_datasource.dart';

/// Implementation of [PortfolioRepository] for the Portfolio feature.
///
/// This class is part of the Data layer and handles the actual data fetching
/// logic. It uses a data source (currently [MockPortfolioDatasource]) to
/// retrieve raw data, maps it to domain entities, and returns it to the
/// presentation layer.
///
/// The repository pattern allows us to:
/// - Swap data sources easily (mock → real API → cached data)
/// - Handle data transformation (models → entities)
/// - Centralize error handling for the feature
/// - Keep the domain layer independent of data sources
class PortfolioRepositoryImpl implements PortfolioRepository {
  /// The data source used to fetch raw portfolio data.
  final MockPortfolioDatasource _datasource;

  /// Creates a new [PortfolioRepositoryImpl] with the given data source.
  PortfolioRepositoryImpl(this._datasource);

  @override
  Future<PortfolioSummary> getPortfolio() async {
    AppLogger.instance.d('📦 PortfolioRepository: Fetching from datasource...');

    try {
      // Fetch raw data from the datasource
      final models = await _datasource.getPortfolio();
      AppLogger.instance.d('📦 PortfolioRepository: Got ${models.length} holdings from datasource');

      // Map data models to domain entities
      AppLogger.instance.d('📦 PortfolioRepository: Mapping models to entities...');
      final List<Holding> holdings = models.map((model) => model.toEntity()).toList();

      // Create the aggregate PortfolioSummary entity
      AppLogger.instance.d('📦 PortfolioRepository: Creating PortfolioSummary...');
      final summary = PortfolioSummary(holdings: holdings, lastUpdated: DateTime.now());

      AppLogger.instance.i('✅ PortfolioRepository: Successfully created PortfolioSummary');
      AppLogger.instance.d(
        '📊 PortfolioRepository: Total Investment: ₹${summary.totalInvestment.toStringAsFixed(2)}, '
        'Current Value: ₹${summary.totalCurrentValue.toStringAsFixed(2)}, '
        'P&L: ₹${summary.totalProfitLoss.toStringAsFixed(2)}',
      );

      return summary;
    } catch (e, stackTrace) {
      AppLogger.instance.e(
        '❌ PortfolioRepository: Error in getPortfolio',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<PortfolioSummary> refreshPortfolio() async {
    // For now, refresh uses the same logic as getPortfolio
    // In production, this might bypass cache and fetch fresh data from API
    return getPortfolio();
  }
}
