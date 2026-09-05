import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../../auth/presentation/widgets/auth_text_filed.dart';
import '../../controller/exit_permission/exit_request_service_cubit.dart';
import '../../../../../core/theme/theme.dart';

class RequestDataWidget extends StatelessWidget {
  const RequestDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ExitRequestServiceCubit>();
    return BlocBuilder<ExitRequestServiceCubit, ExitRequestServiceState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: (state.isPermissionTimeLoading ||
                  state.isPermissionTypesLoading ||
                  state.isInitialized)
              ? true
              : false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        color: ColorRes.grey2.withValues(alpha: 0.5),
                      ),
                      controller: controller.permissionDateController,
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
                          initialDatePickerMode: DatePickerMode.day,
                          initialEntryMode: DatePickerEntryMode.calendar,
                          builder: DAppTheme.datePickerBuilder,
                        );
                        if (pickedDate != null) {
                          controller.permissionDateController.text =
                              DateFormat('yyyy-MM-dd', 'en_US')
                                  .format(pickedDate);
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
                        color: ColorRes.grey2.withValues(alpha: 0.5),
                      ),
                      controller: controller.durationController,
                      validator: (value) {
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

              /// permission time and type
              Row(
                spacing: 10,
                children: [
                  Flexible(
                    child: Container(
                      color: ColorRes.white,
                      child: DropdownButtonFormField<String>(
                        style: TextStyle(
                          fontSize: AppSizes.fontSizeSm * 0.7,
                          color: ColorRes.black.withValues(alpha: 0.7),
                        ),
                        decoration: InputDecoration(
                          hintText: S.current.permissionType,
                          hintStyle: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                                color: ColorRes.grey2.withValues(alpha: 0.1),
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
                          color: ColorRes.grey2.withValues(alpha: 0.5),
                        ),
                        items: controller.permissionTypeItems,
                        onChanged: (value) {
                          controller.permissionTypeController.text =
                              value ?? '';
                        },
                        validator: (value) {
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
                          fontSize: AppSizes.fontSizeSm * 0.7,
                          color: ColorRes.black.withValues(alpha: 0.7),
                        ),
                        decoration: InputDecoration(
                          hintText: S.current.permissionTime,
                          hintStyle: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                                color: ColorRes.white.withValues(alpha: 0.7),
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
                              color: ColorRes.greyF707340,
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
                          color: ColorRes.grey2.withValues(alpha: 0.5),
                        ),
                        items: controller.durationItems,
                        onChanged: (value) {
                          controller.permissionTimeTypeController.text =
                              value ?? '';
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.current.pleaseEndterValue;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),

              /// make size
              const Sizer(height: 20),

              /// request reason (notes) — optional
              AuthTextField(
                borderRadius: AppSizes.borderRadiusMd,
                hint: S.current.orderReason,
                controller: controller.notesController,
                keyboardType: TextInputType.multiline,
                prefixIcon: Icon(
                  Icons.notes_rounded,
                  color: ColorRes.grey2.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
