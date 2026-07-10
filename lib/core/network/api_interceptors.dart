import 'package:dio/dio.dart';

import '../error/exceptions.dart';
import '../utils/app_logger.dart';

/// Interceptor responsible for injecting authentication tokens into requests.
///
/// It accepts a [tokenProvider] callback to fetch the current access token
/// asynchronously. This design allows for seamless integration with the
/// Authentication repository once implemented, without coupling this
/// interceptor to a specific storage mechanism.
class AuthInterceptor extends Interceptor {
  /// A callback function that returns the current access token.
  /// Returns `null` if the user is not authenticated.
  final Future<String?> Function() tokenProvider;

  AuthInterceptor(this.tokenProvider);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final String? token = await tokenProvider();
      
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
        AppLogger.instance.d('Auth Token injected successfully.');
      } else {
        AppLogger.instance.d('No Auth Token available. Request sent without auth.');
      }
    } catch (e) {
      AppLogger.instance.e('Error fetching Auth Token', error: e);
      // Proceed without token rather than failing the request immediately
    }

    handler.next(options);
  }
}

/// Interceptor responsible for logging HTTP requests and responses.
///
/// Uses the centralized [AppLogger] to provide detailed, formatted logs
/// in debug mode, helping developers debug network issues efficiently.
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.instance.i(
      '➡️ [${options.method}] ${options.uri}',
    );
    if (options.data != null) {
      AppLogger.instance.d('Request Data: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.instance.i(
      '⬅️ [${response.statusCode}] ${response.requestOptions.uri}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.instance.e(
      '❌ [${err.response?.statusCode ?? 'ERR'}] ${err.requestOptions.uri}',
      error: err.message,
    );
    handler.next(err);
  }
}

/// Interceptor responsible for transforming [DioException]s into
/// domain-specific [AppException]s.
///
/// This ensures that the rest of the application (Repositories, UseCases)
/// deals with clean, typed exceptions rather than Dio-specific error objects.
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final AppException appException = _mapDioErrorToAppException(err);
    
    // Reject with a new DioException containing our custom AppException
    // as the error payload.
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: appException,
        message: appException.message,
      ),
    );
  }

  /// Maps a [DioException] to the appropriate [AppException] subclass.
  AppException _mapDioErrorToAppException(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkException(
          message: 'Connection timed out. Please check your internet.',
        );
      
      case DioExceptionType.connectionError:
        return const NetworkException(
          message: 'No internet connection. Please try again later.',
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(err.response);

      case DioExceptionType.cancel:
        return const AppException(
          message: 'Request was cancelled.',
          code: -1,
        );

      case DioExceptionType.unknown:
      default:
        return const ServerException(
          message: 'An unexpected error occurred. Please try again.',
        );
    }
  }

  /// Handles HTTP error responses (4xx, 5xx) and maps them to specific exceptions.
  AppException _handleBadResponse(Response? response) {
    final int? statusCode = response?.statusCode;
    final dynamic data = response?.data;
    
    // Attempt to extract a message from the server response
    String serverMessage = 'Server error occurred.';
    if (data is Map<String, dynamic> && data.containsKey('message')) {
      serverMessage = data['message'].toString();
    }

    switch (statusCode) {
      case 400:
        return ServerException(
          message: serverMessage,
          code: 400,
        );
      case 401:
      case 403:
        return AuthenticationException(
          message: serverMessage,
          code: statusCode,
        );
      case 404:
        return NotFoundException(
          message: serverMessage,
          code: 404,
        );
      case 500:
      case 502:
      case 503:
        return ServerException(
          message: 'Server is currently unavailable. Please try later.',
          code: statusCode,
        );
      default:
        return ServerException(
          message: serverMessage,
          code: statusCode,
        );
    }
  }
}