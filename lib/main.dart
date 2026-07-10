import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_logger.dart'; // Ensure this import is present
import 'features/settings/presentation/controllers/settings_providers.dart';

void main() async {
  // 1. Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialize Hive for local storage
  await Hive.initFlutter();

  // 3. FIXED: Initialize the Logger before the app starts!
  AppLogger.init(); 

  // 4. Run the app
  runApp(
    const ProviderScope(
      child: StockPilotApp(),
    ),
  );
}

/// The root widget of the StockPilot application.
class StockPilotApp extends ConsumerWidget {
  const StockPilotApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the theme mode from settings
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'StockPilot',
      debugShowCheckedModeBanner: false,
      
      // Theme Configuration
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode, // Dynamically applied from settings
      
      // Router Configuration
      routerConfig: AppRouter.router,
    );
  }
}