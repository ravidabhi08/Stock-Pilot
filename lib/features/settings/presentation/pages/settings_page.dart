import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../controllers/settings_providers.dart';
import '../widgets/edit_profile_sheet.dart';
import '../widgets/profile_header.dart';
import '../widgets/settings_tile.dart';

/// The main Settings screen displaying user preferences and account options.
///
/// This page is the fourth tab in the bottom navigation. It displays:
/// - A premium profile header with user information
/// - Organized sections for different setting categories
/// - Interactive toggles for notifications, biometric, and live updates
/// - Theme selection dialog (System, Light, Dark)
/// - About section with app version and support links
///
/// The page uses Riverpod's [StateNotifierProvider] to handle settings state.
/// All changes are automatically persisted to Hive local storage.
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        children: [
          // 1. Profile Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: ProfileHeader(
              userName: settings.userName, // Use real data
              accountId: 'rahul.sharma@email.com',
              avatarUrl: settings.profileImagePath, // Pass the path
              onEditPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  builder: (context) => const EditProfileSheet(),
                );
              },
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // 2. Appearance Section
          _buildSectionHeader(context, 'Appearance'),
          SettingsTile(
            icon: Icons.palette_rounded,
            title: 'Theme',
            subtitle: 'Choose your preferred theme',
            trailingText: _getThemeName(settings.themeModeIndex),
            onTap: () => _showThemeDialog(context, ref, settings.themeModeIndex),
            showDivider: true,
          ),

          const SizedBox(height: AppSpacing.lg),

          // 3. Notifications Section
          _buildSectionHeader(context, 'Notifications'),
          SettingsTile(
            icon: Icons.notifications_rounded,
            title: 'Push Notifications',
            subtitle: 'Receive market alerts and updates',
            toggleValue: settings.isNotificationsEnabled,
            onToggleChanged: (value) {
              ref.read(settingsProvider.notifier).toggleNotifications(value);
            },
            showDivider: true,
          ),
          SettingsTile(
            icon: Icons.trending_up_rounded,
            title: 'Live Market Updates',
            subtitle: 'Real-time price changes',
            toggleValue: settings.isLiveUpdatesEnabled,
            onToggleChanged: (value) {
              ref.read(settingsProvider.notifier).toggleLiveUpdates(value);
            },
          ),

          const SizedBox(height: AppSpacing.lg),

          // 4. Security Section
          _buildSectionHeader(context, 'Security'),
          SettingsTile(
            icon: Icons.fingerprint_rounded,
            title: 'Biometric Login',
            subtitle: 'Use fingerprint or face ID',
            toggleValue: settings.isBiometricEnabled,
            onToggleChanged: (value) {
              ref.read(settingsProvider.notifier).toggleBiometric(value);
            },
            showDivider: true,
          ),
          SettingsTile(
            icon: Icons.lock_rounded,
            title: 'Change Password',
            subtitle: 'Update your account password',
            onTap: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Password change coming soon!')));
            },
          ),

          const SizedBox(height: AppSpacing.lg),

          // 5. About Section
          _buildSectionHeader(context, 'About'),
          const SettingsTile(
            icon: Icons.info_rounded,
            title: 'App Version',
            subtitle: '1.0.0 (Build 1)',
          ),
          SettingsTile(
            icon: Icons.help_rounded,
            title: 'Help & Support',
            subtitle: 'Get help with your account',
            onTap: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Support page coming soon!')));
            },
            showDivider: true,
          ),
          SettingsTile(
            icon: Icons.policy_rounded,
            title: 'Privacy Policy',
            subtitle: 'Read our privacy policy',
            onTap: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Privacy policy coming soon!')));
            },
            showDivider: true,
          ),
          SettingsTile(
            icon: Icons.description_rounded,
            title: 'Terms of Service',
            subtitle: 'Read our terms and conditions',
            onTap: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Terms of service coming soon!')));
            },
          ),

          const SizedBox(height: AppSpacing.xl),

          // 6. Reset & Logout
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
              children: [
                OutlinedButton.icon(
                  onPressed: () => _showResetDialog(context, ref),
                  icon: const Icon(Icons.restore_rounded),
                  label: const Text('Reset All Settings'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    foregroundColor: theme.colorScheme.error,
                    side: BorderSide(color: theme.colorScheme.error.withOpacity(0.5)),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                FilledButton.tonal(
                  onPressed: () {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('Logout coming soon!')));
                  },
                  style: FilledButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
                  child: const Text('Logout'),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }

  /// Builds a section header with proper styling.
  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: Text(
        title.toUpperCase(),
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  /// Returns a human-readable theme name based on the index.
  String _getThemeName(int index) {
    switch (index) {
      case 0:
        return 'System';
      case 1:
        return 'Light';
      case 2:
        return 'Dark';
      default:
        return 'System';
    }
  }

  /// Shows a dialog for selecting the theme mode.
  void _showThemeDialog(BuildContext context, WidgetRef ref, int currentIndex) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Choose Theme'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildThemeOption(
                  ctx,
                  ref,
                  0,
                  'System',
                  Icons.brightness_auto_rounded,
                  currentIndex,
                ),
                _buildThemeOption(ctx, ref, 1, 'Light', Icons.light_mode_rounded, currentIndex),
                _buildThemeOption(ctx, ref, 2, 'Dark', Icons.dark_mode_rounded, currentIndex),
              ],
            ),
            actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel'))],
          ),
    );
  }

  /// Builds a single theme option in the dialog.
  Widget _buildThemeOption(
    BuildContext context,
    WidgetRef ref,
    int index,
    String label,
    IconData icon,
    int currentIndex,
  ) {
    final theme = Theme.of(context);
    final isSelected = index == currentIndex;

    return RadioListTile<int>(
      value: index,
      groupValue: currentIndex,
      onChanged: (value) {
        if (value != null) {
          ref.read(settingsProvider.notifier).setThemeMode(value);
          Navigator.pop(context);
        }
      },
      // icon: Icon(icon, color: theme.colorScheme.primary),
      title: Text(label),
      activeColor: theme.colorScheme.primary,
    );
  }

  /// Shows a confirmation dialog for resetting all settings.
  void _showResetDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Reset All Settings?'),
            content: const Text(
              'This will reset all your preferences to their default values. This action cannot be undone.',
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
              FilledButton(
                onPressed: () {
                  ref.read(settingsProvider.notifier).resetSettings();
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('All settings reset to defaults')));
                },
                style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
                child: const Text('Reset'),
              ),
            ],
          ),
    );
  }
}
