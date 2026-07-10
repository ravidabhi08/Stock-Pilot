import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

/// A reusable, premium settings tile widget.
///
/// This widget supports three types of settings items:
/// 1. **Navigation Tile**: Tappable tile with a chevron icon (e.g., "Edit Profile")
/// 2. **Toggle Tile**: Tile with a switch for boolean settings (e.g., "Enable Notifications")
/// 3. **Info Tile**: Non-interactive tile for displaying information (e.g., "Version 1.0.0")
///
/// The design follows premium fintech app patterns with clean typography,
/// proper spacing, and semantic color usage.
///
/// Usage:
/// ```dart
/// // Navigation tile
/// SettingsTile(
///   icon: Icons.person_rounded,
///   title: 'Edit Profile',
///   subtitle: 'Update your personal information',
///   onTap: () => print('Tapped'),
/// )
///
/// // Toggle tile
/// SettingsTile(
///   icon: Icons.notifications_rounded,
///   title: 'Push Notifications',
///   subtitle: 'Receive market alerts',
///   toggleValue: true,
///   onToggleChanged: (value) => print('Toggled: $value'),
/// )
///
/// // Info tile
/// SettingsTile(
///   icon: Icons.info_rounded,
///   title: 'App Version',
///   subtitle: '1.0.0',
/// )
/// ```
class SettingsTile extends StatelessWidget {
  /// The icon to display on the leading side.
  final IconData icon;

  /// The main title text.
  final String title;

  /// Optional subtitle text displayed below the title.
  final String? subtitle;

  /// Optional trailing text (e.g., "Light", "Dark", "System").
  final String? trailingText;

  /// Callback when the tile is tapped (for navigation tiles).
  final VoidCallback? onTap;

  /// Current toggle value (for toggle tiles).
  final bool? toggleValue;

  /// Callback when the toggle changes (for toggle tiles).
  final ValueChanged<bool>? onToggleChanged;

  /// Optional color for the icon. If null, uses theme primary color.
  final Color? iconColor;

  /// Whether to show a divider below the tile.
  final bool showDivider;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailingText,
    this.onTap,
    this.toggleValue,
    this.onToggleChanged,
    this.iconColor,
    this.showDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasToggle = toggleValue != null && onToggleChanged != null;
    final isInteractive = onTap != null || hasToggle;

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: AppRadius.card,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              child: Row(
                children: [
                  // 1. Leading Icon
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: (iconColor ?? theme.colorScheme.primary).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, size: 20, color: iconColor ?? theme.colorScheme.primary),
                  ),

                  const SizedBox(width: AppSpacing.md),

                  // 2. Title & Subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            subtitle!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // 3. Trailing (Toggle, Text, or Chevron)
                  if (hasToggle)
                    Switch.adaptive(
                      value: toggleValue!,
                      onChanged: onToggleChanged,
                      activeColor: theme.colorScheme.primary,
                    )
                  else if (trailingText != null)
                    Text(
                      trailingText!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  else if (onTap != null)
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 24,
                      color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
                    ),
                ],
              ),
            ),
          ),
        ),

        // 4. Optional Divider
        if (showDivider)
          Padding(
            padding: const EdgeInsets.only(left: 72), // Align with title
            child: Divider(
              height: 1,
              thickness: 1,
              color: theme.colorScheme.outlineVariant.withOpacity(0.3),
            ),
          ),
      ],
    );
  }
}
