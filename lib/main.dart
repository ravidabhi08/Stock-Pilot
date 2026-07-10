import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/config/env_config.dart';
import 'core/services/hive_service.dart';
import 'core/utils/app_logger.dart';

Future<void> main() async {
  // Ensure Flutter bindings are initialized before any async operations
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialize Environment Configuration
  await EnvConfig.init();

  // 2. Initialize Logger
  AppLogger.init();

  // 3. Initialize Hive for lightweight local storage
  await HiveService.init();

  // 4. Setup Global Error Handling
  FlutterError.onError = (errorDetails) {
    AppLogger.instance.e(
      'Flutter Error: ${errorDetails.exceptionAsString()}',
      error: errorDetails.exception,
      stackTrace: errorDetails.stack,
    );
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    AppLogger.instance.e('Uncaught Async Error: $error', error: error, stackTrace: stack);
    // Return true to prevent the default error handler from crashing the app
    return true;
  };

  // 5. Run the application wrapped in Riverpod's ProviderScope
  runApp(const ProviderScope(child: StockPilotApp()));
}
