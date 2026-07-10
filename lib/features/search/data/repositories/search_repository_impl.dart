import '../../../../core/utils/app_logger.dart';
import '../../domain/entities/search_result.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/mock_search_datasource.dart';

/// Implementation of [SearchRepository] for the Search feature.
///
/// This class is part of the Data layer and handles the actual search logic.
/// It uses [MockSearchDatasource] to search through a local database of stocks.
///
/// In the future, this can easily be swapped out for an API-based implementation
/// without changing any of the UI or Domain layer code.
class SearchRepositoryImpl implements SearchRepository {
  /// The data source used to perform the actual search.
  final MockSearchDatasource _datasource;

  /// Creates a new [SearchRepositoryImpl] with the given data source.
  SearchRepositoryImpl(this._datasource);

  @override
  Future<List<SearchResult>> searchStocks(String query) async {
    AppLogger.instance.d('📦 SearchRepository: Searching for "$query"...');

    try {
      // Delegate the search to the datasource
      final results = await _datasource.searchStocks(query);

      AppLogger.instance.d('📦 SearchRepository: Found ${results.length} results.');
      return results;
    } catch (e, stackTrace) {
      AppLogger.instance.e(
        '❌ SearchRepository: Error searching stocks',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
