/// Barrel file for all core shared widgets in StockPilot.
///
/// This file exports all reusable UI components, allowing other parts
/// of the application to import them with a single, clean import statement:
///
/// ```dart
/// import 'package:stockpilot/core/widgets/widgets.dart';
/// ```
///
/// This improves code readability and maintainability by centralizing
/// widget exports and preventing duplicate import lines across features.

library;

export 'app_button.dart';
export 'app_card.dart';
export 'app_divider.dart';
export 'app_empty_state.dart';
export 'app_error_widget.dart';
export 'app_loader.dart';
export 'app_text_field.dart';
export 'stock_tile.dart';
