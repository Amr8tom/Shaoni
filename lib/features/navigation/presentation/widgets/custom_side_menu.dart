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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Sizer(height: 20),
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
              // const Divider(color: ColorRes.grey5, thickness: 1),
              // SideMenuItem(
              //   icon: AssetRes.sideAboutIcon,
              //   title: S.current.aboutApp,
              //   onTap: () {},
              // ),
              const Divider(color: ColorRes.grey5, thickness: 1),
              SideMenuItem(
                icon: AssetRes.sidePrivaceyIcon,
                title: S.current.privacyPolicy,
                onTap: () {
                  context.pushNamed(DRoutesName.termsAndConditionRoute);

                },
              ),
              const Divider(color: ColorRes.grey5, thickness: 1),

              SideMenuItem(
                icon: AssetRes.sidePrivaceyIcon,
                title: S.current.logOut,
                isIcon: true,
                iconData: Icons.logout_outlined,
                onTap: () {
                  showLogoutDialog(context);
                },
              ),
              const Sizer(height: 200),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Sizer(width: 2),
                    Text(
                      S.current.appLanguage,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    BlocBuilder<LanguageCubit, LanguageState>(
                      builder: (context, state) {
                        final languageCubit = context.read<LanguageCubit>();
                        final currentLang =
                            languageCubit.currentLanguage.languageCode;

                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.padding / 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              AppSizes.borderRadiusSm,
                            ),
                            color: ColorRes.grey6,
                          ),
                          child: DropdownButton<String>(
                            value: currentLang,
                            underline: const SizedBox(),
                            icon: const Icon(
                              Icons.keyboard_arrow_down_outlined,
                            ),
                            style: Theme.of(context).textTheme.titleSmall,
                            dropdownColor: Colors.white,
                            borderRadius: BorderRadius.circular(
                              AppSizes.borderRadiusSm,
                            ),
                            items: [
                              DropdownMenuItem(
                                value: 'ar',
                                child: Text(
                                  S.current.arabic,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'en',
                                child: Text(
                                  S.current.english,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                            ],
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                languageCubit.changeLanguage(newValue);
                                context.pushReplacementNamed(
                                    DRoutesName.navigationMenuRoute);
                              }
                            },
                          ),
                        );
                      },
                    ),
                    // const Sizer(width: 2,),
                    //
                  ],
                ),
              ),
              const DrawerLogoWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
