import 'package:flutter/material.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/local_storage/cache_helper.dart';
import '../../../../core/local_storage/cache_keys.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../generated/l10n.dart';

/// Show logout confirmation dialog
void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
        ),
        backgroundColor: ColorRes.white,
        title: Text(
          S.current.logOut,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: ColorRes.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          S.current.logoutQuestion,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: ColorRes.grey2,
          ),
        ),
        actions: [
          /// Cancel Button
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: Text(
              S.current.cancel,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorRes.grey2,
              ),
            ),
          ),

          /// Logout Button
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await _performLogout(context);
            },
            child: Text(
              S.current.logOut,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorRes.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );
}

/// Perform logout with cleanup and navigation
Future<void> _performLogout(BuildContext context) async {
  try {
    // Show loading
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.current.loading),
          duration: const Duration(seconds: 2),
          backgroundColor: ColorRes.primary,
        ),
      );
    }

    // Clear cache and tokens
    await _clearUserData();

    // Navigate to login screen and clear navigation stack
    if (context.mounted) {
      context.pushReplacementNamed(DRoutesName.loginRoute);
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error during logout: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}

/// Clear all user data and cache
Future<void> _clearUserData() async {
  try {
    // TODO: Import and use your CacheHelper/SharedPreferences
    // Example:
    await CacheHelper.removeFromShared(key: CacheKeys.token);
    await CacheHelper.removeFromShared(key: CacheKeys.userId);
    await CacheHelper.removeFromShared(key: CacheKeys.employeeId);
    // await CacheHelper.clear(); // Clear all cache if needed

    // If using GetIt for cubits, you can reset them
    // getIt<AuthCubit>().resetState();
    // getIt<NavigationCubit>().resetState();

    print('User data cleared successfully');
  } catch (e) {
    print('Error clearing user data: $e');
    rethrow;
  }
}