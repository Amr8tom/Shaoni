import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../core/constants/colors.dart';
import '../../attendance/widget/attendance_dropdown_field.dart';
import '../../attendance/widget/attendance_editable_field.dart';
import '../../controller/complaint_request/complaint_request_cubit.dart';

/// "بيانات الطلب" section of the complaint-request screen.
///
/// Three fields — complaint type (lookup dropdown), complaint reason
/// (lookup dropdown), and a free-text description. Reuses the modern
/// form atoms originally built for the attendance form so the visual
/// language stays consistent across HR services.
class ComplaintRequestDataWidget extends StatelessWidget {
  const ComplaintRequestDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ComplaintRequestCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /// ─── Row: complaint type  |  complaint reason ────────────────
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: DDropdownField(
                  label: S.current.complaintType,
                  hint: S.current.selectComplaintType,
                  icon: Icons.report_problem_rounded,
                  items: controller.complaintTypeItems,
                  value: controller.complaintTypeController.text.isEmpty
                      ? null
                      : controller.complaintTypeController.text,
                  onChanged: (value) {
                    controller.complaintTypeController.text = value ?? '';
                  },
                  validator: _requiredValidator,
                ),
              ),
              const Sizer(width: 14),
              Expanded(
                child: DDropdownField(
                  label: S.current.complaintReason,
                  hint: S.current.selectComplaintReason,
                  icon: Icons.help_outline_rounded,
                  items: controller.complaintReasonItems,
                  value: controller.complaintReasonController.text.isEmpty
                      ? null
                      : controller.complaintReasonController.text,
                  onChanged: (value) {
                    controller.complaintReasonController.text = value ?? '';
                  },
                  validator: _requiredValidator,
                ),
              ),
            ],
          ),
        ),
        const Sizer(height: 14),

        /// ─── Full-width: complaint description ───────────────────────
        DEditableField(
          label: S.current.complaintDescription,
          hint: S.current.complaintDescriptionHint,
          icon: Icons.description_rounded,
          iconColor: ColorRes.black,
          controller: controller.complaintDescriptionController,
          readOnly: false,
          keyboardType: TextInputType.multiline,
          validator: _requiredValidator,
        ),
      ],
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseEndterValue;
    }
    return null;
  }
}
