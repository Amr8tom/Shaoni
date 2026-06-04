import 'package:flutter/material.dart';
import 'package:shaoni/core/constants/asset_resources.dart';
import 'package:shaoni/core/extensions/navigation_extension.dart';
import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/device/device_utility.dart';
import '../../../../core/local_storage/cache_helper.dart';
import '../../../../core/local_storage/cache_keys.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../language/presentation/controller/language_cubit.dart';
import '../widgets/splash_logo_section.dart';
import '../widgets/splash_language_section.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final token = CacheHelper.getString(key: CacheKeys.token);

  @override
  void initState() {
    super.initState();
    _setSystemUIOverlayStyle();
    _delayBeforeNavigation();
  }

  void _setSystemUIOverlayStyle() {
    DDeviceUtils.setStatusBarColor(ColorRes.darkGrey);
    DDeviceUtils.setNavigationBarColor(ColorRes.darkGrey);
  }

  @override
  void dispose() {
    DDeviceUtils.setStatusBarColor(ColorRes.primary);
    DDeviceUtils.setNavigationBarColor(ColorRes.primary);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: AppSizes.fullHeight,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetRes.backGroundImage),
                fit: BoxFit.cover,
              ),
              color: ColorRes.transparent),
          // color: ColorRes.transparent,
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 3,
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(color: ColorRes.transparent),
                      child: const Center(child: SplashLogoSection()),
                    ),
                  ),
                  ((token?.trim() == '' || token == null))
                      ? Expanded(
                          flex: 4,
                          child: SplashLanguageSection(
                            onLanguageSelected: (languageCode) {
                              serviceLocator<LanguageCubit>().changeLanguage(
                                languageCode,
                              );
                              CacheHelper.cacheLanguage(languageCode);
                              Navigator.of(
                                context,
                              ).pushReplacementNamed(
                                  DRoutesName.onBoardingRoute);
                            },
                          ),
                        )
                      : const Sizer(height: 240),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _delayBeforeNavigation() async {
    if (token?.trim() != '' || token!.isNotEmpty) {
      await Future.delayed(Duration(seconds: 4, milliseconds: 500));

      context.pushReplacementNamed(DRoutesName.navigationMenuRoute);
    }
  }
}
