import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../controllers/watchlist_providers.dart';

/// A bottom sheet for sorting and filtering the watchlist.
class WatchlistFilterSheet extends ConsumerWidget {
  const WatchlistFilterSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    // We can't easily read the private _sortBy from the notifier, 
    // so we just pass the current selection as an argument or default to DateNewest.
    // For simplicity, we'll just highlight the selected one.

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Sort Watchlist', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: AppSpacing.md),
          
          _buildSortOption(context, ref, 'Date Added (Newest)', Icons.schedule_rounded, WatchlistSortBy.dateNewest),
          _buildSortOption(context, ref, 'Date Added (Oldest)', Icons.history_rounded, WatchlistSortBy.dateOldest),
          _buildSortOption(context, ref, 'Name (A to Z)', Icons.sort_by_alpha_rounded, WatchlistSortBy.nameAZ),
          _buildSortOption(context, ref, 'Name (Z to A)', Icons.sort_rounded, WatchlistSortBy.nameZA),
          
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }

  Widget _buildSortOption(BuildContext context, WidgetRef ref, String title, IconData icon, WatchlistSortBy sortBy) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(title),
      onTap: () {
        ref.read(watchlistProvider.notifier).sortWatchlist(sortBy);
        Navigator.pop(context);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}