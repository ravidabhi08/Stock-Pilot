import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/app_logger.dart';
import '../../data/datasources/mock_portfolio_datasource.dart';
import '../../data/repositorie/portfolio_repository_impl.dart';
import '../../domain/entities/portfolio_summary.dart';
import '../../domain/repositories/portfolio_repository.dart';

/// Provides the [MockPortfolioDatasource] instance.
final mockPortfolioDatasourceProvider = Provider<MockPortfolioDatasource>((ref) {
  return MockPortfolioDatasource();
});

/// Provides the [PortfolioRepository] implementation.
final portfolioRepositoryProvider = Provider<PortfolioRepository>((ref) {
  final datasource = ref.watch(mockPortfolioDatasourceProvider);
  return PortfolioRepositoryImpl(datasource);
});

/// Provides the portfolio summary data as a continuous [Stream].
///
/// CHANGED: Upgraded from [FutureProvider] to [StreamProvider].
/// This allows the UI to receive continuous, real-time price updates.
///
/// The UI will rebuild automatically whenever the repository emits
/// a new [PortfolioSummary] entity with updated prices.
final portfolioSummaryProvider = StreamProvider<PortfolioSummary>((ref) {
  AppLogger.instance.i('🔄 Portfolio: Starting live data stream...');

  final repository = ref.watch(portfolioRepositoryProvider);

  // Return the stream directly. Riverpod handles the rest.
  return repository.watchPortfolio();
});

/// Provides a refresh callback for the portfolio data.
final portfolioRefreshProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    AppLogger.instance.i('🔄 Portfolio: Manual refresh triggered (Restarting stream)');
    ref.invalidate(portfolioSummaryProvider);
  };
});
