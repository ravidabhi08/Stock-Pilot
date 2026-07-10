import 'package:drift/drift.dart';

part 'drift_database.g.dart';

/// The main Drift database for StockPilot.
///
/// Used for structured, relational offline data storage such as
/// portfolio holdings, transaction history, and complex watchlists.
/// 
/// IMPORTANT: This file relies on code generation. Whenever you add or 
/// modify tables/DAOs here, you must run:
/// `dart run build_runner build --delete-conflicting-outputs`
@DriftDatabase(
  tables: [],
  daos: [],
)
class AppDatabase extends _$AppDatabase {
  /// Creates a new instance of [AppDatabase] with the given [QueryExecutor].
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}