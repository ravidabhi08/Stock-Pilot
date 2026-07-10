import 'package:flutter/material.dart';

/// Defines the different screen form factors supported by the application.
enum ScreenType {
  /// Standard mobile phones (width < 600dp).
  mobile,

  /// Tablets and large foldables (600dp <= width < 1100dp).
  tablet,

  /// Desktops and large screens (width >= 1100dp).
  desktop,
}

/// Utility class for handling responsive design logic.
///
/// Provides methods to determine the current screen type based on width
/// and offers helper constants for breakpoints. This ensures the UI
/// adapts gracefully from small phones to large desktop monitors.
class ResponsiveUtils {
  const ResponsiveUtils._();

  // ─── Breakpoints ─────────────────────────────────────────

  /// Maximum width for a mobile device (portrait).
  static const double mobileBreakpoint = 600.0;

  /// Maximum width for a tablet device.
  static const double tabletBreakpoint = 1100.0;

  // ─── Screen Type Detection ───────────────────────────────

  /// Determines the [ScreenType] based on the given [width].
  static ScreenType getScreenType(double width) {
    if (width < mobileBreakpoint) {
      return ScreenType.mobile;
    } else if (width < tabletBreakpoint) {
      return ScreenType.tablet;
    } else {
      return ScreenType.desktop;
    }
  }

  /// Returns true if the screen is considered mobile.
  static bool isMobile(double width) => getScreenType(width) == ScreenType.mobile;

  /// Returns true if the screen is considered tablet.
  static bool isTablet(double width) => getScreenType(width) == ScreenType.tablet;

  /// Returns true if the screen is considered desktop.
  static bool isDesktop(double width) => getScreenType(width) == ScreenType.desktop;

  // ─── Layout Helpers ──────────────────────────────────────

  /// Returns the maximum width constraint for the main content area.
  ///
  /// Useful for centering content on large screens (tablets/desktops)
  /// to maintain readability and a premium layout structure.
  static double getMaxContentWidth(ScreenType type) {
    switch (type) {
      case ScreenType.mobile:
        return double.infinity; // Use full width
      case ScreenType.tablet:
        return 700.0;
      case ScreenType.desktop:
        return 1200.0;
    }
  }

  /// Calculates a scaled value based on screen width.
  ///
  /// Useful for adjusting font sizes or spacing dynamically.
  /// [baseValue] is the value designed for a standard mobile width (e.g., 375).
  static double scale(double baseValue, double screenWidth, {double baseWidth = 375.0}) {
    return baseValue * (screenWidth / baseWidth);
  }
}

/// Extension on [BuildContext] to provide easy access to responsive utilities.
///
/// Uses modern Flutter APIs (e.g., [MediaQuery.sizeOf]) to minimize
/// unnecessary widget rebuilds when unrelated media query properties change.
extension ResponsiveContext on BuildContext {
  /// Returns the current screen width.
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// Returns the current screen height.
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// Returns the current [ScreenType].
  ScreenType get screenType => ResponsiveUtils.getScreenType(screenWidth);

  /// Returns true if the current device is mobile.
  bool get isMobile => screenType == ScreenType.mobile;

  /// Returns true if the current device is tablet.
  bool get isTablet => screenType == ScreenType.tablet;

  /// Returns true if the current device is desktop.
  bool get isDesktop => screenType == ScreenType.desktop;

  /// Returns the maximum width for the main content area.
  double get maxContentWidth => ResponsiveUtils.getMaxContentWidth(screenType);

  /// Returns the view insets (e.g., keyboard height).
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  /// Returns the system padding (e.g., status bar, notch).
  EdgeInsets get systemPadding => MediaQuery.paddingOf(this);
}
