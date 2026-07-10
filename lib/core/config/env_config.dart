/// Defines the available runtime environments for the application.
enum Environment {
  /// Development environment for local testing.
  dev,

  /// Staging environment for pre-production testing.
  staging,

  /// Production environment for live users.
  prod,
}

/// Manages environment-specific configuration variables.
///
/// This class acts as a centralized source of truth for settings that
/// change between development, staging, and production builds, such as
/// API base URLs and timeout durations.
class EnvConfig {
  EnvConfig._();

  static Environment _environment = Environment.dev;

  /// Initializes the environment configuration.
  ///
  /// This should be called once in [main] before the app starts.
  /// Currently defaults to [Environment.dev]. In a CI/CD pipeline,
  /// this could be overridden via --dart-define.
  static Future<void> init() async {
    // In a real CI/CD setup, you might use:
    // const String envName = String.fromEnvironment('ENV', defaultValue: 'dev');
    // _environment = Environment.values.firstWhere((e) => e.name == envName);

    _environment = Environment.dev;
  }

  /// Returns the current active environment.
  static Environment get environment => _environment;

  /// Returns true if the app is running in production.
  static bool get isProduction => _environment == Environment.prod;

  /// Returns true if the app is running in development or staging.
  static bool get isDebug => _environment != Environment.prod;

  /// The base URL for all API requests.
  static String get baseUrl {
    switch (_environment) {
      case Environment.prod:
        return 'https://api.stockpilot.in/v1';
      case Environment.staging:
        return 'https://staging-api.stockpilot.in/v1';
      case Environment.dev:
      default:
        return 'https://dev-api.stockpilot.in/v1';
    }
  }

  /// Connection timeout duration for network requests (in milliseconds).
  static int get connectTimeout => isProduction ? 15000 : 30000;

  /// Receive timeout duration for network requests (in milliseconds).
  static int get receiveTimeout => isProduction ? 15000 : 30000;
}
