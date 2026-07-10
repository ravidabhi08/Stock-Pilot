import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/app_logger.dart';
import '../../data/datasources/mock_stock_detail_datasource.dart';
import '../../data/repositories/stock_detail_repository_impl.dart';
import '../../domain/entities/stock_detail.dart';
import '../../domain/repositories/stock_detail_repository.dart';

/// Provides the [MockStockDetailDatasource] instance.
final mockStockDetailDatasourceProvider = Provider<MockStockDetailDatasource>((ref) {
  return MockStockDetailDatasource();
});

/// Provides the [StockDetailRepository] implementation.
final stockDetailRepositoryProvider = Provider<StockDetailRepository>((ref) {
  final datasource = ref.watch(mockStockDetailDatasourceProvider);
  return StockDetailRepositoryImpl(datasource);
});

/// Provides the stock detail data as an [AsyncValue].
///
/// This is a [FutureProvider.family] because it takes a [symbol] as a parameter.
/// This allows us to fetch details for any specific stock dynamically.
///
/// Usage in widgets:
/// ```dart
/// final stockDetailAsync = ref.watch(stockDetailProvider('RELIANCE'));
/// ```
final stockDetailProvider = FutureProvider.family<StockDetail, String>((ref, symbol) async {
  AppLogger.instance.i('🔄 StockDetail: Starting data fetch for $symbol...');

  final repository = ref.watch(stockDetailRepositoryProvider);

  try {
    AppLogger.instance.d('📡 StockDetail: Calling repository for $symbol...');
    final result = await repository.getStockDetail(symbol);

    AppLogger.instance.i('✅ StockDetail: Data fetched successfully for $symbol!');
    return result;
  } catch (e, stackTrace) {
    AppLogger.instance.e(
      '❌ StockDetail: Error fetching data for $symbol',
      error: e,
      stackTrace: stackTrace,
    );
    Error.throwWithStackTrace(e, stackTrace);
  }
});

/// Provides a refresh callback for a specific stock's detail data.
///
/// Usage in widgets:
/// ```dart
/// final refresh = ref.watch(stockDetailRefreshProvider('RELIANCE'));
/// await refresh();
/// ```
final stockDetailRefreshProvider = Provider.family<Future<void> Function(), String>((ref, symbol) {
  return () async {
    AppLogger.instance.i('🔄 StockDetail: Manual refresh triggered for $symbol');
    ref.invalidate(stockDetailProvider(symbol));
    // Wait for the new data to be fetched
    await ref.read(stockDetailProvider(symbol).future);
  };
});
