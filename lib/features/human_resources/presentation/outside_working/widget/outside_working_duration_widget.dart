import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/features/human_resources/presentation/attendance/widget/attendance_dropdown_field.dart';
import 'package:shaoni/features/human_resources/presentation/attendance/widget/attendance_editable_field.dart';
import 'package:shaoni/features/human_resources/presentation/controller/outside_working/outside_working_cubit.dart';
import 'package:shaoni/generated/l10n.dart';

/// تاريخ البداية + تاريخ النهاية + طريقة الحضور + يشمل عطلات
class OutsideWorkingDurationWidget extends StatelessWidget {
  const OutsideWorkingDurationWidget({super.key});

  Future<void> _pickDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: ColorScheme.light(
            primary: ColorRes.primary,
            onPrimary: ColorRes.white,
            surface: ColorRes.white,
            onSurface: ColorRes.black,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: ColorRes.primary),
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd', 'en').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<OutsideWorkingCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── تاريخ البداية ─────────────────────────────────────────────────
        DEditableField(
          label: S.current.startDate,
          hint: S.current.startDate,
          icon: Icons.calendar_today_rounded,
          iconColor: ColorRes.black,
          controller: cubit.startDateController,
          readOnly: true,
          onTap: () => _pickDate(context, cubit.startDateController),
          validator: (v) =>
              (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
        ),
        const Sizer(height: 20),

        // ── تاريخ النهاية ─────────────────────────────────────────────────
        DEditableField(
          label: S.current.endDate,
          hint: S.current.endDate,
          icon: Icons.calendar_month_rounded,
          iconColor: ColorRes.black,
          controller: cubit.endDateController,
          readOnly: true,
          onTap: () => _pickDate(context, cubit.endDateController),
          validator: (v) =>
              (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
        ),
        const Sizer(height: 20),

        // ── طريقة الحضور ──────────────────────────────────────────────────
        DDropdownField(
          label: S.current.attendanceWay,
          hint: S.current.selectAttendanceWay,
          icon: Icons.fingerprint_rounded,
          items: cubit.attendanceWayItems,
          value: cubit.attendanceWayController.text.isEmpty
              ? null
              : cubit.attendanceWayController.text,
          onChanged: cubit.onAttendanceWaySelected,
          validator: (v) =>
              (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
        ),
      ],
    );
  }
}
