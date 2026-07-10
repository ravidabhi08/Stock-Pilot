import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

/// A premium widget displaying the user's profile information.
///
/// This widget renders a professional profile header with:
/// - A circular avatar with the user's initial or profile picture
/// - The user's full name
/// - Their account ID or email address
/// - A subtle gradient background for visual appeal
///
/// The design follows premium fintech app patterns (Groww, Zerodha, INDmoney)
/// with clean typography, proper spacing, and semantic color usage.
///
/// Usage:
/// ```dart
/// ProfileHeader(
///   userName: 'Rahul Sharma',
///   accountId: 'rahul.sharma@email.com',
///   avatarUrl: 'https://example.com/avatar.jpg', // Optional
/// )
/// ```
class ProfileHeader extends StatelessWidget {
  /// The user's full name.
  final String userName;

  /// The user's account ID, email, or phone number.
  final String accountId;

  final VoidCallback? onEditPressed;

  /// Optional URL for the user's profile picture.
  /// If null, displays the user's initial instead.
  final String? avatarUrl;

  const ProfileHeader({
    super.key,
    required this.userName,
    required this.accountId,
    this.avatarUrl,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLightTheme = theme.brightness == Brightness.light;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors:
              isLightTheme
                  ? [
                    theme.colorScheme.primaryContainer.withOpacity(0.3),
                    theme.colorScheme.secondaryContainer.withOpacity(0.2),
                  ]
                  : [
                    theme.colorScheme.primaryContainer.withOpacity(0.15),
                    theme.colorScheme.secondaryContainer.withOpacity(0.1),
                  ],
        ),
        borderRadius: AppRadius.card,
        border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.3), width: 1.0),
      ),
      child: Row(
        children: [
          // 1. Avatar
          _buildAvatar(theme),

          const SizedBox(width: AppSpacing.lg),

          // 2. User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  accountId,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // 3. Edit Icon
          IconButton(
            icon: Icon(Icons.edit_rounded, size: 20, color: theme.colorScheme.onSurfaceVariant),
            onPressed: onEditPressed, // Use the callback!
          ),
        ],
      ),
    );
  }

  /// Builds the circular avatar widget.
  Widget _buildAvatar(ThemeData theme) {
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return CircleAvatar(
        radius: 32,
        backgroundImage: FileImage(File(avatarUrl!)), // Use FileImage for local paths
        backgroundColor: theme.colorScheme.primaryContainer,
      );
    }

    // Show initial
    return CircleAvatar(
      radius: 32,
      backgroundColor: theme.colorScheme.primary,
      child: Text(
        _getInitial(userName),
        style: theme.textTheme.headlineMedium?.copyWith(
          color: theme.colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Extracts the first letter of the user's name for the avatar initial.
  String _getInitial(String name) {
    if (name.trim().isEmpty) return '?';
    return name.trim()[0].toUpperCase();
  }
}
