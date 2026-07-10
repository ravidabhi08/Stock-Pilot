import 'package:stock_pilot/features/stock_details/data/models/stock_detail_model.dart';

import '../../../../core/utils/app_logger.dart';
import '../../domain/entities/stock_detail.dart';
import '../../domain/repositories/stock_detail_repository.dart';
import '../datasources/mock_stock_detail_datasource.dart';

/// Implementation of [StockDetailRepository] for the Stock Details feature.
///
/// This class is part of the Data layer and handles the actual data fetching
/// logic. It uses a data source (currently [MockStockDetailDatasource]) to
/// retrieve raw data, maps it to domain entities, and returns it to the
/// presentation layer.
class StockDetailRepositoryImpl implements StockDetailRepository {
  /// The data source used to fetch raw stock detail data.
  final MockStockDetailDatasource _datasource;

  /// Creates a new [StockDetailRepositoryImpl] with the given data source.
  StockDetailRepositoryImpl(this._datasource);

  @override
  Future<StockDetail> getStockDetail(String symbol) async {
    AppLogger.instance.d(' StockDetailRepository: Fetching details for $symbol...');

    try {
      // Fetch raw data from the datasource
      final model = await _datasource.getStockDetail(symbol);
      AppLogger.instance.d('📦 StockDetailRepository: Got data for ${model.companyName}');

      // Map data model to domain entity
      AppLogger.instance.d(' StockDetailRepository: Mapping model to entity...');
      final entity = model.toEntity();

      AppLogger.instance.i('✅ StockDetailRepository: Successfully created StockDetail for $symbol');
      return entity;
    } catch (e, stackTrace) {
      AppLogger.instance.e(
        '❌ StockDetailRepository: Error fetching details for $symbol',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<StockDetail> refreshStockDetail(String symbol) async {
    // For the mock implementation, refresh uses the same logic as getStockDetail
    // In production, this might bypass cache and fetch fresh data from the API
    return getStockDetail(symbol);
  }
}
