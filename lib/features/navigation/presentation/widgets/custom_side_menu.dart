import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/features/navigation/presentation/widgets/show_logout_dialog.dart';
import 'package:shaoni/features/navigation/presentation/widgets/side_menu_item.dart';
import '../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/asset_resoures.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/device/device_utility.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../features/language/presentation/controller/language_cubit.dart';
import '../../../../generated/l10n.dart';
import 'drawer_logo_widget.dart';

class CustomSideMenu extends StatelessWidget {
  const CustomSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: DDeviceUtils.getScreenWidth(context) / 1.4,
      child: SafeArea(
        child: Column(
          /// Stretch makes every row fill the drawer width so the dividers
          /// visually connect to the rows above and below them.
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Sizer(height: 20),
            Center(
              child: Image.asset(
                AssetRes.logoWithName,
                width: AppSizes.widthcontainer * 1.5,
              ),
            ),

            /// Calmer breathing room under the brand (was 150 — felt empty).
            const Sizer(height: 32),

            /// Items live inside a shared horizontal gutter so the cards
            /// don't touch the drawer edges, and are spaced by Sizer gaps
            /// instead of harsh dividers — the soft tinted backgrounds on
            /// each card now provide the visual separation.
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
              child: SideMenuItem(
                icon: AssetRes.sideHomeIcon,
                title: S.current.home,
                onTap: () {
                  context.pop();
                },
              ),
            ),
            const Sizer(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
              child: SideMenuItem(
                isIcon: true,
                iconData: Icons.settings_outlined,
                icon: AssetRes.sidePrivaceyIcon,
                title: S.current.settings,
                onTap: () {
                  context.pop();
                  context.pushNamed(DRoutesName.settingsRoute);
                },
              ),
            ),
            const Sizer(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
              child: SideMenuItem(
                icon: AssetRes.sidePrivaceyIcon,
                title: S.current.privacyPolicy,
                onTap: () {
                  context.pushNamed(DRoutesName.termsAndConditionRoute);
                },
              ),
            ),

            /// Pushes the footer credit to the very bottom of the drawer
            /// instead of letting it float right under the last menu item.
            const Spacer(),

            const DrawerLogoWidget(),
            const Sizer(height: 12),
          ],
        ),
      ),
    );
  }
}
