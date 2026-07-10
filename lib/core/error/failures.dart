import 'package:flutter/foundation.dart';

/// Base class for all failures in the Domain layer.
///
/// Unlike [Exception]s which are thrown, [Failure]s are returned as values
/// (typically via an `Either<Failure, T>` pattern or similar result types).
/// This allows the Domain layer to handle errors explicitly without relying
/// on try-catch blocks, promoting a more functional and predictable architecture.
///
/// Using a `sealed class` (Dart 3+) enables exhaustive pattern matching
/// when handling these failures in the Presentation layer.
@immutable
sealed class Failure {
  /// A user-friendly message describing the failure.
  final String message;

  /// An optional error code (e.g., HTTP status code).
  final int? code;

  const Failure({required this.message, this.code});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          code == other.code;

  @override
  int get hashCode => message.hashCode ^ code.hashCode;

  @override
  String toString() => '$runtimeType(message: $message, code: $code)';
}

/// Failure resulting from a server-side error (e.g., 500 Internal Server Error).
class ServerFailure extends Failure {
  const ServerFailure({
    super.message = 'Something went wrong on our end. Please try again later.',
    super.code,
  });
}

/// Failure resulting from network connectivity issues or timeouts.
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'No internet connection. Please check your network settings.',
    super.code,
  });
}

/// Failure resulting from local database or cache operations.
class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Failed to load data from local storage.', super.code});
}

/// Failure resulting from authentication or authorization issues.
class AuthFailure extends Failure {
  const AuthFailure({super.message = 'Session expired. Please log in again.', super.code});
}

/// Failure resulting from invalid user input.
class ValidationFailure extends Failure {
  /// A map of field names to their specific validation error messages.
  final Map<String, String>? errors;

  const ValidationFailure({
    super.message = 'Please check your input and try again.',
    this.errors,
    super.code,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other && other is ValidationFailure && mapEquals(errors, other.errors);

  @override
  int get hashCode => super.hashCode ^ errors.hashCode;

  @override
  String toString() => 'ValidationFailure(message: $message, code: $code, errors: $errors)';
}

/// Failure resulting when a requested resource is not found.
class NotFoundFailure extends Failure {
  const NotFoundFailure({
    super.message = 'The requested resource was not found.',
    super.code = 404,
  });
}
