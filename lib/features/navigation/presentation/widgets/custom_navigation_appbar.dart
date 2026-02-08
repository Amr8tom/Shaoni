import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/asset_resoures.dart';
import 'package:shaoni/core/device/device_utility.dart';
import 'package:shaoni/features/navigation/presentation/widgets/profile_header.dart';
import '../../../../core/constants/colors.dart';

PreferredSizeWidget customNavigationAppBars(int indx, BuildContext context) {
  return DAppBar(
    // showBackArrow: true,
    bgColor: ColorRes.transparent,
    appHeight: DDeviceUtils.getAppBarHeight()*4,
    actions: [
      const Sizer(width: 15),

      /// when profile show special skip and done button
      // IconButton(onPressed: (){}, icon:Icon(Icons.menu,color: ColorRes.white,)),
      SvgPicture.asset(AssetRes.menuIcon,color: ColorRes.white,),
      const Sizer(width: 30),
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

          SvgPicture.asset(AssetRes.notificationIcon,color: ColorRes.white,),
        ],
      ),
      const Spacer(),
      const ProfileHeader(),
      const Sizer(width: 15),
    ],
  );
}
