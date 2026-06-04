import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/core/utils/enums/general_status.dart';
import '../../../../../generated/l10n.dart';
import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/local_storage/cache_helper.dart';
import '../../../../core/local_storage/cache_keys.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../controllers/delete_account_cubit.dart';

class DeleteMyAccountBody extends StatelessWidget {
  const DeleteMyAccountBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<DeleteAccountCubit>(),
      child: Builder(
        builder: (context) {
          return BlocListener<DeleteAccountCubit, DeleteAccountState>(
            listener: (context, state) {
              if (state.status.isSuccess) {
                _deleteAccountAlert(context);
                context.pushNamedAndRemoveUntil(
                  DRoutesName.loginRoute,
                  predicate: (route) => false,
                );
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.padding,
                  vertical: AppSizes.padding * 2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Warning Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(AppSizes.padding),
                      decoration: BoxDecoration(
                        color: ColorRes.error.withOpacity(0.08),
                        borderRadius:
                            BorderRadius.circular(AppSizes.borderRadiusMd),
                        border: Border.all(
                          color: ColorRes.error.withOpacity(0.2),
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          /// Warning Icon
                          Container(
                            padding: EdgeInsets.all(AppSizes.md),
                            decoration: BoxDecoration(
                              color: ColorRes.error.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.info_outline_rounded,
                              size: AppSizes.iconXLarge,
                              color: ColorRes.error,
                            ),
                          ),
                          const Sizer(height: 16),

                          /// Main Question
                          Text(
                            S.current.askDelete,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: ColorRes.error,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const Sizer(height: 28),

                    /// Description Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(AppSizes.padding),
                      decoration: BoxDecoration(
                        color: ColorRes.grey6,
                        borderRadius:
                            BorderRadius.circular(AppSizes.borderRadiusMd),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.current.deleteBody,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: ColorRes.grey2.withOpacity(0.7),
                                  height: 1.6,
                                ),
                            textAlign: TextAlign.start,
                          ),
                          const Sizer(height: 16),

                          /// Warning Points
                          ..._buildWarningPoints(context),
                        ],
                      ),
                    ),
                    const Sizer(height: 40),

                    /// Action Buttons
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        /// Delete Button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorRes.error,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppSizes.buttonRadius,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: AppSizes.md + 4,
                            ),
                            elevation: 2,
                          ),
                          onPressed: () async {
                            _showConfirmationDialog(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete_outline,
                                color: ColorRes.white,
                                size: AppSizes.iconSm,
                              ),
                              const Sizer(width: 8),
                              Text(
                                S.current.deleteAccount,
                                style: TextStyle(
                                  color: ColorRes.white,
                                  fontSize: AppSizes.fontSizeSm,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Sizer(height: 12),

                        /// Cancel Button
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: ColorRes.primary,
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppSizes.buttonRadius,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: AppSizes.md + 4,
                            ),
                          ),
                          onPressed: () => context.pop(),
                          child: Text(
                            S.current.cancleOrder,
                            style: TextStyle(
                              color: ColorRes.primary,
                              fontSize: AppSizes.fontSizeSm,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildWarningPoints(BuildContext context) {
    final points = [
      S.current.deleteBody,
      'All your personal information will be permanently removed',
      'This action cannot be undone',
    ];

    return points.map((point) {
      return Padding(
        padding: EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: ColorRes.error.withOpacity(0.6),
              size: AppSizes.iconSm,
            ),
            const Sizer(width: 8),
            Expanded(
              child: Text(
                point,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: ColorRes.grey2.withOpacity(0.6),
                      height: 1.5,
                    ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          ),
          contentPadding: EdgeInsets.all(AppSizes.padding),
          title: Column(
            children: [
              Container(
                padding: EdgeInsets.all(AppSizes.md),
                decoration: BoxDecoration(
                  color: ColorRes.error.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.warning_rounded,
                  size: AppSizes.iconLarge,
                  color: ColorRes.error,
                ),
              ),
              const Sizer(height: 16),
            ],
          ),
          content: Text(
            'Are you absolutely sure? This will permanently delete your account.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorRes.grey2,
                  height: 1.6,
                ),
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: ColorRes.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppSizes.borderRadiusSm),
                      ),
                    ),
                    onPressed: () => Navigator.pop(dialogContext),
                    child: Text(
                      S.current.cancleOrder,
                      style: const TextStyle(
                        color: ColorRes.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const Sizer(width: 16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorRes.error,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppSizes.borderRadiusSm),
                      ),
                    ),
                    onPressed: () async {
                      await CacheHelper.removeFromShared(key: CacheKeys.token);
                      await CacheHelper.removeFromShared(key: CacheKeys.userId);
                      await CacheHelper.removeFromShared(
                          key: CacheKeys.employeeId);
                      if (dialogContext.mounted) {
                        Navigator.pop(dialogContext);
                        context.pushReplacementNamed(DRoutesName.loginRoute);
                      }
                    },
                    child: Text(
                      S.current.deleteAccount,
                      style: const TextStyle(
                        color: ColorRes.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future _deleteAccountAlert(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          ),
          contentPadding: EdgeInsets.all(AppSizes.padding),
          title: Column(
            children: [
              Container(
                padding: EdgeInsets.all(AppSizes.md),
                decoration: BoxDecoration(
                  color: ColorRes.success.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  size: AppSizes.iconXLarge,
                  color: ColorRes.success,
                ),
              ),
              const Sizer(height: 16),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Account Deleted',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorRes.primary,
                    ),
                textAlign: TextAlign.center,
              ),
              const Sizer(height: 8),
              Text(
                S.current.accountDeleted,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorRes.grey2.withOpacity(0.6),
                      height: 1.6,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorRes.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppSizes.borderRadiusSm),
                  ),
                  padding: EdgeInsets.symmetric(vertical: AppSizes.md),
                ),
                onPressed: () {
                  Navigator.pop(dialogContext);
                  Navigator.pop(context);
                },
                child: Text(
                  S.current.backToHome,
                  style: const TextStyle(
                    color: ColorRes.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
          actionsPadding: EdgeInsets.all(AppSizes.padding),
        );
      },
    );
  }
}
