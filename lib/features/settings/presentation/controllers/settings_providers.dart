import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/app_logger.dart';
import '../../data/datasources/hive_settings_datasource.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';

/// Provides the [HiveSettingsDatasource] instance.
///
/// This datasource handles local persistence using Hive.
final hiveSettingsDatasourceProvider = Provider<HiveSettingsDatasource>((ref) {
  return HiveSettingsDatasource();
});

/// Provides the [SettingsRepository] implementation.
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final datasource = ref.watch(hiveSettingsDatasourceProvider);
  return SettingsRepositoryImpl(datasource);
});

/// The state notifier for the Settings feature.
///
/// Manages the application settings state, handling loading, updating,
/// and persisting user preferences. It uses [StateNotifier] to provide
/// synchronous state updates while persisting changes to Hive in the background.
class SettingsNotifier extends StateNotifier<AppSettings> {
  final SettingsRepository _repository;

  SettingsNotifier(this._repository) : super(const AppSettings()) {
    // Load initial settings when the notifier is created
    _loadSettings();
  }

  /// Loads the current settings from the repository.
  Future<void> _loadSettings() async {
    AppLogger.instance.i('🔄 SettingsNotifier: Loading settings...');

    try {
      final settings = await _repository.getSettings();
      state = settings;
      AppLogger.instance.i('✅ SettingsNotifier: Settings loaded successfully.');
    } catch (e, stackTrace) {
      AppLogger.instance.e(
        '❌ SettingsNotifier: Error loading settings',
        error: e,
        stackTrace: stackTrace,
      );
      // Keep default settings if loading fails
    }
  }

  /// Updates the theme mode and persists the change.
  ///
  /// [index] should be 0 (System), 1 (Light), or 2 (Dark).
  Future<void> setThemeMode(int index) async {
    AppLogger.instance.d('🎨 SettingsNotifier: Setting theme mode to $index...');

    final updatedSettings = state.copyWith(themeModeIndex: index);
    state = updatedSettings;

    try {
      await _repository.saveSettings(updatedSettings);
      AppLogger.instance.i('✅ SettingsNotifier: Theme mode saved.');
    } catch (e, stackTrace) {
      AppLogger.instance.e(
        '❌ SettingsNotifier: Error saving theme mode',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Toggles push notifications and persists the change.
  Future<void> toggleNotifications(bool enabled) async {
    AppLogger.instance.d('🔔 SettingsNotifier: Toggling notifications to $enabled...');

    final updatedSettings = state.copyWith(isNotificationsEnabled: enabled);
    state = updatedSettings;

    try {
      await _repository.saveSettings(updatedSettings);
      AppLogger.instance.i('✅ SettingsNotifier: Notifications setting saved.');
    } catch (e, stackTrace) {
      AppLogger.instance.e(
        '❌ SettingsNotifier: Error saving notifications setting',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Toggles biometric authentication and persists the change.
  Future<void> toggleBiometric(bool enabled) async {
    AppLogger.instance.d('🔐 SettingsNotifier: Toggling biometric to $enabled...');

    final updatedSettings = state.copyWith(isBiometricEnabled: enabled);
    state = updatedSettings;

    try {
      await _repository.saveSettings(updatedSettings);
      AppLogger.instance.i('✅ SettingsNotifier: Biometric setting saved.');
    } catch (e, stackTrace) {
      AppLogger.instance.e(
        '❌ SettingsNotifier: Error saving biometric setting',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Toggles live market updates and persists the change.
  Future<void> toggleLiveUpdates(bool enabled) async {
    AppLogger.instance.d('📈 SettingsNotifier: Toggling live updates to $enabled...');

    final updatedSettings = state.copyWith(isLiveUpdatesEnabled: enabled);
    state = updatedSettings;

    try {
      await _repository.saveSettings(updatedSettings);
      AppLogger.instance.i('✅ SettingsNotifier: Live updates setting saved.');
    } catch (e, stackTrace) {
      AppLogger.instance.e(
        '❌ SettingsNotifier: Error saving live updates setting',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Resets all settings to their default values.
  Future<void> resetSettings() async {
    AppLogger.instance.i('🔄 SettingsNotifier: Resetting all settings...');

    try {
      final defaultSettings = await _repository.resetSettings();
      state = defaultSettings;
      AppLogger.instance.i('✅ SettingsNotifier: All settings reset to defaults.');
    } catch (e, stackTrace) {
      AppLogger.instance.e(
        '❌ SettingsNotifier: Error resetting settings',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Updates the user's profile name.
  Future<void> updateProfileName(String newName) async {
    AppLogger.instance.d('👤 SettingsNotifier: Updating name to $newName...');
    final updatedSettings = state.copyWith(userName: newName);
    state = updatedSettings;
    try {
      await _repository.saveSettings(updatedSettings);
    } catch (e, stackTrace) {
      AppLogger.instance.e('❌ Error saving name', error: e, stackTrace: stackTrace);
    }
  }

  /// Updates the user's profile image path.
  Future<void> updateProfileImage(String imagePath) async {
    AppLogger.instance.d('🖼️ SettingsNotifier: Updating profile image...');
    final updatedSettings = state.copyWith(profileImagePath: imagePath);
    state = updatedSettings;
    try {
      await _repository.saveSettings(updatedSettings);
    } catch (e, stackTrace) {
      AppLogger.instance.e('❌ Error saving image', error: e, stackTrace: stackTrace);
    }
  }
}

/// The provider for the [SettingsNotifier].
///
/// Use this in your UI to watch the settings state:
/// ```dart
/// final settings = ref.watch(settingsProvider);
/// ```
final settingsProvider = StateNotifierProvider<SettingsNotifier, AppSettings>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return SettingsNotifier(repository);
});

/// Provides the current [ThemeMode] based on the stored settings.
///
/// This is a derived provider that maps the integer theme mode index
/// to Flutter's [ThemeMode] enum. The [MaterialApp] watches this provider
/// to apply the correct theme globally.
///
/// Usage in MaterialApp:
/// ```dart
/// MaterialApp(
///   themeMode: ref.watch(themeModeProvider),
/// )
/// ```
final themeModeProvider = Provider<ThemeMode>((ref) {
  final settings = ref.watch(settingsProvider);

  // Map the stored index to ThemeMode enum
  switch (settings.themeModeIndex) {
    case 0:
      return ThemeMode.system;
    case 1:
      return ThemeMode.light;
    case 2:
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
});
