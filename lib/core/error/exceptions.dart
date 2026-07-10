/// Base class for all application-specific exceptions.
///
/// All custom exceptions in the application should extend this class
/// to provide a unified way of handling errors across different layers
/// (Data, Domain, Presentation).
class AppException implements Exception {
  /// A descriptive message explaining the exception.
  final String message;

  /// An optional error code (e.g., HTTP status code, custom error code).
  final int? code;

  /// Optional stack trace for debugging purposes.
  final StackTrace? stackTrace;

  const AppException({required this.message, this.code, this.stackTrace});

  @override
  String toString() => 'AppException(code: $code, message: $message)';
}

/// Exception thrown when a server/API request fails.
///
/// Typically used in the Data layer when a [DioException] or similar
/// network error occurs while communicating with the backend.
class ServerException extends AppException {
  const ServerException({required super.message, super.code, super.stackTrace});

  @override
  String toString() => 'ServerException(code: $code, message: $message)';
}

/// Exception thrown when there is no network connectivity or a timeout occurs.
class NetworkException extends AppException {
  const NetworkException({
    super.message = 'No internet connection. Please check your network settings.',
    super.code,
    super.stackTrace,
  });

  @override
  String toString() => 'NetworkException(code: $code, message: $message)';
}

/// Exception thrown when local cache operations (Hive, Drift) fail.
///
/// Used when reading from or writing to the local database fails,
/// indicating potential data corruption or storage issues.
class CacheException extends AppException {
  const CacheException({
    super.message = 'Failed to access local cache.',
    super.code,
    super.stackTrace,
  });

  @override
  String toString() => 'CacheException(code: $code, message: $message)';
}

/// Exception thrown when an authentication or authorization error occurs.
///
/// Examples include expired tokens, invalid credentials, or insufficient
/// permissions to access a specific resource.
class AuthenticationException extends AppException {
  const AuthenticationException({
    super.message = 'Authentication failed. Please log in again.',
    super.code,
    super.stackTrace,
  });

  @override
  String toString() => 'AuthenticationException(code: $code, message: $message)';
}

/// Exception thrown when user input fails validation rules.
///
/// Used in the Domain or Presentation layer to signal that provided
/// data does not meet the required criteria (e.g., invalid email format,
/// empty required fields).
class ValidationException extends AppException {
  /// A map of field names to their specific validation error messages.
  final Map<String, String>? errors;

  const ValidationException({
    super.message = 'Validation failed. Please check your input.',
    this.errors,
    super.code,
    super.stackTrace,
  });

  @override
  String toString() => 'ValidationException(code: $code, message: $message, errors: $errors)';
}

/// Exception thrown when a requested resource is not found.
///
/// Typically maps to HTTP 404 errors.
class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'The requested resource was not found.',
    super.code = 404,
    super.stackTrace,
  });

  @override
  String toString() => 'NotFoundException(code: $code, message: $message)';
}
