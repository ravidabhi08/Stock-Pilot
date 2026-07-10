import 'package:dio/dio.dart';

import '../config/env_config.dart';
import 'api_interceptors.dart';

/// Configures and provides the [Dio] HTTP client instance.
///
/// This class centralizes the setup of the networking layer, including
/// base URLs, timeouts, and the interceptor chain (Logging, Error Handling, Auth).
/// It is designed to be instantiated via Dependency Injection.
class DioClient {
  /// The configured [Dio] instance.
  final Dio dio;

  /// Creates a new [DioClient] with the specified configuration.
  ///
  /// [tokenProvider] is an optional callback to fetch the authentication token.
  /// If provided, the [AuthInterceptor] is added to the interceptor chain.
  /// This allows the client to be used immediately in the foundation phase
  /// (without auth) and seamlessly upgraded when the Auth feature is implemented.
  DioClient({Future<String?> Function()? tokenProvider})
    : dio = Dio(
        BaseOptions(
          baseUrl: EnvConfig.baseUrl,
          connectTimeout: Duration(milliseconds: EnvConfig.connectTimeout),
          receiveTimeout: Duration(milliseconds: EnvConfig.receiveTimeout),
          headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
        ),
      ) {
    _setupInterceptors(tokenProvider);
  }

  /// Configures the interceptor chain for the [dio] instance.
  void _setupInterceptors(Future<String?> Function()? tokenProvider) {
    // 1. Logging: Must be first to log raw requests/responses
    dio.interceptors.add(LoggingInterceptor());

    // 2. Error Handling: Transforms DioExceptions into AppExceptions
    dio.interceptors.add(ErrorInterceptor());

    // 3. Authentication: Injects Bearer token if available
    if (tokenProvider != null) {
      dio.interceptors.add(AuthInterceptor(tokenProvider));
    }
  }
}
