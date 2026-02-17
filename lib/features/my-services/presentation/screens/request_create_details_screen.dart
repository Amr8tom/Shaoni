import 'package:flutter/material.dart';
import 'package:shaoni/common/widgets/dialogs/custom_dialog_img_title_des.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/asset_resoures.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/device/device_utility.dart';
import 'package:shaoni/features/auth/presentation/widgets/auth_button.dart';
import 'package:shaoni/features/auth/presentation/widgets/auth_text_filed.dart';

import '../../../../generated/l10n.dart';
import '../../../navigation/presentation/widgets/custom_navigation_appbar.dart';

class RequestCreateDetailsScreen extends StatelessWidget {
  const RequestCreateDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        showBackArrow: true,
        height: DDeviceUtils.getAppBarHeight() * 3,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: ColorRes.grey6,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.padding * 1.5),
        child: Column(
          // spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Sizer(height: 190),

            /// dates titles and text fields
            Text(
              S.current.date,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Row(
              spacing: 10,
              children: [
                Flexible(
                  child: AuthTextField(
                    borderRadius: AppSizes.borderRadiusMd,

                    hint: S.current.hijriDate,
                    prefixIcon: Icon(
                      Icons.date_range,
                      color: ColorRes.grey2.withOpacity(0.5),
                    ),
                    controller: TextEditingController(),
                  ),
                ),
                Flexible(
                  child: AuthTextField(
                    borderRadius: AppSizes.borderRadiusMd,

                    hint: S.current.dateBirth,
                    prefixIcon: Icon(
                      Icons.date_range,
                      color: ColorRes.grey2.withOpacity(0.5),
                    ),
                    controller: TextEditingController(),
                  ),
                ),
              ],
            ),

            /// data for request applicant
            Text(
              S.current.requestApplicantData,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Column(
              children: [
                AuthTextField(
                  hint: S.current.applicantName,
                  controller: TextEditingController(),
                  borderRadius: AppSizes.borderRadiusMd,
                ),
                AuthTextField(
                  hint: S.current.organizationalUnit,
                  controller: TextEditingController(),
                  borderRadius: AppSizes.borderRadiusMd,
                ),
                AuthTextField(
                  hint: S.current.location,
                  controller: TextEditingController(),
                  borderRadius: AppSizes.borderRadiusMd,
                ),
              ],
            ),

            /// data for request
            Text(
              S.current.requestDetails,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Row(
              spacing: 10,
              children: [
                Flexible(
                  child: AuthTextField(
                    borderRadius: AppSizes.borderRadiusMd,

                    hint: S.current.permissionDate,
                    prefixIcon: Icon(
                      Icons.date_range,
                      color: ColorRes.grey2.withOpacity(0.5),
                    ),
                    controller: TextEditingController(),
                  ),
                ),
                Flexible(
                  child: AuthTextField(
                    borderRadius: AppSizes.borderRadiusMd,

                    hint: S.current.permissionDate,
                    prefixIcon: Icon(
                      Icons.date_range,
                      color: ColorRes.grey2.withOpacity(0.5),
                    ),
                    controller: TextEditingController(),
                  ),
                ),
              ],
            ),
            Row(
              spacing: 10,
              children: [
                Flexible(
                  child: AuthTextField(
                    borderRadius: AppSizes.borderRadiusMd,
                    hint: S.current.permissionType,
                    prefixIcon: Icon(
                      Icons.date_range,
                      color: ColorRes.grey2.withOpacity(0.5),
                    ),
                    controller: TextEditingController(),
                  ),
                ),
                Flexible(
                  child: AuthTextField(
                    borderRadius: AppSizes.borderRadiusMd,
                    hint: S.current.durationInHours,
                    prefixIcon: Icon(
                      Icons.date_range,
                      color: ColorRes.grey2.withOpacity(0.5),
                    ),
                    controller: TextEditingController(),
                  ),
                ),
              ],
            ),
            const Sizer(height: 30),

            /// send request button
            Row(
              children: [
                Flexible(
                  flex: 7,
                  child: AuthButton(
                    backgroundColor: ColorRes.primary,
                    fontSize: AppSizes.fontSizeMd,
                    text: S.current.submitRequest,
                    onPressed: () {
                      CustomDialogImgTitleDes(
                        context: context,
                        title: S.current.requestSentSuccessfully,
                        des: S.current.requestSentSuccessfully,
                        imgPath: AssetRes.doubleCorrect,
                        isSvg: true,
                      );
                    },
                  ),
                ),
                const Sizer(width: 15),
                Flexible(
                  flex: 2,

                  child: Container(
                    // width: AppSizes.widthcontainer/2,
                    // height: AppSizes.iconLg*1.5,
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.padding * 1.4,
                      vertical: AppSizes.padding * 0.6,
                    ),
                    decoration: BoxDecoration(
                      color: ColorRes.error2,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(
                      AssetRes.trashIcon,
                      width: AppSizes.iconLg,
                      height: AppSizes.iconLg,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
