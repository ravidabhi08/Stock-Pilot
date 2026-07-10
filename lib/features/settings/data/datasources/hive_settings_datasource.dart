import 'package:hive/hive.dart';

import '../../domain/entities/app_settings.dart';

/// Local data source for application settings using Hive.
///
/// This datasource handles all local persistence operations for user preferences.
/// It stores [AppSettings] as a Map in a Hive box, ensuring that the user's
/// choices (theme, notifications, etc.) are saved on the device and persist
/// across app restarts.
///
/// By using Hive (a lightweight, fast key-value database), we provide an
/// instant, offline-first experience for settings management.
class HiveSettingsDatasource {
  /// The name of the Hive box used to store settings.
  static const String _boxName = 'settings_box';

  /// Keys for the settings Map stored in Hive.
  static const String _keyThemeMode = 'themeModeIndex';
  static const String _keyNotifications = 'isNotificationsEnabled';
  static const String _keyBiometric = 'isBiometricEnabled';
  static const String _keyLiveUpdates = 'isLiveUpdatesEnabled';

  // NEW KEYS
  static const String _keyUserName = 'userName';
  static const String _keyProfileImage = 'profileImagePath';

  Future<AppSettings> getSettings() async {
    final box = await _openBox();

    return AppSettings(
      themeModeIndex: box.get(_keyThemeMode, defaultValue: 0) as int,
      isNotificationsEnabled: box.get(_keyNotifications, defaultValue: true) as bool,
      isBiometricEnabled: box.get(_keyBiometric, defaultValue: false) as bool,
      isLiveUpdatesEnabled: box.get(_keyLiveUpdates, defaultValue: true) as bool,
      userName: box.get(_keyUserName, defaultValue: 'Rahul Sharma') as String,
      profileImagePath: box.get(_keyProfileImage, defaultValue: '') as String,
    );
  }

  Future<void> saveSettings(AppSettings settings) async {
    final box = await _openBox();

    await box.put(_keyThemeMode, settings.themeModeIndex);
    await box.put(_keyNotifications, settings.isNotificationsEnabled);
    await box.put(_keyBiometric, settings.isBiometricEnabled);
    await box.put(_keyLiveUpdates, settings.isLiveUpdatesEnabled);

    // SAVE NEW DATA
    await box.put(_keyUserName, settings.userName);
    await box.put(_keyProfileImage, settings.profileImagePath);
  }

  // ... (keep resetSettings logic)

  /// Opens the Hive box if it isn't already open, and returns the [Box] instance.
  Future<Box> _openBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box(_boxName);
    }
    return await Hive.openBox(_boxName);
  }

  Future<AppSettings> resetSettings() async {
    final box = await _openBox();

    // Clear all data from the box
    await box.clear();

    // Return default settings
    return const AppSettings();
  }
}
