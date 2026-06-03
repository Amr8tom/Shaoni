import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/asset_resoures.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../../auth/presentation/widgets/auth_button.dart';
import '../../controller/exit_permission/exit_request_service_cubit.dart';

class CreateDeleteButtons extends StatelessWidget {
  final VoidCallback? deleteTab;
  final VoidCallback? createTab;

  const CreateDeleteButtons({super.key, this.deleteTab, this.createTab});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: AppSizes.padding * 3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusXXLg),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.padding,
              vertical: AppSizes.padding * 0.8,
            ),
            decoration: BoxDecoration(
              color: ColorRes.transparent,
              borderRadius: BorderRadius.circular(
                AppSizes.borderRadiusXXLg,
              ),
            ),
            child: Row(
              children: [
                Flexible(
                  flex: 7,
                  child: AuthButton(
                    backgroundColor: ColorRes.primary,
                    fontSize: AppSizes.fontSizeMd,
                    text: S.current.submitRequest,
                    onPressed: createTab,
                  ),
                ),
                const Sizer(width: 15),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: deleteTab,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.padding * 1.4,
                        vertical: AppSizes.padding * 0.6,
                      ),
                      decoration: BoxDecoration(
                        color: ColorRes.grey.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(
                          AppSizes.borderRadiusXXLg,
                        ),
                      ),
                      child: Image.asset(
                        AssetRes.trashIcon,
                        width: AppSizes.iconLg,
                        height: AppSizes.iconLg,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
