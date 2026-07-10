import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import 'app_button.dart';

/// A premium, reusable empty state widget for StockPilot.
///
/// Displays a centered layout with an icon, a descriptive title,
/// a helpful message, and an optional call-to-action button.
/// This widget ensures that empty states across the application
/// (e.g., empty watchlist, no search results, no portfolio holdings)
/// are handled consistently and guide the user toward meaningful actions.
///
/// Usage:
/// ```dart
/// AppEmptyState(
///   title: 'Your watchlist is empty',
///   message: 'Add stocks to track their performance in real-time.',
///   icon: Icons.star_outline_rounded,
///   actionLabel: 'Explore Stocks',
///   onAction: () => context.goNamed('dashboard'),
/// )
/// ```
class AppEmptyState extends StatelessWidget {
  /// The primary heading for the empty state.
  final String title;

  /// A helpful description or suggestion for the user.
  final String message;

  /// The icon to display (e.g., [Icons.star_outline], [Icons.search_off]).
  final IconData icon;

  /// Optional label for the action button.
  /// If null, the button is hidden.
  final String? actionLabel;

  /// Optional callback for the action button.
  final VoidCallback? onAction;

  /// Optional icon to display on the action button.
  final IconData? actionIcon;

  const AppEmptyState({
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
    this.actionIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 40,
                color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // 2. Title
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),

            // 3. Message
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            // 4. Action Button (Conditional)
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: AppSpacing.xl),
              AppButton(
                text: actionLabel!,
                onPressed: onAction,
                variant: AppButtonVariant.primary,
                leadingIcon: actionIcon,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
