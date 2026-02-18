import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/asset_resoures.dart';
import 'package:shaoni/core/device/device_utility.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/core/routing/route_names.dart';
import 'package:shaoni/features/navigation/presentation/widgets/profile_header.dart';
import '../../../../core/constants/colors.dart';

PreferredSizeWidget customAppBar({
  final bool isHeader = false,
  final bool showBackArrow = false,
  final double? height,
  final BuildContext? context,
  final GlobalKey<ScaffoldState>? scaffoldKey,
}) {
  return DAppBar(
    showBackArrow: showBackArrow,
    bgColor: ColorRes.transparent,
    appHeight: height ?? DDeviceUtils.getAppBarHeight() * 3,
    actions: [
      const Sizer(width: 15),

      /// when profile show special skip and done button
      // IconButton(onPressed: (){}, icon:Icon(Icons.menu,color: ColorRes.white,)),
      isHeader ? const ProfileHeader() : const Sizer(),
      const Spacer(),

      /// todo : remove comment form this stack to red point for unreaded notification
      Stack(
        children: [
          // Text("Sdsds"),
          // context.read<NavigationCubit>().state.notificationCount > 0
          //     ? Text(
          //       "${context.read<NavigationCubit>().state.notificationCount}",
          //       style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          //         fontWeight: FontWeight.bold,
          //         color: ColorRes.error2,
          //
          //       ),
          //     )
          //     :const Sizer(),
          GestureDetector(onTap: (){
            context?.pushNamed(DRoutesName.notificationsRoute);
          },
              child: SvgPicture.asset(
                  AssetRes.notificationIcon, color: ColorRes.white)),
        ],
      ),
      const Sizer(width: 30),

      GestureDetector(
          onTap: (){
            scaffoldKey?.currentState?.openDrawer();
          },
          child: SvgPicture.asset(AssetRes.menuIcon, color: ColorRes.white)),

      const Sizer(width: 15),
    ],
  );
}
