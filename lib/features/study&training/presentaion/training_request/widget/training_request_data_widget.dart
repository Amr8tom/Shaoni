import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/features/human_resoures/presentation/attendance/widget/attendance_dropdown_field.dart';
import 'package:shaoni/features/human_resoures/presentation/attendance/widget/attendance_editable_field.dart';
import 'package:shaoni/features/human_resoures/presentation/controller/training_request/training_request_cubit.dart';
import 'package:shaoni/generated/l10n.dart';

class TrainingRequestDataWidget extends StatelessWidget {
  const TrainingRequestDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TrainingRequestCubit>();
    final selectedCourse = controller.state.selectedCourse;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Dropdown: course ────────────────────────────────────────────────
        DDropdownField(
          label: S.current.course,
          hint: S.current.selectCourse,
          icon: Icons.school_rounded,
          items: controller.courseItems,
          value: controller.courseController.text.isEmpty
              ? null
              : controller.courseController.text,
          onChanged: (value) {
            controller.courseController.text = value ?? '';
            controller.selectCourse(value);
          },
          validator: (v) =>
              (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
        ),

        // ── Course metadata (shown after selection) ─────────────────────────
        if (selectedCourse != null) ...[
          const Sizer(height: 16),
          Container(
            padding: EdgeInsets.all(AppSizes.padding * 0.9),
            decoration: BoxDecoration(
              color: ColorRes.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              border: Border.all(color: ColorRes.primary.withOpacity(0.25)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.current.courseDetails,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorRes.primary,
                      ),
                ),
                const Sizer(height: 10),
                _MetaRow(
                  label: S.current.startDate,
                  value: _formatDate(selectedCourse.startDate),
                ),
                _MetaRow(
                  label: S.current.endDate,
                  value: _formatDate(selectedCourse.endDate),
                ),
                _MetaRow(
                  label: S.current.nominationStartDate,
                  value: _formatDate(selectedCourse.nominationStartDate),
                ),
                _MetaRow(
                  label: S.current.nominationEndDate,
                  value: _formatDate(selectedCourse.nominationEndDate),
                ),
                _MetaRow(
                  label: S.current.coursePeriodMonths,
                  value: selectedCourse.coursePeriodMonths.toString(),
                ),
                _MetaRow(
                  label: S.current.nominationPeriodDays,
                  value: selectedCourse.nominationPeriodDays.toString(),
                  isLast: true,
                ),
              ],
            ),
          ),
        ],

        const Sizer(height: 20),

        // ── Text area: note (optional) ───────────────────────────────────────
        DEditableField(
          label: S.current.notes,
          hint: S.current.notesHint,
          icon: Icons.sticky_note_2_outlined,
          iconColor: ColorRes.black,
          controller: controller.noteController,
          readOnly: false,
          keyboardType: TextInputType.multiline,
        ),
      ],
    );
  }

  String _formatDate(String iso) {
    if (iso.isEmpty) return '';
    return iso.length >= 10 ? iso.substring(0, 10) : iso;
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({
    required this.label,
    required this.value,
    this.isLast = false,
  });

  final String label;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: ColorRes.grey2,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorRes.black,
                  ),
            ),
          ],
        ),
        if (!isLast) ...[
          const Sizer(height: 6),
          Divider(height: 1, color: ColorRes.grey5),
          const Sizer(height: 6),
        ],
      ],
    );
  }
}
