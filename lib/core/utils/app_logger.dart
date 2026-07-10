import 'package:logger/logger.dart';

import '../config/env_config.dart';

/// Centralized, environment-aware logging utility for StockPilot.
class AppLogger {
  AppLogger._();

  static final AppLogger _instance = AppLogger._();

  /// Returns the singleton instance of [AppLogger].
  static AppLogger get instance => _instance;

  static late final Logger _logger;

  /// Initializes the logger configuration.
  static void init() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      ),
      level: EnvConfig.isDebug ? Level.trace : Level.error,
    );
  }

  /// Logs a trace/verbose level message.
  void v(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.t(message, error: error, stackTrace: stackTrace);
  }

  /// Logs a debug level message.
  void d(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// Logs an info level message.
  void i(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// Logs a warning level message.
  void w(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// Logs an error level message.
  void e(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Logs a fatal level message.
  void wtf(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }
}
