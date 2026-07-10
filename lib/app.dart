import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

/// The root widget of the StockPilot application.
///
/// Configures the [MaterialApp.router] with the application's theme,
/// routing, and global configurations. Uses [ConsumerWidget] to allow
/// seamless integration with Riverpod providers in the future (e.g.,
/// for dynamic theme switching).
class StockPilotApp extends ConsumerWidget {
  const StockPilotApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'StockPilot',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
