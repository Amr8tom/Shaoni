import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';

import '../../../generated/l10n.dart';
import '../../constants/colors.dart';


Future<void> checkForPlayUpdate({required BuildContext context}) async {
  InAppUpdate.checkForUpdate().then((updateInfo) {
    if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
      _showUpdateDialog(context: context);
    }
  }).catchError((error) {
    print('Error checking for update: $error');
  });
}

void _showUpdateDialog({required BuildContext context}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: ColorRes.primary,
        title: Text(S.current.updateAvailable,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: ColorRes.white)),
        content: Text(S.current.updateBody,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: ColorRes.white)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              InAppUpdate.performImmediateUpdate().catchError((error) {
                print('Error performing update =====================> $error');
              });
            },
            child: Text(
              S.current.update,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: ColorRes.white),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              S.current.later,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: ColorRes.white),
            ),
          ),
        ],
      );
    },
  );
}