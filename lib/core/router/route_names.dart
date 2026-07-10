/// Centralized route names for the application.
///
/// Using constants prevents magic strings, reduces typos, and makes
/// refactoring routes significantly easier. All route paths should be
/// defined here and referenced throughout the app.
class RouteNames {
  const RouteNames._();

  // ─── Initial / Auth ──────────────────────────────────────

  /// The initial route (Splash / Onboarding).
  static const String splash = '/';

  /// Authentication / Login screen.
  static const String login = '/login';

  // ─── Main Application Shell ──────────────────────────────

  /// The root shell route that hosts the bottom navigation bar.
  static const String shell = '/app';

  // ─── Bottom Navigation Tabs ──────────────────────────────

  /// Home / Market overview dashboard.
  static const String dashboard = '/dashboard';

  /// User's stock portfolio and holdings.
  static const String portfolio = '/portfolio';

  /// User's watchlist of tracked stocks.
  static const String watchlist = '/watchlist';

  /// App settings and profile management.
  static const String settings = '/settings';

  // ─── Deep Links / Details (Placeholders for future phases) ─

  /// Individual stock details page.
  /// Example usage: '/stock/RELIANCE'
  static const String stockDetails = '/stock/:symbol';

  /// News article details page.
  static const String newsDetails = '/news/:id';
}
