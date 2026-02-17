import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/asset_resoures.dart';
import 'package:shaoni/core/device/device_utility.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/service_locator/service_locator.dart';
import 'package:shaoni/core/widgets/buttons/d_button.dart';
import 'package:shaoni/features/profile/presentation/controllers/profile_cubit.dart';
import '../../generated/l10n.dart';
import '../auth/presentation/widgets/auth_text_filed.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<ProfileCubit>(),
      child: Scaffold(
        backgroundColor: ColorRes.scaffoldBG,
        appBar: DAppBar(
          showBackArrow: true,
          appHeight: DDeviceUtils.getAppBarHeight() * 3,
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            final controller = context.read<ProfileCubit>();
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.padding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// Avatar with edit badge (bottom-left, olive/gold color)
                          Center(
                            child: SizedBox(
                              width: 120.w,
                              height: 120.w,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  // Red/salmon background circle
                                  Container(
                                    width: 120.w,
                                    height: 120.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(
                                        0xFFE8B4A8,
                                      ), // salmon/peach color behind avatar
                                    ),
                                  ),
                                  // Avatar image
                                  Positioned.fill(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: const AssetImage(
                                        AssetRes.humanResources,
                                      ),
                                    ),
                                  ),
                                  // Edit badge - bottom left
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        // TODO: implement image picker
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8.w),
                                        decoration: BoxDecoration(
                                          color: ColorRes.yellow,
                                          // olive/gold color
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: ColorRes.white,
                                            width: 2,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: ColorRes.black.withOpacity(
                                                0.15,
                                              ),
                                              blurRadius: 6,
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          Icons.edit_outlined,
                                          size: 16.sp,
                                          color: ColorRes.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const Sizer(height: 32),

                          /// Form fields - using reusable ProfileField widget
                          AuthTextField(
                            hint: "Amr Alaa",
                            controller: controller.nameController,
                            prefixIcon: Icon(Icons.person),
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(AppSizes.padding*0.7),
                              child: Image.asset(
                                AssetRes.editForProfile,
                                height: AppSizes.iconMd,
                              ),
                            ),
                          ),
                          AuthTextField(
                            hint: "+01011577033",
                            controller: controller.numberController,
                            prefixIcon: Icon(Icons.phone_android),
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(AppSizes.padding*0.7),
                              child: Image.asset(
                                AssetRes.editForProfile,
                                height: AppSizes.iconMd,
                              ),
                            ),
                          ),
                          AuthTextField(
                            hint: "AmrAlaa@gmail.com",
                            controller: controller.emailController,
                            prefixIcon: Icon(Icons.email_outlined),
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(AppSizes.padding*0.7),
                              child: Image.asset(
                                AssetRes.editForProfile,
                                height: AppSizes.iconMd,
                              ),
                            ),
                          ),
                          AuthTextField(
                            hint: "**************",
                            controller: controller.passwordController,
                            prefixIcon: Icon(Icons.lock_outline_rounded),
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(AppSizes.padding*0.7),
                              child: Image.asset(
                                AssetRes.editForProfile,
                                height: AppSizes.iconMd,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                /// Bottom button - fixed at bottom
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.padding,
                    vertical: AppSizes.md,
                  ),
                  child: SafeArea(
                    top: false,
                    child: DButton(
                      text: S.current.updateData,
                      onPressed: () {
                        // TODO: save profile changes
                      },
                      variant: DButtonVariant.primary,
                      size: DButtonSize.large,
                      height: 50.h,
                      width: double.infinity,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
