import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/features/human_resoures/presentation/attendance/widget/attendance_dropdown_field.dart';
import 'package:shaoni/features/human_resoures/presentation/attendance/widget/attendance_editable_field.dart';
import 'package:shaoni/features/study&training/presentaion/controller/study/study_cubit.dart';
import 'package:shaoni/features/study&training/presentaion/study/widget/study_date_picker_field.dart';
import 'package:shaoni/generated/l10n.dart';

class StudyRequestDataWidget extends StatelessWidget {
  const StudyRequestDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<StudyCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Row: study type | required study (text) | destination ────────
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: DDropdownField(
                label: S.current.studyType,
                hint: S.current.selectStudyType,
                icon: Icons.school_rounded,
                items: controller.studyTypeItems,
                value: controller.studyTypeController.text.isEmpty
                    ? null
                    : controller.studyTypeController.text,
                onChanged: (value) {
                  controller.studyTypeController.text = value ?? '';
                },
                validator: (v) => (v == null || v.isEmpty)
                    ? S.current.studyTypeRequired
                    : null,
              ),
            ),
            SizedBox(width: AppSizes.padding * 0.6),

            Expanded(
              child: DEditableField(
                label: S.current.requiredStudy,
                hint: S.current.requiredStudyHint,
                icon: Icons.menu_book_rounded,
                iconColor: ColorRes.black,
                controller: controller.requiredStudyController,
                readOnly: false,
                keyboardType: TextInputType.text,
                validator: (v) => (v == null || v.isEmpty)
                    ? S.current.thisFieldRequired
                    : null,
              ),
            ),
            SizedBox(width: AppSizes.padding * 0.6),

            Expanded(
              child: DDropdownField(
                label: S.current.studyDestination,
                hint: S.current.selectStudyDestination,
                icon: Icons.location_on_rounded,
                items: controller.studyDestinationItems,
                value: controller.studyDestinationController.text.isEmpty
                    ? null
                    : controller.studyDestinationController.text,
                onChanged: (value) {
                  controller.studyDestinationController.text = value ?? '';
                },
                validator: (v) => (v == null || v.isEmpty)
                    ? S.current.destinationRequired
                    : null,
              ),
            ),
          ],
        ),
        const Sizer(height: 20),

        // ── Study duration: start date | end date ────────────────────────
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StudyDatePickerField(
                label: S.current.startDate,
                gregorianController: controller.courseStartDateController,
                hijriController: controller.courseStartHijriController,
                onDateSelected: (gregorian, hijri) {
                  controller.courseStartDateController.text = gregorian;
                  controller.courseStartHijriController.text = hijri;
                  _updateDuration(controller);
                },
              ),
            ),
            SizedBox(width: AppSizes.padding * 0.6),

            Expanded(
              child: StudyDatePickerField(
                label: S.current.endDate,
                gregorianController: controller.courseEndDateController,
                hijriController: controller.courseEndHijriController,
                onDateSelected: (gregorian, hijri) {
                  controller.courseEndDateController.text = gregorian;
                  controller.courseEndHijriController.text = hijri;
                  _updateDuration(controller);
                },
              ),
            ),
          ],
        ),
        const Sizer(height: 20),

        // ── Reason / justification ───────────────────────────────────────
        DEditableField(
          label: S.current.orderReason,
          hint: S.current.orderReasonHint,
          icon: Icons.notes_rounded,
          iconColor: ColorRes.black,
          controller: controller.reasonController,
          readOnly: false,
          keyboardType: TextInputType.multiline,
          validator: (v) => (v == null || v.isEmpty)
              ? S.current.thisFieldRequired
              : null,
        ),
      ],
    );
  }

  void _updateDuration(StudyCubit controller) {
    final start = controller.courseStartDateController.text;
    final end = controller.courseEndDateController.text;
    if (start.isEmpty || end.isEmpty) return;
    try {
      final startDate = DateTime.parse(start);
      final endDate = DateTime.parse(end);
      if (endDate.isBefore(startDate)) return;
      final days = endDate.difference(startDate).inDays;
      final months = (days / 30).floor();
      final remDays = days % 30;
      controller.durationController.text =
          months > 0 ? '$months شهر و $remDays يوم' : '$days يوم';
    } catch (_) {}
  }
}
