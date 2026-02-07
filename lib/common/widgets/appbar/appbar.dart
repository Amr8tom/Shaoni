import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/colors.dart';
import '../../../core/device/device_utility.dart';
import '../sizeboxs/Sizer.dart';

class DAppBar extends StatelessWidget implements PreferredSizeWidget {
  DAppBar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.centerTitle = true,
    this.leadingWidget,
    this.actions,
    this.bgColor,
    this.arrowBackColor = false,
    this.fontSize,
    this.appHeight,
    this.showBackGroundColor = false,
    this.doSomeThing,
  });

  final String? title;
  final bool showBackArrow;
  final bool showBackGroundColor;
  final bool centerTitle;
  final double? fontSize;
  final bool arrowBackColor;
  final List<Widget>? actions;
  final Widget? leadingWidget;
  final Color? bgColor;
  final double? appHeight;

  void Function()? doSomeThing;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(

              color: showBackGroundColor ? Colors.grey[200] : ColorRes.primary,
              boxShadow: [
                BoxShadow(
                  color: ColorRes.gold.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppSizes.borderRadiusLarge * 1.5),
                bottomRight: Radius.circular(AppSizes.borderRadiusLarge * 1.5),
              ),
            ),
            height: appHeight?? DDeviceUtils.getAppBarHeight().sp * 3,
          ),
          Container(

            child: Column(
              children: [
                const Sizer(height: 20),
                AppBar(
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: fontSize ?? 24.sp,
                    color: ColorRes.gold,
                  ),
                  backgroundColor: bgColor ?? ColorRes.transparent,
                  automaticallyImplyLeading: false,
                  // leadingWidth: 85.w,
                  leading:
                      showBackArrow
                          ? IconButton(
                            onPressed: () {
                              if (doSomeThing != null) {
                                doSomeThing!();
                              }
                              context.pop(); // Navigate back
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              // Use arrow_back_ios for a more modern look
                              size: AppSizes.iconSm,
                              color:
                                  arrowBackColor
                                      ? ColorRes.white
                                      : ColorRes.grey,
                            ),
                          )
                          : Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: leadingWidget,
                          ),
                  title: Text(title ?? ""),
                  centerTitle: centerTitle,
                  actions: actions,
                  toolbarHeight: DDeviceUtils.getAppBarHeight().sp *1,
                ),

                Container(
                  height: 3,
                  decoration: BoxDecoration(
                    color: ColorRes.error.withOpacity(0.2),

                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 2),
                        color: ColorRes.primary.withOpacity(0.2),
                        blurRadius: 4,
                        spreadRadius: 0.2,
                      ),
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        ColorRes.primary.withOpacity(0.2),
                        ColorRes.primary.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(appHeight?? DDeviceUtils.getAppBarHeight().sp * 3);
}
