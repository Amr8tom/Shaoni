import 'package:flutter/material.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import '../../../core/constants/app_sizes.dart';

import '../../../core/constants/colors.dart';
import '../../../core/device/device_utility.dart';
import '../../../core/utils/helpers/background_image.dart';
import '../sizeboxs/Sizer.dart';

void CustomDialogImgTitleDes({
  required BuildContext context,
  required String title,
  required String des,
  required String imgPath,
  bool isSvg = false,
   double? width,height,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          padding: EdgeInsets.all(AppSizes.padding),
          decoration: BoxDecoration(
            color: ColorRes.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
          ),
          height: DDeviceUtils.getScreenHeight(context)/2.4,
          width: DDeviceUtils.getScreenWidth(context)/1.1,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.close, color: ColorRes.grey2,size: AppSizes.iconMd,),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width??AppSizes.containerMedium,
                    height: height?? AppSizes.containerMedium,
                    child: BackgroundImage(
                      isSvgImage: isSvg,
                      isPositioned: false,
                      path:imgPath, fit: BoxFit.fill,
                    )
                    ,
                   ),
                  const Sizer(height: 16,width: double.infinity,),
                  Text(
                    title,
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall?.copyWith(color: ColorRes.primary),
                  ),
                  const Sizer(height: 8),
                  Text(
                    des,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: ColorRes.grey2),
                    maxLines: 5,
                  ),

                  // Sizer(height: 8),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
