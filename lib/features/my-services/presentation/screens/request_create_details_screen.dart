import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/device/device_utility.dart';
import 'package:shaoni/core/service_locator/service_locator.dart';
import 'package:shaoni/features/auth/presentation/widgets/auth_text_filed.dart';
import 'package:shaoni/features/my-services/presentation/widgets/create_delete_buttons.dart';
import '../../../../generated/l10n.dart';
import '../../../navigation/presentation/widgets/custom_navigation_appbar.dart';
import '../controller/request_services/request_service_cubit.dart';



class RequestCreateDetailsScreen extends StatelessWidget {
  const RequestCreateDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => serviceLocator<RequestServiceCubit>(),
  child: Scaffold(
      appBar: customAppBar(
        showBackArrow: true,
        height: DDeviceUtils.getAppBarHeight() * 3,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: ColorRes.grey6,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.padding * 1.5),
        child: Stack(
          children: [
            /// Scrollable content
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Sizer(height: 220),

                  /// dates titles and text fields
                  Text(
                    S.current.date,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Flexible(
                        child: AuthTextField(
                          borderRadius: AppSizes.borderRadiusMd,
                          hint: S.current.hijriDate,
                          suffixIcon: Icon(
                            Icons.date_range,
                            color: ColorRes.grey2.withOpacity(0.5),
                          ),
                          controller: TextEditingController(),
                        ),
                      ),
                      Flexible(
                        child: AuthTextField(
                          borderRadius: AppSizes.borderRadiusMd,
                          hint: S.current.dateBirth,
                          suffixIcon: Icon(
                            Icons.date_range,
                            color: ColorRes.grey2.withOpacity(0.5),
                          ),
                          controller: TextEditingController(),
                        ),
                      ),
                    ],
                  ),

                  /// data for request applicant
                  const Sizer(height: 35),
                  Text(
                    S.current.requestApplicantData,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Column(
                    children: [
                      AuthTextField(
                        hint: S.current.applicantName,
                        controller: TextEditingController(),
                        borderRadius: AppSizes.borderRadiusMd,
                      ),
                      AuthTextField(
                        hint: S.current.organizationalUnit,
                        controller: TextEditingController(),
                        borderRadius: AppSizes.borderRadiusMd,
                      ),
                      AuthTextField(
                        hint: S.current.location,
                        controller: TextEditingController(),
                        borderRadius: AppSizes.borderRadiusMd,
                      ),
                    ],
                  ),

                  /// request data
                  const Sizer(height: 35),
                  Text(
                    S.current.requestDetails,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  /// permission data and time
                  Row(
                    spacing: 10,
                    children: [
                      Flexible(
                        child: AuthTextField(
                          borderRadius: AppSizes.borderRadiusMd,
                          hint: S.current.permissionDate,
                          suffixIcon: Icon(
                            Icons.date_range,
                            color: ColorRes.grey2.withOpacity(0.5),
                          ),
                          controller: TextEditingController(),
                        ),
                      ),
                      Flexible(
                        child: AuthTextField(
                          borderRadius: AppSizes.borderRadiusMd,
                          hint: S.current.permissionDate,
                          suffixIcon: Icon(
                            Icons.lock_clock,
                            color: ColorRes.grey2.withOpacity(0.5),
                          ),
                          controller: TextEditingController(),
                        ),
                      ),
                    ],
                  ),

                  /// permission time and duration
                  Row(
                    spacing: 10,
                    children: [
                      Flexible(
                        child: AuthTextField(
                          borderRadius: AppSizes.borderRadiusMd,
                          hint: S.current.permissionType,
                          suffixIcon: Icon(
                            Icons.date_range,
                            color: ColorRes.grey2.withOpacity(0.5),
                          ),
                          controller: TextEditingController(),
                        ),
                      ),
                      Flexible(
                        child: AuthTextField(
                          borderRadius: AppSizes.borderRadiusMd,
                          hint: S.current.durationInHours,
                          suffixIcon: Icon(
                            Icons.date_range,
                            color: ColorRes.grey2.withOpacity(0.5),
                          ),
                          controller: TextEditingController(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Flexible(
                        child: AuthTextField(
                          borderRadius: AppSizes.borderRadiusMd,
                          hint: S.current.permissionType,
                          suffixIcon: Icon(
                            Icons.date_range,
                            color: ColorRes.grey2.withOpacity(0.5),
                          ),
                          controller: TextEditingController(),
                        ),
                      ),
                      Flexible(
                        child: AuthTextField(
                          borderRadius: AppSizes.borderRadiusMd,
                          hint: S.current.durationInHours,
                          suffixIcon: Icon(
                            Icons.date_range,
                            color: ColorRes.grey2.withOpacity(0.5),
                          ),
                          controller: TextEditingController(),
                        ),
                      ),
                    ],
                  ),

                  // Extra space so content doesn't hide behind the floating buttons
                  const Sizer(height: 120),
                ],
              ),
            ),

            /// Floating blur buttons at the bottom
            const CreateDeleteButtons(),
          ],
        ),
      ),
    ),
);
  }
}
