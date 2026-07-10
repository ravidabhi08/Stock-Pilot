import 'package:hive_flutter/hive_flutter.dart';

import '../config/app_constants.dart';
import '../error/exceptions.dart';
import '../utils/app_logger.dart';

/// Service class responsible for initializing and managing Hive boxes.
///
/// Hive is used for lightweight, high-performance key-value storage,
/// ideal for user settings, feature flags, and simple caching.
/// This service encapsulates the initialization logic and provides
/// access to the pre-configured boxes.
class HiveService {
  HiveService._();

  static late final Box _settingsBox;
  static late final Box _cacheBox;

  /// Initializes Hive and opens the required boxes.
  ///
  /// This must be called in [main] before the app starts.
  /// Throws a [CacheException] if initialization fails.
  static Future<void> init() async {
    try {
      await Hive.initFlutter();

      _settingsBox = await Hive.openBox(AppConstants.settingsBoxName);
      _cacheBox = await Hive.openBox(AppConstants.cacheBoxName);

      AppLogger.instance.i('Hive initialized successfully.');
    } catch (e, stackTrace) {
      AppLogger.instance.e('Failed to initialize Hive', error: e, stackTrace: stackTrace);
      throw const CacheException(message: 'Failed to initialize local storage.');
    }
  }

  /// Returns the box used for storing user settings and preferences.
  static Box get settingsBox => _settingsBox;

  /// Returns the box used for general caching (e.g., API responses).
  static Box get cacheBox => _cacheBox;

  /// Closes all open boxes.
  ///
  /// Useful for testing or when the app is being terminated gracefully.
  static Future<void> close() async {
    await _settingsBox.close();
    await _cacheBox.close();
    AppLogger.instance.i('Hive boxes closed.');
  }
}
