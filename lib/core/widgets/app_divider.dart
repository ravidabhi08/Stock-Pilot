import 'package:flutter/material.dart';

/// A premium, consistent divider widget for StockPilot.
///
/// Provides a simple, themed horizontal line used to separate list items,
/// sections, or content blocks. It automatically adapts to the current
/// theme's divider color and supports optional indentation.
///
/// Usage:
/// ```dart
/// const AppDivider()
/// const AppDivider(indent: 16.0)
/// ```
class AppDivider extends StatelessWidget {
  /// The amount of empty space to the left of the divider.
  final double? indent;

  /// The amount of empty space to the right of the divider.
  final double? endIndent;

  /// The thickness of the divider line.
  final double? thickness;

  /// The color of the divider. If null, uses the theme's divider color.
  final Color? color;

  const AppDivider({super.key, this.indent, this.endIndent, this.thickness, this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Divider(
      height: 1, // Minimal vertical space occupied
      thickness: thickness ?? 1.0,
      indent: indent,
      endIndent: endIndent,
      color: color ?? theme.colorScheme.outlineVariant,
    );
  }
}

/// A vertical divider for separating content in rows.
///
/// Useful for separating actions in a bottom app bar or dividing
/// metrics in a horizontal layout.
class AppVerticalDivider extends StatelessWidget {
  /// The height of the vertical divider.
  final double? height;

  /// The thickness of the divider line.
  final double? thickness;

  /// The color of the divider. If null, uses the theme's divider color.
  final Color? color;

  const AppVerticalDivider({super.key, this.height, this.thickness, this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // VerticalDivider doesn't accept a `height` parameter in some SDK
    // versions; wrap it with SizedBox to enforce height when provided.
    final divider = VerticalDivider(
      width: 1, // Minimal horizontal space occupied
      thickness: thickness ?? 1.0,
      color: color ?? theme.colorScheme.outlineVariant,
    );

    return height != null ? SizedBox(height: height, child: divider) : divider;
  }
}
