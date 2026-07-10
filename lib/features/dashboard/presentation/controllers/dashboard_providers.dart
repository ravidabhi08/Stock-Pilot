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

/// Provides the market overview data as an [AsyncValue].
final marketOverviewProvider = FutureProvider<MarketOverview>((ref) async {
  AppLogger.instance.i('🔄 Dashboard: Starting data fetch...');
  
  final repository = ref.watch(dashboardRepositoryProvider);
  
  try {
    AppLogger.instance.d('📡 Dashboard: Calling repository...');
    final result = await repository.getMarketOverview();
    AppLogger.instance.i('✅ Dashboard: Data fetched successfully!');
    AppLogger.instance.d('📊 Dashboard: ${result.indices.length} indices, ${result.topGainers.length} gainers, ${result.topLosers.length} losers');
    return result;
  } catch (e, stackTrace) {
    AppLogger.instance.e('❌ Dashboard: Error fetching data', error: e, stackTrace: stackTrace);
    Error.throwWithStackTrace(e, stackTrace);
  }
});

/// Provides a refresh callback for the market overview data.
final marketOverviewRefreshProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    AppLogger.instance.i('🔄 Dashboard: Manual refresh triggered');
    ref.invalidate(marketOverviewProvider);
    await ref.read(marketOverviewProvider.future);
  };
});