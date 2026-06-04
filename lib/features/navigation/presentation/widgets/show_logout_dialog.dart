import 'package:flutter/material.dart';
import 'package:shaoni/core/extensions/navigation_extension.dart';
import 'package:shaoni/core/local_storage/session_storage/session_storage.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/service_locator/service_locator.dart';
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
              await serviceLocator<SessionStorage>().clearSession();
              if (dialogContext.mounted) {
                Navigator.pop(dialogContext);
                context.pushReplacementNamed(DRoutesName.loginRoute);
              }
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
