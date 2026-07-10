import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

/// Defines the visual style variants for the [AppButton].
enum AppButtonVariant {
  /// A filled button with primary color (High emphasis).
  primary,

  /// A filled button with secondary/tonal color (Medium emphasis).
  secondary,

  /// An outlined button with a border (Medium-Low emphasis).
  outline,

  /// A text-only button with no background or border (Low emphasis).
  text,
}

/// A premium, highly customizable button widget for StockPilot.
///
/// Wraps Material 3 button components to provide a consistent API
/// and design language across the application. Supports loading states,
/// icons, and multiple visual variants.
class AppButton extends StatelessWidget {
  /// The text label displayed on the button.
  final String text;

  /// The callback invoked when the button is tapped.
  /// If null, the button is considered disabled.
  final VoidCallback? onPressed;

  /// The visual variant of the button.
  final AppButtonVariant variant;

  /// If true, the button will expand to fill the maximum available width.
  final bool isExpanded;

  /// If true, displays a loading indicator and disables interactions.
  final bool isLoading;

  /// An optional icon to display before the text.
  final IconData? leadingIcon;

  /// An optional icon to display after the text.
  final IconData? trailingIcon;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isExpanded = false,
    this.isLoading = false,
    this.leadingIcon,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final Widget buttonContent = _buildContent(context);

    Widget button;
    switch (variant) {
      case AppButtonVariant.primary:
        button = ElevatedButton(onPressed: _handlePressed, child: buttonContent);
        break;
      case AppButtonVariant.secondary:
        button = FilledButton.tonal(onPressed: _handlePressed, child: buttonContent);
        break;
      case AppButtonVariant.outline:
        button = OutlinedButton(onPressed: _handlePressed, child: buttonContent);
        break;
      case AppButtonVariant.text:
        button = TextButton(onPressed: _handlePressed, child: buttonContent);
        break;
    }

    if (isExpanded) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }

  /// Builds the internal content (Icon + Text + LoadingIndicator).
  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);

    // If loading, show a small spinner instead of text/icons
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          color:
              variant == AppButtonVariant.outline || variant == AppButtonVariant.text
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onPrimary,
        ),
      );
    }

    final List<Widget> children = [];

    if (leadingIcon != null) {
      children.add(Icon(leadingIcon, size: 20));
      children.add(const SizedBox(width: AppSpacing.sm));
    }

    children.add(Text(text));

    if (trailingIcon != null) {
      children.add(const SizedBox(width: AppSpacing.sm));
      children.add(Icon(trailingIcon, size: 20));
    }

    return Row(mainAxisSize: MainAxisSize.min, children: children);
  }

  /// Handles the tap event, ensuring no action if loading or disabled.
  void _handlePressed() {
    if (!isLoading && onPressed != null) {
      onPressed!();
    }
  }
}
