import '../entities/app_settings.dart';

/// Abstract repository interface for application settings operations.
///
/// This interface defines the contract for managing the user's app preferences
/// in the Domain layer. It is implemented by the Data layer to provide
/// the actual persistence logic (in our case, using Hive for local storage).
///
/// The repository pattern separates the business logic (Domain) from the
/// data persistence implementation (Data), allowing for:
/// - Easy testing with mock implementations
/// - Swapping storage mechanisms without changing business logic
/// - Clear separation of concerns in Clean Architecture
abstract class SettingsRepository {
  /// Fetches the current application settings.
  ///
  /// Returns an [AppSettings] entity containing all user preferences.
  /// If no settings have been saved yet, it should return the default settings.
  Future<AppSettings> getSettings();

  /// Saves the application settings to persistent storage.
  ///
  /// Takes an [AppSettings] entity and persists it locally.
  /// This is called whenever the user changes a preference (e.g., toggles theme).
  Future<void> saveSettings(AppSettings settings);

  /// Resets all settings to their default values.
  ///
  /// Clears the persistent storage and returns the default [AppSettings].
  Future<AppSettings> resetSettings();
}