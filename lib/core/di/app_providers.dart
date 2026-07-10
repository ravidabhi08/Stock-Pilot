import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/dio_client.dart';
import '../services/drift_database.dart';

/// Centralized Dependency Injection providers for core services.
///
/// These providers manage the lifecycle of singleton services like
/// the network client and local database, ensuring they are instantiated
/// only once and properly disposed of when no longer needed.
///
/// Using top-level providers is the idiomatic Riverpod approach, allowing
/// for easy overriding in tests and clean dependency resolution.

/// Provides the configured [DioClient] instance for network requests.
final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

/// Provides the [AppDatabase] instance for local structured storage.
///
/// NOTE: Currently uses an in-memory database for the foundation phase
/// to ensure compilation without requiring additional path dependencies.
/// For production, replace `NativeDatabase.memory()` with a file-based
/// database using `NativeDatabase(File(path))` and `path_provider`.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase(NativeDatabase.memory());

  ref.onDispose(() {
    db.close();
  });

  return db;
});
