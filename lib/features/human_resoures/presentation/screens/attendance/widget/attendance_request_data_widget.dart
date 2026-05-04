import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shaoni/features/human_resoures/presentation/controller/attendance/attendance_cubit.dart';
import '../../../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../../../core/constants/app_sizes.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../auth/presentation/widgets/auth_text_filed.dart';

class AttendanceRequestDataWidget extends StatelessWidget {
  const AttendanceRequestDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AttendanceCubit>();

    return Column(

      children: [
        /// attendance data and time
        Row(
          spacing: 10,
          children: [
            /// date
            Flexible(
              child: AuthTextField(
                borderRadius: AppSizes.borderRadiusMd,
                hint: S.current.selectTime,
                suffixIcon: Icon(
                  Icons.date_range,
                  color: ColorRes.grey2.withOpacity(0.5),
                ),
                controller: controller.attendanceTimeController,
                readOnly: true,
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2026),
                    lastDate: DateTime(2100),
                    helpText: S.current.selectDate,
                    cancelText: S.current.cancel,
                    confirmText: S.current.done,
                    initialDatePickerMode: DatePickerMode.year,
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
                    controller.attendanceTimeController.text =
                        DateFormat('yyyy-MM-dd', 'en_US').format(pickedDate);
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.current.pleaseEndterValue;
                  }
                  return null;
                },
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
                controller: controller.durationController,
                validator:    (value) {
                  if (value == null || value.isEmpty) {
                    return S.current.pleaseEndterValue;
                  }
                  return null;
                },
              ),
            ),
          ],
        ),

        /// make size
        const Sizer(height: 20),
        /// attendance type and forget reason
        Row(
          spacing: 10,
          children: [
            Flexible(
              child: Container(
                color: ColorRes.white,
                child: DropdownButtonFormField<String>(
                  style: TextStyle(
                    fontSize: AppSizes.fontSizeSm*0.7,
                    color: ColorRes.black.withOpacity(0.7),
                  ),
                  decoration: InputDecoration(
                    hintText: S.current.attendanceType,
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
                  items: controller.attendanceTypeItems,
                  onChanged: (value) {
                    controller.attendanceTypeController.text =
                        value ?? '';
                  },
                  validator:    (value) {
                    if (value == null || value.isEmpty) {
                      return S.current.pleaseEndterValue;
                    }
                    return null;
                  },
                ),
              ),
            ),
            Flexible(
              child: Container(
                color: ColorRes.white,
                child: DropdownButtonFormField<String>(
                  style: TextStyle(
                    fontSize: AppSizes.fontSizeSm*0.7,
                    color: ColorRes.black.withOpacity(0.7),
                  ),
                  decoration: InputDecoration(
                    hintText: S.current.forgetReason,
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
                  items: controller.forgetReasonItems,
                  onChanged: (value) {
                    controller.forgetReasonController.text =
                        value ?? '';
                  },
                  validator:    (value) {
                    if (value == null || value.isEmpty) {
                      return S.current.pleaseEndterValue;
                    }
                    return null;
                  },                      ),
              ),
            ),
          ],
        ),
      ],
    );


  }
}
