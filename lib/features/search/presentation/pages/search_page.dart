import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/app_loader.dart';
import '../controllers/search_providers.dart';
import '../widgets/search_tile.dart';

/// The main Search screen for finding and adding stocks.
///
/// Features a premium search bar, real-time debounced searching,
/// and a clean list of results with instant "Add to Watchlist" actions.
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Auto focus the search bar when the page opens for immediate typing
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  /// Triggers the search notifier whenever the text changes.
  void _onSearchChanged() {
    ref.read(searchProvider.notifier).search(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final searchAsync = ref.watch(searchProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
        title: TextField(
          controller: _searchController,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: 'Search stocks (e.g., Tata, Reliance)',
            hintStyle: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            suffixIcon:
                _searchController.text.isNotEmpty
                    ? IconButton(
                      icon: const Icon(Icons.clear_rounded),
                      onPressed: () {
                        _searchController.clear();
                        _focusNode.requestFocus();
                      },
                    )
                    : null,
          ),
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: searchAsync.when(
        loading: () => const AppLoader(message: 'Searching...'),
        error:
            (error, stackTrace) => AppErrorWidget(
              title: 'Search Failed',
              message: 'Could not fetch results. Please try again.',
              icon: Icons.error_outline_rounded,
              onRetry: () => ref.read(searchProvider.notifier).search(_searchController.text),
            ),
        data: (results) {
          // 1. Empty State (No query typed)
          if (_searchController.text.trim().isEmpty) {
            return const AppEmptyState(
              title: 'Find your next investment',
              message: 'Search for stocks by name or symbol to add them to your watchlist.',
              icon: Icons.search_rounded,
            );
          }

          // 2. No Results State
          if (results.isEmpty) {
            return AppEmptyState(
              title: 'No stocks found',
              message:
                  'We couldn\'t find any stocks matching "${_searchController.text}". Try a different keyword.',
              icon: Icons.search_off_rounded,
            );
          }

          // 3. Results List
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
            itemCount: results.length,
            itemBuilder: (context, index) {
              return SearchTile(result: results[index]);
            },
          );
        },
      ),
    );
  }
}
