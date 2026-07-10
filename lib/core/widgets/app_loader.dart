import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// A fullscreen loading overlay for StockPilot.
///
/// Displays a semi-transparent scrim over the entire screen with a
/// centered loading indicator. Useful for blocking user interaction
/// during critical, non-interruptible operations (e.g., authentication,
/// payment processing, or initial data fetching).
///
/// Usage:
/// ```dart
/// showDialog(
///   context: context,
///   barrierDismissible: false,
///   builder: (context) => const AppLoader(),
/// );
/// ```
class AppLoader extends StatelessWidget {
  /// Optional message to display below the loading indicator.
  final String? message;

  const AppLoader({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      // Prevents the user from dismissing the loader via the system back button
      canPop: false,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              if (message != null) ...[
                const SizedBox(height: AppSpacing.lg),
                Text(
                  message!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// A compact, inline loading indicator for StockPilot.
///
/// Displays a small [CircularProgressIndicator] alongside an optional
/// text message. Ideal for indicating loading states within specific
/// sections of a screen, such as paginated lists, search results,
/// or data refreshes, without blocking the entire UI.
class AppInlineLoader extends StatelessWidget {
  /// Optional text to display next to the spinner.
  final String? message;

  /// The size of the loading indicator.
  final double size;

  /// The stroke width of the loading indicator.
  final double strokeWidth;

  const AppInlineLoader({super.key, this.message, this.size = 24.0, this.strokeWidth = 2.5});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: size,
              width: size,
              child: CircularProgressIndicator(
                strokeWidth: strokeWidth,
                color: theme.colorScheme.primary,
              ),
            ),
            if (message != null) ...[
              const SizedBox(width: AppSpacing.md),
              Text(
                message!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
