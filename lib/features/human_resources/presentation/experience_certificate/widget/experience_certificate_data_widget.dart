import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/features/human_resources/presentation/attendance/widget/attendance_dropdown_field.dart';
import 'package:shaoni/features/human_resources/presentation/attendance/widget/attendance_editable_field.dart';
import 'package:shaoni/features/human_resources/presentation/controller/experience_certificate/experience_certificate_cubit.dart';
import 'package:shaoni/generated/l10n.dart';

class ExperienceCertificateDataWidget extends StatelessWidget {
  const ExperienceCertificateDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ExperienceCertificateCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Dropdown: reason for certificate ────────────────────────────
        DDropdownField(
          label: S.current.certificateReason,
          hint: S.current.selectCertificateReason,
          icon: Icons.description_rounded,
          items: controller.certificateReasonItems,
          value: controller.certificateReasonController.text.isEmpty
              ? null
              : controller.certificateReasonController.text,
          onChanged: (value) {
            controller.certificateReasonController.text = value ?? '';
          },
          validator: (v) =>
              (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
        ),
        const Sizer(height: 20),

        // ── Text area: reason / justification ───────────────────────────
        DEditableField(
          label: S.current.orderReason,
          hint: S.current.orderReasonHint,
          icon: Icons.notes_rounded,
          iconColor: ColorRes.black,
          controller: controller.reasonController,
          readOnly: false,
          keyboardType: TextInputType.multiline,
          validator: (v) =>
              (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
        ),
        const Sizer(height: 20),

        // ── Text area: notes (optional) ─────────────────────────────────
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
}
