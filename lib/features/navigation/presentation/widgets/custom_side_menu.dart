import 'package:flutter/material.dart';

import 'package:shaoni/core/extentions/navigation_extension.dart';
import '../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/asset_resoures.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/device/device_utility.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../generated/l10n.dart';

class CustomSideMenu extends StatelessWidget {
  const CustomSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: DDeviceUtils.getScreenWidth(context) / 1.4,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Sizer(height: 50),
              Center(
                child: Image.asset(
                  AssetRes.logoWithName,
                  width: AppSizes.widthcontainer * 1.5,
                ),
              ),
              const Sizer(height: 150),
              SideMenuItem(
                icon: AssetRes.sideHomeIcon,
                title: S.current.home,
                onTap: () {
                  context.pop();
                },
              ),
              const Divider(color: ColorRes.grey5, thickness: 1),
              SideMenuItem(
                icon: AssetRes.sideAboutIcon,
                title: S.current.aboutApp,
                onTap: () {},
              ),
              const Divider(color: ColorRes.grey5, thickness: 1),
              SideMenuItem(
                icon: AssetRes.sidePrivaceyIcon,
                title: S.current.privacyPolicy,
                onTap: () {},
              ),
              const Divider(color: ColorRes.grey5, thickness: 1),
              SideMenuItem(
                icon: AssetRes.sideQuestionIcon,
                title: S.current.userPolicy,
                onTap: () {
                  // context.pushNamed(DRoutesName.);
                },
              ),
              const Sizer(height: 20),

              Padding(
                padding: EdgeInsets.symmetric(horizontal:AppSizes.padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
                      width:AppSizes.widthcontainer*0.8,
                      height: AppSizes.heightcontainer*0.8,

                      child: Text(
                        S.current.appLanguage,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                   // const Spacer(),
                    Container(
                      width:AppSizes.widthcontainer*0.8,
                      height: AppSizes.heightcontainer*0.8,
                      padding: EdgeInsets.symmetric(horizontal: AppSizes.padding/2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppSizes.borderRadiusSm,
                        ),
                        color: ColorRes.grey6,
                      ),
                      child: Flexible(
                        child: Row(
                          children: [
                            Text(
                              S.current.arabic,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const Spacer(),
                            Icon(Icons.keyboard_arrow_down_outlined)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Sizer(height: 170),
              Center(
                child: Text(
                  S.current.designDevelopment,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ColorRes.grey,
                  ),
                ),
              ),
              const Sizer(height: 2),

              Center(
                child: Text(
                  S.current.ejadDigitalSolutions,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ColorRes.grey,
                  ),
                ),
              ),
              const Sizer(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class SideMenuItem extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const SideMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(AppSizes.padding / 2),
        child: Row(
          children: [
            const Sizer(width: 20),
            Image.asset(
              icon,
              color: ColorRes.primary,
              width: AppSizes.iconLg,
              height: AppSizes.iconLg,
            ),
            const Sizer(width: 12),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(color: ColorRes.grey2),
            ),
          ],
        ),
      ),
    );
  }
}
