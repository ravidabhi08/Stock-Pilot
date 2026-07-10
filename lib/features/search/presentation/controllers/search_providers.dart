import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/app_logger.dart';
import '../../data/datasources/mock_search_datasource.dart';
import '../../data/repositories/search_repository_impl.dart';
import '../../domain/entities/search_result.dart';
import '../../domain/repositories/search_repository.dart';

/// Provides the [MockSearchDatasource] instance.
final mockSearchDatasourceProvider = Provider<MockSearchDatasource>((ref) {
  return MockSearchDatasource();
});

/// Provides the [SearchRepository] implementation.
final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  final datasource = ref.watch(mockSearchDatasourceProvider);
  return SearchRepositoryImpl(datasource);
});

/// The state notifier for the Search feature.
///
/// Manages the search query and the resulting list of stocks.
/// It implements a **debouncing** mechanism to prevent excessive API calls
/// while the user is typing. It waits for 300ms after the user stops
/// typing before triggering the actual search.
class SearchNotifier extends AsyncNotifier<List<SearchResult>> {
  Timer? _debounceTimer;

  @override
  Future<List<SearchResult>> build() async {
    // Register cleanup logic when the provider is destroyed
    ref.onDispose(() {
      _debounceTimer?.cancel();
      AppLogger.instance.d('🧹 SearchNotifier: Timer cleaned up');
    });

    // Initial state is an empty list
    return [];
  }

  /// Triggers a search for the given [query].
  ///
  /// This method implements debouncing. If called multiple times in quick
  /// succession (e.g., while typing), it cancels the previous timer and
  /// starts a new one. The search only executes after 300ms of inactivity.
  void search(String query) {
    // Cancel the previous timer if it exists
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    // If the query is empty, immediately clear the results
    if (query.trim().isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    // Start a new timer
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      _executeSearch(query);
    });
  }

  /// The actual search execution logic.
  Future<void> _executeSearch(String query) async {
    AppLogger.instance.i('🔍 SearchNotifier: Executing search for "$query"...');

    state = const AsyncValue.loading();

    final repository = ref.read(searchRepositoryProvider);

    try {
      final results = await repository.searchStocks(query);
      state = AsyncValue.data(results);
      AppLogger.instance.i('✅ SearchNotifier: Search completed, found ${results.length} results.');
    } catch (e, stackTrace) {
      AppLogger.instance.e(
        '❌ SearchNotifier: Error during search',
        error: e,
        stackTrace: stackTrace,
      );
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

/// The provider for the [SearchNotifier].
///
/// Usage in widgets:
/// ```dart
/// final searchAsync = ref.watch(searchProvider);
/// ref.read(searchProvider.notifier).search('Tata');
/// ```
final searchProvider = AsyncNotifierProvider<SearchNotifier, List<SearchResult>>(() {
  return SearchNotifier();
});
