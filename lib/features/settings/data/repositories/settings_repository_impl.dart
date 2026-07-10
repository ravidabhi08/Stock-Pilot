import '../../../../core/utils/app_logger.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/hive_settings_datasource.dart';

/// Implementation of [SettingsRepository] for the Settings feature.
///
/// This class is part of the Data layer and handles the actual persistence logic.
/// It uses [HiveSettingsDatasource] to read/write data to local storage,
/// ensuring the user's preferences are saved on the device and available offline.
///
/// The repository pattern allows us to:
/// - Swap storage mechanisms easily (Hive → SharedPreferences → Cloud API)
/// - Centralize logging and error handling for the feature
/// - Keep the domain layer independent of persistence details
class SettingsRepositoryImpl implements SettingsRepository {
  /// The local data source used for persistence.
  final HiveSettingsDatasource _datasource;

  /// Creates a new [SettingsRepositoryImpl] with the given data source.
  SettingsRepositoryImpl(this._datasource);

  @override
  Future<AppSettings> getSettings() async {
    AppLogger.instance.d('📦 SettingsRepository: Fetching settings from Hive...');

    try {
      final settings = await _datasource.getSettings();
      AppLogger.instance.d('📦 SettingsRepository: Successfully loaded settings.');
      return settings;
    } catch (e, stackTrace) {
      AppLogger.instance.e(
        '❌ SettingsRepository: Error fetching settings',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> saveSettings(AppSettings settings) async {
    AppLogger.instance.d('📦 SettingsRepository: Saving settings to Hive...');

    try {
      await _datasource.saveSettings(settings);
      AppLogger.instance.i('✅ SettingsRepository: Successfully saved settings.');
    } catch (e, stackTrace) {
      AppLogger.instance.e(
        '❌ SettingsRepository: Error saving settings',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<AppSettings> resetSettings() async {
    AppLogger.instance.d('📦 SettingsRepository: Resetting settings to defaults...');

    try {
      final defaultSettings = await _datasource.resetSettings();
      AppLogger.instance.i('✅ SettingsRepository: Successfully reset settings.');
      return defaultSettings;
    } catch (e, stackTrace) {
      AppLogger.instance.e(
        '❌ SettingsRepository: Error resetting settings',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
