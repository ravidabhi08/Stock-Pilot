import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/app_logger.dart';
import '../../data/datasources/mock_portfolio_datasource.dart';
import '../../data/repositorie/portfolio_repository_impl.dart';
import '../../domain/entities/portfolio_summary.dart';
import '../../domain/repositories/portfolio_repository.dart';

/// Provides the [MockPortfolioDatasource] instance.
///
/// This datasource is currently used for development and testing.
/// In production, this would be replaced with a real API datasource.
final mockPortfolioDatasourceProvider = Provider<MockPortfolioDatasource>((ref) {
  return MockPortfolioDatasource();
});

/// Provides the [PortfolioRepository] implementation.
///
/// This provider wires up the repository with its datasource dependency,
/// following the Dependency Inversion Principle.
final portfolioRepositoryProvider = Provider<PortfolioRepository>((ref) {
  final datasource = ref.watch(mockPortfolioDatasourceProvider);
  return PortfolioRepositoryImpl(datasource);
});

/// Provides the portfolio summary data as an [AsyncValue].
///
/// This is the primary data provider for the Portfolio screen. It uses
/// [FutureProvider] to handle the three states of async data:
/// - **Loading**: Displays a loading indicator
/// - **Error**: Displays an error state with retry option
/// - **Data**: Displays the portfolio content
///
/// The provider automatically fetches data when first accessed and can be
/// refreshed using `ref.invalidate(portfolioSummaryProvider)`.
final portfolioSummaryProvider = FutureProvider<PortfolioSummary>((ref) async {
  AppLogger.instance.i('🔄 Portfolio: Starting data fetch...');

  final repository = ref.watch(portfolioRepositoryProvider);

  try {
    AppLogger.instance.d('📡 Portfolio: Calling repository...');
    final result = await repository.getPortfolio();

    AppLogger.instance.i('✅ Portfolio: Data fetched successfully!');
    AppLogger.instance.d(
      '📊 Portfolio: ${result.holdingsCount} holdings, '
      'Total Value: ₹${result.totalCurrentValue.toStringAsFixed(2)}, '
      'P&L: ₹${result.totalProfitLoss.toStringAsFixed(2)}',
    );

    return result;
  } catch (e, stackTrace) {
    AppLogger.instance.e('❌ Portfolio: Error fetching data', error: e, stackTrace: stackTrace);
    Error.throwWithStackTrace(e, stackTrace);
  }
});

/// Provides a refresh callback for the portfolio data.
///
/// This provider returns a function that invalidates the [portfolioSummaryProvider],
/// triggering a fresh data fetch. This is useful for implementing pull-to-refresh
/// functionality in the UI.
final portfolioRefreshProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    AppLogger.instance.i('🔄 Portfolio: Manual refresh triggered');
    ref.invalidate(portfolioSummaryProvider);
    // Wait for the new data to be fetched
    await ref.read(portfolioSummaryProvider.future);
  };
});
