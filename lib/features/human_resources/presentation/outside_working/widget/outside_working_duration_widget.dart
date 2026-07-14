import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/theme/theme.dart';
import 'package:shaoni/features/human_resources/presentation/attendance/widget/attendance_dropdown_field.dart';
import 'package:shaoni/features/human_resources/presentation/attendance/widget/attendance_editable_field.dart';
import 'package:shaoni/features/human_resources/presentation/controller/outside_working/outside_working_cubit.dart';
import 'package:shaoni/generated/l10n.dart';

/// تاريخ البداية + تاريخ النهاية + يشمل عطلات؟ + طريقة إثبات الإنجاز
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
      builder: DAppTheme.datePickerBuilder,
    );
    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd', 'en').format(picked);
    }
  }

  /// The lookups return the backend code in `nameEn` and the label in `nameAr`.
  String _label(String nameAr, String nameEn) => S.current.localeee == 'en'
      ? (nameEn.isEmpty ? nameAr : nameEn)
      : (nameAr.isEmpty ? nameEn : nameAr);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OutsideWorkingCubit>();

    return BlocBuilder<OutsideWorkingCubit, OutsideWorkingState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── تاريخ البداية ───────────────────────────────────────────────
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

            // ── تاريخ الانتهاء ──────────────────────────────────────────────
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

            // ── يشمل عطلات؟ ─────────────────────────────────────────────────
            DDropdownField(
              label: S.current.includeWeekend,
              hint: S.current.select,
              icon: Icons.weekend_rounded,
              value: state.includeWeekend ? 'true' : 'false',
              items: [
                DropdownMenuItem<String>(
                  value: 'true',
                  child:
                      Text(S.current.yes, style: const TextStyle(fontSize: 12)),
                ),
                DropdownMenuItem<String>(
                  value: 'false',
                  child:
                      Text(S.current.no, style: const TextStyle(fontSize: 12)),
                ),
              ],
              onChanged: (v) {
                if (v != null) cubit.setIncludeWeekend(v == 'true');
              },
              validator: (v) =>
                  (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
            ),
            const Sizer(height: 20),

            // ── طريقة إثبات الإنجاز ─────────────────────────────────────────
            DDropdownField(
              label: S.current.attendanceWay,
              hint: S.current.selectAttendanceWay,
              icon: Icons.fingerprint_rounded,
              value: state.attendanceWayCode,
              items: state.attendanceWays
                  .map((w) => DropdownMenuItem<String>(
                        value: w.nameEn,
                        child: Text(_label(w.nameAr, w.nameEn),
                            style: const TextStyle(fontSize: 12)),
                      ))
                  .toList(),
              onChanged: cubit.onAttendanceWaySelected,
              validator: (v) =>
                  (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
            ),
          ],
        );
      },
    );
  }
}
