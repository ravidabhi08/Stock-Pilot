import 'package:flutter/foundation.dart';

@immutable
class AppSettings {
  final int themeModeIndex;
  final bool isNotificationsEnabled;
  final bool isBiometricEnabled;
  final bool isLiveUpdatesEnabled;

  // NEW: Profile Data
  final String userName;
  final String profileImagePath;

  const AppSettings({
    this.themeModeIndex = 0,
    this.isNotificationsEnabled = true,
    this.isBiometricEnabled = false,
    this.isLiveUpdatesEnabled = true,
    this.userName = 'Rahul Sharma', // Default name
    this.profileImagePath = '', // Empty means show initial
  });

  AppSettings copyWith({
    int? themeModeIndex,
    bool? isNotificationsEnabled,
    bool? isBiometricEnabled,
    bool? isLiveUpdatesEnabled,
    String? userName,
    String? profileImagePath,
  }) {
    return AppSettings(
      themeModeIndex: themeModeIndex ?? this.themeModeIndex,
      isNotificationsEnabled: isNotificationsEnabled ?? this.isNotificationsEnabled,
      isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
      isLiveUpdatesEnabled: isLiveUpdatesEnabled ?? this.isLiveUpdatesEnabled,
      userName: userName ?? this.userName,
      profileImagePath: profileImagePath ?? this.profileImagePath,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppSettings &&
        other.themeModeIndex == themeModeIndex &&
        other.isNotificationsEnabled == isNotificationsEnabled &&
        other.isBiometricEnabled == isBiometricEnabled &&
        other.isLiveUpdatesEnabled == isLiveUpdatesEnabled &&
        other.userName == userName &&
        other.profileImagePath == profileImagePath;
  }

  @override
  int get hashCode =>
      themeModeIndex.hashCode ^
      isNotificationsEnabled.hashCode ^
      isBiometricEnabled.hashCode ^
      isLiveUpdatesEnabled.hashCode ^
      userName.hashCode ^
      profileImagePath.hashCode;
}
