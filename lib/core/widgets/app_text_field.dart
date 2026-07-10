import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_spacing.dart';

/// A premium, highly customizable text input field for StockPilot.
///
/// Wraps Material 3 [TextFormField] to provide a consistent API and
/// design language across all forms in the application (e.g., Login,
/// Search, Settings). It supports prefixes, suffixes, password toggling,
/// input formatting, and both internal validation and external error display.
///
/// Usage:
/// ```dart
/// AppTextField(
///   controller: _emailController,
///   hintText: 'Enter your email',
///   prefixIcon: Icons.email_outlined,
///   keyboardType: TextInputType.emailAddress,
///   validator: (value) => value!.isEmpty ? 'Email is required' : null,
/// )
/// ```
class AppTextField extends StatelessWidget {
  /// Controls the text being edited.
  final TextEditingController? controller;

  /// Hint text displayed when the field is empty.
  final String? hintText;

  /// Label text displayed above the field.
  final String? labelText;

  /// An icon displayed before the text input.
  final IconData? prefixIcon;

  /// A widget displayed after the text input (e.g., password visibility toggle).
  final Widget? suffixIcon;

  /// If true, obscures the text (useful for passwords).
  final bool obscureText;

  /// The type of keyboard to use for editing the text.
  final TextInputType? keyboardType;

  /// The action to take when the user presses the keyboard action button.
  final TextInputAction? textInputAction;

  /// Called when the user changes the text in the field.
  final ValueChanged<String>? onChanged;

  /// Called when the user indicates they are done editing the field.
  final ValueChanged<String>? onSubmitted;

  /// An optional function that validates the input and returns an error message.
  final String? Function(String?)? validator;

  /// An optional external error message to display (overrides validator).
  final String? errorText;

  /// If false, the text field will be disabled and non-interactive.
  final bool enabled;

  /// If true, the text field will not be editable but can be focused.
  final bool readOnly;

  /// Defines the keyboard focus for this widget.
  final FocusNode? focusNode;

  /// The maximum number of lines for the text field (defaults to 1).
  final int maxLines;

  /// If true, the text field will request focus when first built.
  final bool autofocus;

  /// Optional list of input formatters (e.g., for masking phone numbers).
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.errorText,
    this.enabled = true,
    this.readOnly = false,
    this.focusNode,
    this.maxLines = 1,
    this.autofocus = false,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          enabled: enabled,
          readOnly: readOnly,
          autofocus: autofocus,
          maxLines: maxLines,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          inputFormatters: inputFormatters,
          validator: validator,
          // If errorText is provided externally, it overrides the validator's result
          autovalidateMode:
              errorText != null ? AutovalidateMode.always : AutovalidateMode.onUserInteraction,
          style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurface),
          decoration: InputDecoration(
            hintText: hintText,
            // Use external errorText if provided, otherwise rely on validator
            errorText: errorText,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            suffixIcon: suffixIcon,
            // Ensure the internal decoration respects our theme's border radius
            border: theme.inputDecorationTheme.border,
            enabledBorder: theme.inputDecorationTheme.enabledBorder,
            focusedBorder: theme.inputDecorationTheme.focusedBorder,
            errorBorder:
                theme.inputDecorationTheme.errorBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: theme.colorScheme.error),
                ),
            focusedErrorBorder:
                theme.inputDecorationTheme.focusedErrorBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: theme.colorScheme.error, width: 1.5),
                ),
          ),
        ),
      ],
    );
  }
}
