import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/asset_resources.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/extensions/navigation_extension.dart';
import 'package:shaoni/core/routing/route_names.dart';
import 'package:shaoni/core/service_locator/service_locator.dart';
import 'package:shaoni/features/navigation/presentation/controllers/navigation_cubit.dart';
import 'package:shaoni/features/profile/presentation/controllers/profile_cubit.dart';
import '../../../../core/utils/enums/general_status.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/presentation/widgets/auth_text_filed.dart';
import '../../../navigation/presentation/widgets/custom_side_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = serviceLocator<ProfileCubit>();
        final navController = context.read<NavigationCubit>();
        cubit.initWithUser(navController.state.user);
        return cubit;
      },
      child: Scaffold(
        backgroundColor: ColorRes.grey6,
        drawer: const CustomSideMenu(),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.massage ?? S.current.success),
                ),
              );
              context.pushNamedAndRemoveUntil(DRoutesName.navigationMenuRoute,
                  predicate: (route) => false);
            }
            if (state.status.isError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.massage ?? S.current.error),
                ),
              );
            }
          },
          builder: (context, state) {
            final controller = context.read<ProfileCubit>();
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.padding,
                        vertical: AppSizes.padding * 2,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// Avatar with edit badge (bottom-left, olive/gold color)
                          SizedBox(
                            width: 100.w,
                            height: 100.w,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                /// Red/salmon background circle
                                Container(
                                  width: 120.w,
                                  height: 120.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        ColorRes.error.withValues(alpha: 0.3),
                                  ),
                                ),

                                /// Avatar image
                                Positioned.fill(
                                  child: CircleAvatar(
                                    backgroundColor: ColorRes.transparent,
                                    backgroundImage: AssetImage(
                                      state.gender == 1
                                          ? AssetRes.man1
                                          : AssetRes.woman,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Sizer(height: 20),

                          /// Form fields
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.padding / 3,
                            ),
                            child: AuthTextField(
                              readOnly: true,
                              hint: controller.nameController.text.isEmpty
                                  ? 'Full Name'
                                  : controller.nameController.text,
                              controller: controller.nameController,
                              prefixIcon: const Icon(Icons.person),
                            ),
                          ),
                          const Sizer(height: 16),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.padding / 3,
                            ),
                            child: AuthTextField(
                              readOnly: true,
                              hint: controller.numberController.text.isEmpty
                                  ? 'Phone Number'
                                  : controller.numberController.text,
                              controller: controller.numberController,
                              prefixIcon: const Icon(Icons.phone_android),
                            ),
                          ),
                          const Sizer(height: 16),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.padding / 3,
                            ),
                            child: AuthTextField(
                              readOnly: true,
                              hint: controller.emailController.text.isEmpty
                                  ? 'Email'
                                  : controller.emailController.text,
                              controller: controller.emailController,
                              prefixIcon: const Icon(Icons.email_outlined),
                            ),
                          ),
                          const Sizer(height: 16),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.padding / 3,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: RadioListTile<int>(
                                    title: Text(S.current.male),
                                    value: 1,
                                    groupValue: state.gender,
                                    activeColor: ColorRes.primary,
                                    contentPadding: EdgeInsets.zero,
                                    onChanged: null,
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile<int>(
                                    title: Text(S.current.female),
                                    value: 2,
                                    groupValue: state.gender,
                                    activeColor: ColorRes.primary,
                                    contentPadding: EdgeInsets.zero,
                                    onChanged: null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.padding / 3,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: RadioListTile<int>(
                                    title: Text(S.current.saudi),
                                    value: 1,
                                    groupValue: state.nationality,
                                    activeColor: ColorRes.primary,
                                    contentPadding: EdgeInsets.zero,
                                    onChanged: null,
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile<int>(
                                    title: Text(S.current.nonSaudi),
                                    value: 2,
                                    groupValue: state.nationality,
                                    activeColor: ColorRes.primary,
                                    contentPadding: EdgeInsets.zero,
                                    onChanged: null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.padding / 3,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: RadioListTile<int>(
                                    title: Text(S.current.jeddah),
                                    value: 1,
                                    groupValue: state.city,
                                    activeColor: ColorRes.primary,
                                    contentPadding: EdgeInsets.zero,
                                    onChanged: null,
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile<int>(
                                    title: Text(S.current.makka),
                                    value: 2,
                                    groupValue: state.city,
                                    activeColor: ColorRes.primary,
                                    contentPadding: EdgeInsets.zero,
                                    onChanged: null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                /// Bottom button - fixed at bottom
                const Sizer(
                  height: 90,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
