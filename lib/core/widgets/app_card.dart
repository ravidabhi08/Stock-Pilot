import 'package:flutter/material.dart';

import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';

/// A premium, highly flexible card widget for StockPilot.
///
/// Provides a consistent container for grouping related content such as
/// stock items, portfolio holdings, market indices, or news cards.
///
/// Key features:
/// • Optional leading/trailing widgets for aligned layouts
/// • Built-in tap feedback using Material 3 [InkWell]
/// • Configurable padding, margin, and border radius
/// • Seamless integration with the app's light/dark theme
class AppCard extends StatelessWidget {
  /// The primary content of the card.
  final Widget child;

  /// An optional widget displayed before the main content (e.g., icon, avatar).
  final Widget? leading;

  /// An optional widget displayed after the main content (e.g., price, arrow).
  final Widget? trailing;

  /// Padding around the internal content.
  final EdgeInsetsGeometry? padding;

  /// External margin around the card.
  final EdgeInsetsGeometry? margin;

  /// Callback invoked when the card is tapped.
  /// If provided, enables tap feedback (ripple effect).
  final VoidCallback? onTap;

  /// Optional semantic label for accessibility.
  final String? semanticsLabel;

  const AppCard({
    super.key,
    required this.child,
    this.leading,
    this.trailing,
    this.padding,
    this.margin,
    this.onTap,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectivePadding = padding ?? const EdgeInsets.all(AppSpacing.md);
    final effectiveMargin = margin ?? EdgeInsets.zero;

    // Internal layout that handles leading/trailing alignment
    final Widget internalContent = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (leading != null) ...[leading!, const SizedBox(width: AppSpacing.md)],
        Expanded(child: child),
        if (trailing != null) ...[const SizedBox(width: AppSpacing.md), trailing!],
      ],
    );

    // Wrap in Container for visual styling (background, border, radius)
    final Widget styledCard = Container(
      margin: effectiveMargin,
      padding: effectivePadding,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: theme.colorScheme.outlineVariant, width: 1.0),
      ),
      child: leading == null && trailing == null ? child : internalContent,
    );

    // If interactive, wrap in Material + InkWell for proper ripple feedback
    if (onTap != null) {
      return Semantics(
        label: semanticsLabel,
        button: true,
        child: Material(
          color: Colors.transparent,
          borderRadius: AppRadius.card,
          clipBehavior: Clip.antiAlias,
          child: InkWell(onTap: onTap, borderRadius: AppRadius.card, child: styledCard),
        ),
      );
    }

    return styledCard;
  }
}
