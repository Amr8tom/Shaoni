import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/features/human_resources/presentation/attendance/widget/attendance_dropdown_field.dart';
import 'package:shaoni/features/human_resources/presentation/attendance/widget/attendance_editable_field.dart';
import 'package:shaoni/features/human_resources/presentation/controller/start_work/start_work_cubit.dart';
import 'package:shaoni/features/study&training/presentation/study/widget/study_date_picker_field.dart';
import 'package:shaoni/generated/l10n.dart';

class StartWorkRequestDataWidget extends StatelessWidget {
  const StartWorkRequestDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<StartWorkCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /// ── Row: start work type | employee ────────────────────────────────
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: DDropdownField(
                label: S.current.startWorkType,
                hint: S.current.selectStartWorkType,
                icon: Icons.work_outline_rounded,
                items: controller.startWorkTypeItems,
                value: controller.startWorkTypeController.text.isEmpty
                    ? null
                    : controller.startWorkTypeController.text,
                onChanged: (value) {
                  controller.startWorkTypeController.text = value ?? '';
                },
                validator: (v) => (v == null || v.isEmpty)
                    ? S.current.thisFieldRequired
                    : null,
              ),
            ),
            const Sizer(width: 9.6),
            Expanded(
              child: DDropdownField(
                label: S.current.employee,
                hint: S.current.selectEmployee,
                icon: Icons.person_outline_rounded,
                items: controller.employeeItems,
                value: controller.employeeController.text.isEmpty
                    ? null
                    : controller.employeeController.text,
                onChanged: (value) {
                  controller.employeeController.text = value ?? '';
                },
                validator: (v) => (v == null || v.isEmpty)
                    ? S.current.thisFieldRequired
                    : null,
              ),
            ),
          ],
        ),
        const Sizer(height: 20),

        /// ── Start date ─────────────────────────────────────────────────────
        StudyDatePickerField(
          label: S.current.startDate,
          gregorianController: controller.startDateController,
          hijriController: TextEditingController(),
          onDateSelected: (gregorian, hijri) {
            controller.startDateController.text = gregorian;
          },
        ),
        const Sizer(height: 20),

        /// ── Note ───────────────────────────────────────────────────────────
        DEditableField(
          label: S.current.notes,
          hint: S.current.writeNoteHere,
          icon: Icons.notes_rounded,
          controller: controller.noteController,
          readOnly: false,
          keyboardType: TextInputType.multiline,
        ),
      ],
    );
  }
}
