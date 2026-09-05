import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
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
                onChanged: (value) => controller.selectType(value ?? ''),
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
                onChanged: (value) => controller.selectEmployee(value ?? ''),
                validator: (v) => (v == null || v.isEmpty)
                    ? S.current.thisFieldRequired
                    : null,
              ),
            ),
          ],
        ),
        const Sizer(height: 20),

        /// ── Conditional field (depends on the selected type) ───────────────
        ..._buildConditionalField(context, controller),

        /// ── Start date ─────────────────────────────────────────────────────
        StudyDatePickerField(
          label: S.current.startDate,
          gregorianController: controller.startDateController,
          hijriController: controller.startHijriController,
          onDateSelected: (gregorian, hijri) {
            controller.startDateController.text = gregorian;
            controller.startHijriController.text = hijri;
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

  /// Renders the extra input required by the selected start-work type.
  /// Returns `[]` (nothing) for promotion / types with no extra field.
  List<Widget> _buildConditionalField(
      BuildContext context, StartWorkCubit controller) {
    final kind = controller.activeFieldKind;

    String? requiredValidator(String? v) =>
        (v == null || v.isEmpty) ? S.current.thisFieldRequired : null;

    switch (kind) {
      case StartWorkFieldKind.none:
        return const [];

      case StartWorkFieldKind.contract:
        return [
          _guardedDropdown(
            label: S.current.employeeContract,
            hint: S.current.selectContract,
            icon: Icons.assignment_outlined,
            items: controller.contractItems,
            controller: controller.contractController,
            validator: requiredValidator,
          ),
          const Sizer(height: 20),
        ];

      case StartWorkFieldKind.taskManagement:
        return [
          _guardedDropdown(
            label: S.current.taskManagement,
            hint: S.current.selectTask,
            icon: Icons.assignment_turned_in_outlined,
            items: controller.taskManagementItems,
            controller: controller.taskManagementController,
            validator: requiredValidator,
          ),
          const Sizer(height: 20),
        ];

      case StartWorkFieldKind.leaveType:
        return [
          _guardedDropdown(
            label: S.current.leaveType,
            hint: S.current.selectLeaveType,
            icon: Icons.event_busy_outlined,
            items: controller.leaveTypeItems,
            controller: controller.leaveTypeController,
            validator: requiredValidator,
          ),
          const Sizer(height: 20),
        ];

      case StartWorkFieldKind.employeeTransfer:
        return [
          DEditableField(
            label: S.current.employeeTransfer,
            hint: S.current.employeeTransfer,
            icon: Icons.swap_horiz_rounded,
            controller: controller.employeeTransferController,
            readOnly: false,
            validator: requiredValidator,
          ),
          const Sizer(height: 20),
        ];

      case StartWorkFieldKind.jobTitleModification:
        return [
          DEditableField(
            label: S.current.jobTitleModification,
            hint: S.current.jobTitleModification,
            icon: Icons.badge_outlined,
            controller: controller.jobTitleModificationController,
            readOnly: false,
            validator: requiredValidator,
          ),
          const Sizer(height: 20),
        ];

      case StartWorkFieldKind.extendWorkingPeriod:
        return [
          DEditableField(
            label: S.current.extendWorkingPeriod,
            hint: S.current.extendWorkingPeriod,
            icon: Icons.more_time_rounded,
            controller: controller.extendWorkingPeriodController,
            readOnly: false,
            validator: requiredValidator,
          ),
          const Sizer(height: 20),
        ];

      case StartWorkFieldKind.endLoanPeriod:
        return [
          StudyDatePickerField(
            label: S.current.endLoanPeriod,
            gregorianController: controller.endLoanPeriodController,
            hijriController: controller.endLoanHijriController,
            onDateSelected: (gregorian, hijri) {
              controller.endLoanPeriodController.text = gregorian;
              controller.endLoanHijriController.text = hijri;
            },
          ),
          const Sizer(height: 20),
        ];
    }
  }

  /// A dropdown whose value falls back to null when the stored selection isn't
  /// in the current items (e.g. after the list reloaded for a new employee),
  /// preventing the "exactly one item" dropdown assertion.
  Widget _guardedDropdown({
    required String label,
    required String hint,
    required IconData icon,
    required List<DropdownMenuItem<String>> items,
    required TextEditingController controller,
    required String? Function(String?) validator,
  }) {
    final hasValue = items.any((i) => i.value == controller.text) &&
        controller.text.isNotEmpty;
    return DDropdownField(
      label: label,
      hint: hint,
      icon: icon,
      items: items,
      value: hasValue ? controller.text : null,
      onChanged: (value) => controller.text = value ?? '',
      validator: validator,
    );
  }
}
