import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/portfolio/presentation/pages/portfolio_page.dart';
import '../../features/stock_details/presentation/pages/stock_detail_page.dart';
import '../../features/watchlist/presentation/pages/watchlist_page.dart';
import 'route_names.dart';

/// Centralized routing configuration for StockPilot.
class AppRouter {
  AppRouter._();

  /// The global [GoRouter] instance.
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.dashboard,
    debugLogDiagnostics: true,
    routes: [
      // ─── 1. Initial Route (Splash) ─────────────────────────
      GoRoute(
        path: RouteNames.splash,
        name: 'splash',
        builder:
            (context, state) => const _PlaceholderPage(
              title: 'StockPilot',
              subtitle: 'Initializing...',
              icon: Icons.rocket_launch_rounded,
            ),
      ),

      // ─── 2. Main Application Shell (Bottom Navigation) ─────
      ShellRoute(
        builder: (context, state, child) {
          return _AppShell(child: child);
        },
        routes: [
          GoRoute(
            path: RouteNames.dashboard,
            name: 'dashboard',
            builder: (context, state) => const DashboardPage(),
          ),
          GoRoute(
            path: RouteNames.portfolio,
            name: 'portfolio',
            builder: (context, state) => const PortfolioPage(),
          ),
          GoRoute(
            path: RouteNames.watchlist,
            name: 'watchlist',
            builder: (context, state) => const WatchlistPage(),
          ),
          GoRoute(
            path: RouteNames.settings,
            name: 'settings',
            builder:
                (context, state) => const _PlaceholderPage(
                  title: 'Settings',
                  subtitle: 'Preferences & Account',
                  icon: Icons.settings_rounded,
                ),
          ),
        ],
      ),

      // ─── 3. Detail Routes (Pushed over the Shell) ──────────
      GoRoute(
        path: '/stock/:symbol',
        name: 'stock_detail',
        builder: (context, state) {
          // Extract the symbol from the URL path parameters
          final String symbol = state.pathParameters['symbol']!;
          return StockDetailPage(symbol: symbol);
        },
      ),
    ],
  );
}

// ─ Private Routing Widgets ────────────────────────────────────

/// The persistent shell widget that hosts the Bottom Navigation Bar.
class _AppShell extends StatelessWidget {
  final Widget child;

  const _AppShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (index) => _onItemTapped(index, context),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.pie_chart_outline),
            selectedIcon: Icon(Icons.pie_chart_rounded),
            label: 'Portfolio',
          ),
          NavigationDestination(
            icon: Icon(Icons.star_outline),
            selectedIcon: Icon(Icons.star_rounded),
            label: 'Watchlist',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    if (location.startsWith(RouteNames.dashboard)) return 0;
    if (location.startsWith(RouteNames.portfolio)) return 1;
    if (location.startsWith(RouteNames.watchlist)) return 2;
    if (location.startsWith(RouteNames.settings)) return 3;

    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.goNamed('dashboard');
        break;
      case 1:
        context.goNamed('portfolio');
        break;
      case 2:
        context.goNamed('watchlist');
        break;
      case 3:
        context.goNamed('settings');
        break;
    }
  }
}

/// A temporary placeholder page used for unimplemented features.
class _PlaceholderPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _PlaceholderPage({required this.title, required this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: theme.colorScheme.primary),
            const SizedBox(height: 24),
            Text(
              title,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
