import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/asset_resources.dart';
import 'package:shaoni/core/device/device_utility.dart';
import 'package:shaoni/core/extensions/navigation_extension.dart';
import 'package:shaoni/core/routing/route_names.dart';
import 'package:shaoni/features/navigation/presentation/widgets/profile_header.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import '../controllers/navigation_cubit.dart';

PreferredSizeWidget customAppBar({
  final bool isHeader = false,
  final bool showMenu = false,
  final bool showBackArrow = false,
  final double? height,
  final BuildContext? context,
  final GlobalKey<ScaffoldState>? scaffoldKey,
}) {
  final controller = context?.read<NavigationCubit>();

  return DAppBar(
    showBackArrow: showBackArrow,
    showMenu: showMenu,
    // bgColor: ColorRes.transparent,
    appHeight: height ?? DDeviceUtils.getAppBarHeight(),
    actions: [
      const Sizer(width: 15),

      /// when profile show special skip and done button
      // IconButton(onPressed: (){}, icon:Icon(Icons.menu,color: ColorRes.white,)),
      isHeader
          ? ProfileHeader(
              userName: controller?.state.user?.fullName,
            )
          : const Sizer(),
      const Spacer(),

      Stack(
        children: [
          GestureDetector(
              onTap: () {
                context?.pushNamed(DRoutesName.notificationsRoute);
              },
              child: SvgPicture.asset(AssetRes.notificationIcon,
                  colorFilter: const ColorFilter.mode(
                      ColorRes.white, BlendMode.srcIn))),
        ],
      ),
      const Sizer(width: 30),

      showMenu
          ? GestureDetector(
              onTap: () {
                scaffoldKey?.currentState?.openDrawer();
              },
              child: Directionality(
                  textDirection: S.current.localeee == 'en'
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  child: SvgPicture.asset(AssetRes.menuIcon,
                      colorFilter: const ColorFilter.mode(
                          ColorRes.white, BlendMode.srcIn))))
          : const Sizer(),

      const Sizer(width: 15),
    ],
  );
}
