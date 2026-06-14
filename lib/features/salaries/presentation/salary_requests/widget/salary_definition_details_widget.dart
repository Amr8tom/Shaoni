import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../generated/l10n.dart';
import '../../../../human_resources/presentation/attendance/widget/attendance_dropdown_field.dart';
import '../../../../human_resources/presentation/attendance/widget/attendance_editable_field.dart';
import '../../controller/salary_requests/salary_requests_cubit.dart';
import '../../controller/salary_requests/salary_requests_state.dart';

class SalaryDefinitionDetailsWidget extends StatelessWidget {
  const SalaryDefinitionDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalaryRequestsCubit, SalaryRequestsState>(
      builder: (context, state) {
        final controller = context.read<SalaryRequestsCubit>();
        final lookups = controller.lookups;
        if (lookups == null) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DDropdownField(
              label: S.current.letterDestination,
              hint: S.current.selectLetterDestination,
              icon: Icons.location_city,
              items: lookups.letterDestinations
                  .map((e) => DropdownMenuItem<String>(
                        value: e.id.toString(),
                        child: Text(e.name),
                      ))
                  .toList(),
              value: controller.destinationOfLettersIdController.text.isEmpty
                  ? null
                  : controller.destinationOfLettersIdController.text,
              onChanged: (val) {
                if (val != null) {
                  controller.destinationOfLettersIdController.text = val;
                }
              },
            ),
            const Sizer(height: 16),
            DEditableField(
              label: S.current.orderReason,
              hint: S.current.orderReasonHint,
              icon: Icons.note,
              readOnly: false,
              controller: controller.reasonController,
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return S.current.orderReasonHint;
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }
}
