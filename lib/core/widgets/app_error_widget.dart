import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import 'app_button.dart';

/// A premium, reusable error state widget for StockPilot.
///
/// Displays a centered layout with an icon, a descriptive title,
/// a detailed message, and an optional "Retry" action button.
/// This widget ensures that error states across the application
/// (e.g., network failures, server errors, empty states) are
/// handled consistently and provide a clear path for the user
/// to recover.
///
/// Usage:
/// ```dart
/// AppErrorWidget(
///   title: 'Connection Lost',
///   message: 'Please check your internet settings and try again.',
///   icon: Icons.wifi_off_rounded,
///   onRetry: () => ref.refresh(myProvider),
/// )
/// ```
class AppErrorWidget extends StatelessWidget {
  /// The primary heading for the error state.
  final String title;

  /// A detailed description of the error or suggested action.
  final String message;

  /// The icon to display (e.g., [Icons.error_outline], [Icons.wifi_off]).
  final IconData icon;

  /// Optional callback for the "Retry" button.
  /// If null, the button is hidden.
  final VoidCallback? onRetry;

  /// The label for the action button (defaults to "Try Again").
  final String actionLabel;

  const AppErrorWidget({
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.error_outline_rounded,
    this.onRetry,
    this.actionLabel = 'Try Again',
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
            Icon(icon, size: 64, color: theme.colorScheme.onSurfaceVariant.withOpacity(0.6)),
            const SizedBox(height: AppSpacing.lg),

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
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.xl),
              AppButton(
                text: actionLabel,
                onPressed: onRetry,
                variant: AppButtonVariant.outline,
                leadingIcon: Icons.refresh_rounded,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
