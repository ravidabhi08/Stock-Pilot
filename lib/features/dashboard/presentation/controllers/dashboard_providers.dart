import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/app_logger.dart';
import '../../data/datasources/mock_dashboard_datasource.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../domain/entities/market_overview.dart';
import '../../domain/repositories/dashboard_repository.dart';

/// Provides the [MockDashboardDatasource] instance.
final mockDashboardDatasourceProvider = Provider<MockDashboardDatasource>((ref) {
  return MockDashboardDatasource();
});

/// Provides the [DashboardRepository] implementation.
final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final datasource = ref.watch(mockDashboardDatasourceProvider);
  return DashboardRepositoryImpl(datasource);
});

/// Provides the market overview data as a continuous [Stream].
///
/// CHANGED: Upgraded from [FutureProvider] to [StreamProvider].
/// This allows the UI to receive continuous, real-time price updates.
/// Riverpod automatically handles the subscription and lifecycle.
///
/// The UI will rebuild automatically whenever the repository emits
/// a new [MarketOverview] entity with updated prices.
final marketOverviewProvider = StreamProvider<MarketOverview>((ref) {
  AppLogger.instance.i('🔄 Dashboard: Starting live market stream...');

  final repository = ref.watch(dashboardRepositoryProvider);

  // Return the stream directly.
  // Riverpod will listen to it and update the state on every tick.
  return repository.watchMarketOverview();
});

/// Provides a refresh callback for the market overview data.
///
/// For a [StreamProvider], invalidating it will cancel the current stream
/// and restart it from scratch, effectively acting as a "pull-to-refresh".
final marketOverviewRefreshProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    AppLogger.instance.i('🔄 Dashboard: Manual refresh triggered (Restarting stream)');
    ref.invalidate(marketOverviewProvider);
  };
});
