import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../generated/l10n.dart';
import '../../../../human_resources/presentation/attendance/widget/attendance_dropdown_field.dart';
import '../../../../human_resources/presentation/attendance/widget/attendance_editable_field.dart';
import '../../controller/salary_requests/salary_requests_cubit.dart';
import '../../controller/salary_requests/salary_requests_state.dart';
import 'salary_bank_details_widget.dart';
import 'salary_definition_details_widget.dart';

class SalaryRequestDataWidget extends StatelessWidget {
  const SalaryRequestDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalaryRequestsCubit, SalaryRequestsState>(
      builder: (context, state) {
        final controller = context.read<SalaryRequestsCubit>();
        final lookups = controller.lookups;

        if (lookups == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DDropdownField(
              label: S.current.requestType,
              hint: S.current.selectRequestType,
              icon: Icons.list_alt,
              items: lookups.salaryTypes
                  .map((e) => DropdownMenuItem<String>(
                        value: e.code,
                        child: Text(e
                            .nameAr), // Could add logic for nameEn based on locale later
                      ))
                  .toList(),
              value: controller.selectedSalaryRequestType,
              onChanged: (val) {
                if (val != null) {
                  controller.setSalaryRequestType(val);
                }
              },
            ),
            const Sizer(height: 16),
            if (controller.selectedSalaryRequestType != null) ...[
              if (controller.selectedSalaryRequestType ==
                  'salary_definition_request')
                const SalaryDefinitionDetailsWidget()
              else
                const SalaryBankDetailsWidget(),
              const Sizer(height: 16),
              DDropdownField(
                label: S.current.salaryDocumentType,
                hint: S.current.selectSalaryDocumentType,
                icon: Icons.description,
                items: lookups.salaryDocumentTypes
                    .map((e) => DropdownMenuItem<String>(
                          value: e.code,
                          child: Text(e.nameAr),
                        ))
                    .toList(),
                value: controller.requiredDocumentController.text.isEmpty
                    ? null
                    : controller.requiredDocumentController.text,
                onChanged: (val) {
                  controller.requiredDocumentController.text = val ?? '';
                },
              ),
              const Sizer(height: 16),
              DEditableField(
                label: S.current.notes,
                hint: S.current.notes,
                icon: Icons.note,
                readOnly: false,
                controller: controller.noteController,
                keyboardType: TextInputType.multiline,
              ),
            ],
          ],
        );
      },
    );
  }
}
