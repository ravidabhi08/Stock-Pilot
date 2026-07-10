import 'package:intl/intl.dart';

/// Global application-wide constants that remain consistent
/// across all environments.
class AppConstants {
  const AppConstants._();

  // ─── App Identity ────────────────────────────────────────
  static const String appName = 'StockPilot';
  static const String appTagline = 'Invest Smart. Track Smarter.';
  static const String defaultLocale = 'en_IN';

  // ─── Currency (Indian Rupee) ─────────────────────────────
  static const String currencySymbol = '₹';
  static const String currencyCode = 'INR';

  static final NumberFormat currencyFormat = NumberFormat.currency(
    locale: defaultLocale,
    symbol: currencySymbol,
    decimalDigits: 2,
  );

  static final NumberFormat compactCurrencyFormat = NumberFormat.compactCurrency(
    locale: defaultLocale,
    symbol: currencySymbol,
    decimalDigits: 2,
  );

  // ─── Number Formatting ───────────────────────────────────
  static final NumberFormat decimalFormat = NumberFormat.decimalPattern(defaultLocale);

  static final NumberFormat percentFormat = NumberFormat.percentPattern(defaultLocale);

  // ─── Date & Time Formats ─────────────────────────────────
  static const String dateFormatPattern = 'dd MMM yyyy';
  static const String timeFormatPattern = 'HH:mm:ss';
  static const String dateTimeFormatPattern = 'dd MMM yyyy, HH:mm';

  static DateFormat get dateFormat => DateFormat(dateFormatPattern);
  static DateFormat get timeFormat => DateFormat(timeFormatPattern);
  static DateFormat get dateTimeFormat => DateFormat(dateTimeFormatPattern);

  // ─── Pagination ──────────────────────────────────────────
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // ─── Animation Durations ─────────────────────────────────
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);

  // ─── Debounce / Throttle ─────────────────────────────────
  static const Duration searchDebounce = Duration(milliseconds: 400);
  static const Duration marketRefreshInterval = Duration(seconds: 5);

  // ─── Stock Market Timings (IST) ──────────────────────────
  static const int marketOpenHour = 9;
  static const int marketOpenMinute = 15;
  static const int marketCloseHour = 15;
  static const int marketCloseMinute = 30;

  // ─── Image & Asset Paths ─────────────────────────────────
  static const String assetsImagesPath = 'assets/images/';
  static const String assetsIconsPath = 'assets/icons/';
  static const String assetsLottiePath = 'assets/lottie/';

  // ─── Shared Preferences / Hive Box Names ─────────────────
  static const String settingsBoxName = 'stockpilot_settings';
  static const String cacheBoxName = 'stockpilot_cache';

  // ─── Validation Limits ───────────────────────────────────
  static const int minSearchQueryLength = 2;
  static const int maxWatchlistItems = 50;

  // ─── Chart Defaults ──────────────────────────────────────
  static const int defaultChartPoints = 30;
  static const double chartTooltipPadding = 8.0;
}
