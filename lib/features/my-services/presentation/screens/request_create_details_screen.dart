import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/device/device_utility.dart';
import 'package:shaoni/core/service_locator/service_locator.dart';
import 'package:shaoni/core/utils/helpers/date_converter.dart';
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
        body: Builder(
          builder: (context) {
            final controller = context.read<RequestServiceCubit>();
            return Padding(
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
                                controller: controller.hijriDateController,
                                readOnly: true,
                                onTap: () async {
                                  final DateTime?
                                  pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2026),
                                    lastDate: DateTime(2100),
                                    helpText: S.current.selectDate,
                                    cancelText: S.current.cancel,
                                    confirmText: S.current.done,
                                    initialEntryMode:
                                        DatePickerEntryMode.calendar,
                                    initialDatePickerMode: DatePickerMode.day,
                                    builder: (
                                      BuildContext context,
                                      Widget? child,
                                    ) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: ColorRes.primary,
                                            onPrimary: ColorRes.white,
                                            surface: ColorRes.white,
                                            onSurface: ColorRes.black,
                                          ),
                                          textTheme: TextTheme(
                                            titleLarge: TextStyle(
                                              color: ColorRes.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 6,
                                            ),
                                          ),
                                          dialogTheme: DialogTheme(
                                            backgroundColor: ColorRes.white,
                                            titleTextStyle: Theme.of(
                                              context,
                                            ).textTheme.headlineSmall?.copyWith(
                                              color: ColorRes.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 6,
                                            ),
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              foregroundColor: ColorRes.primary,
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (pickedDate != null) {
                                    // Format Gregorian date
                                    final String gregorianDate =
                                        '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
                                    controller.dateController.text =
                                        gregorianDate;

                                    // Convert to Hijri and update Hijri controller
                                    final String hijriDate =
                                        DateConverter.convertGregorianToHijri(
                                          gregorianDate,
                                        );
                                    controller.hijriDateController.text =
                                        hijriDate;
                                  }
                                },
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
                                controller: controller.dateController,
                                readOnly: true,
                                onTap: () async {
                                  final DateTime?
                                  pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2026),
                                    lastDate: DateTime(2100),
                                    helpText: S.current.selectDate,
                                    cancelText: S.current.cancel,
                                    confirmText: S.current.done,
                                    initialDatePickerMode: DatePickerMode.day,
                                    initialEntryMode:
                                        DatePickerEntryMode.calendar,
                                    builder: (
                                      BuildContext context,
                                      Widget? child,
                                    ) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: ColorRes.primary,
                                            onPrimary: ColorRes.white,
                                            surface: ColorRes.white,
                                            onSurface: ColorRes.black,
                                          ),
                                          textTheme: TextTheme(
                                            titleLarge: TextStyle(
                                              color: ColorRes.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 6,
                                            ),
                                          ),
                                          dialogTheme: DialogTheme(
                                            backgroundColor: ColorRes.white,
                                            titleTextStyle: Theme.of(
                                              context,
                                            ).textTheme.headlineSmall?.copyWith(
                                              color: ColorRes.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 6,
                                            ),
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              foregroundColor: ColorRes.primary,
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (pickedDate != null) {
                                    /// Format Gregorian date
                                    final String gregorianDate =
                                        '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
                                    controller.dateController.text =
                                        gregorianDate;

                                    /// Convert to Hijri and update Hijri controller
                                    final String hijriDate =
                                        DateConverter.convertGregorianToHijri(
                                          gregorianDate,
                                        );
                                    controller.hijriDateController.text =
                                        hijriDate;
                                  }
                                },
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
                            /// name
                            AuthTextField(
                              hint: S.current.applicantName,
                              controller: controller.applicantNameController,
                              borderRadius: AppSizes.borderRadiusMd,
                            ),

                            /// organization
                            AuthTextField(
                              hint: S.current.organizationalUnit,
                              controller:
                                  controller.organizationalUnitController,
                              borderRadius: AppSizes.borderRadiusMd,
                            ),

                            /// location
                            AuthTextField(
                              hint: S.current.location,
                              controller: controller.locationController,
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
                            /// date
                            Flexible(
                              child: AuthTextField(
                                borderRadius: AppSizes.borderRadiusMd,
                                hint: S.current.permissionDate,
                                suffixIcon: Icon(
                                  Icons.date_range,
                                  color: ColorRes.grey2.withOpacity(0.5),
                                ),
                                controller: controller.dateController,
                              ),
                            ),

                            /// time
                            Flexible(
                              child: AuthTextField(
                                borderRadius: AppSizes.borderRadiusMd,
                                hint: S.current.durationInHours,
                                suffixIcon: Icon(
                                  Icons.hourglass_bottom_sharp,
                                  color: ColorRes.grey2.withOpacity(0.5),
                                ),
                                controller: controller.durationItemsController,
                              ),
                            ),
                          ],
                        ),
                        const Sizer(height: 20),

                        /// permission time and type
                        Row(
                          spacing: 10,
                          children: [
                            Flexible(
                              child: Container(
                                color: ColorRes.white,
                                child: DropdownButtonFormField<String>(
                                  style: TextStyle(
                                    fontSize: AppSizes.fontSizeSm,
                                    color: ColorRes.grey2.withOpacity(0.7),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: S.current.permissionType,
                                    hintStyle: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      color: ColorRes.grey2.withOpacity(0.1),
                                      fontSize: AppSizes.fontSizeXLg,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: AppSizes.spaceBetweenIcon * 3,
                                    ),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                  ),
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: ColorRes.grey2.withOpacity(0.5),
                                  ),
                                  items: controller.permissionTypeItems,
                                  onChanged: (value) {
                                    controller.permissionTypeController.text =
                                        value ?? '';
                                  },
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                color: ColorRes.white,
                                child: DropdownButtonFormField<String>(
                                  style: TextStyle(
                                    fontSize: AppSizes.fontSizeSm,
                                    color: ColorRes.grey2.withOpacity(0.7),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: S.current.permissionTime,
                                    hintStyle: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      color: ColorRes.white.withOpacity(0.7),
                                      fontSize: AppSizes.fontSizeXLg,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: AppSizes.spaceBetweenIcon * 3,
                                    ),

                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        AppSizes.borderRadiusMd,
                                      ),
                                      borderSide: const BorderSide(
                                        color: ColorRes.primary,
                                        width: 2,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        AppSizes.borderRadiusMd,
                                      ),
                                      borderSide: BorderSide(
                                        color: ColorRes.grey_F707340,
                                        width: 1,
                                      ),
                                    ),

                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        AppSizes.borderRadiusMd,
                                      ),
                                      borderSide: const BorderSide(
                                        color: ColorRes.primary,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: ColorRes.grey2.withOpacity(0.5),
                                  ),
                                  items: controller.durationItems,
                                  onChanged: (value) {
                                    controller.durationItemsController.text =
                                        value ?? '';
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),

                        /// Extra space so content doesn't hide behind the floating buttons
                        const Sizer(height: 120),
                      ],
                    ),
                  ),

                  /// Floating blur buttons at the bottom
                  CreateDeleteButtons(
                    deleteTab: () {
                      print("object");
                    },
                    createTab: (){
                      print("object2");
                      print("object2");
                      print("object2");
                      print("object2");
                      print("object2");
                      print("object2");
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
