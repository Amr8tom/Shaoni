import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../generated/l10n.dart';
import '../../../../human_resources/presentation/attendance/widget/attendance_dropdown_field.dart';
import '../../../../human_resources/presentation/attendance/widget/attendance_editable_field.dart';
import '../../controller/salary_requests/salary_requests_cubit.dart';
import '../../controller/salary_requests/salary_requests_state.dart';

class SalaryBankDetailsWidget extends StatelessWidget {
  const SalaryBankDetailsWidget({super.key});

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
              label: S.current.bankCountry,
              hint: S.current.selectBankCountry,
              icon: Icons.flag,
              items: lookups.countries
                  .map((e) => DropdownMenuItem<String>(
                        value: e.id.toString(),
                        child: Text(e.nameAr),
                      ))
                  .toList(),
              value: controller.countryOfBankController.text.isEmpty
                  ? null
                  : controller.countryOfBankController.text,
              onChanged: (val) {
                if (val != null) {
                  controller.countryOfBankController.text = val;
                  controller.fetchBanks(int.parse(val));
                }
              },
            ),
            const Sizer(height: 16),

            if (state is SalaryRequestsBanksLoading)
              const Center(child: CircularProgressIndicator())
            else if (controller.banks.isNotEmpty)
              DDropdownField(
                label: S.current.bankName,
                hint: S.current.selectBank,
                icon: Icons.account_balance,
                items: controller.banks
                    .map((e) => DropdownMenuItem<String>(
                          value: e.id.toString(),
                          child: Text(e.name),
                        ))
                    .toList(),
                value: controller.bankIdController.text.isEmpty
                    ? null
                    : controller.bankIdController.text,
                onChanged: (val) {
                  if (val != null) {
                    controller.bankIdController.text = val;
                  }
                },
              ),

            const Sizer(height: 16),
            DEditableField(
              label: S.current.accountNumber,
              hint: S.current.accountNumber,
              icon: Icons.numbers,
              readOnly: false,
              controller: controller.accountNumberController,
            ),
            const Sizer(height: 16),
            DEditableField(
              label: S.current.ibanNumber,
              hint: S.current.ibanNumber,
              icon: Icons.credit_card,
              readOnly: false,
              controller: controller.ibanController,
            ),

            // TODO: attachment uploaders for iban_attachment and disclaimer_attachment if needed
            // Currently file upload handles general attachment
          ],
        );
      },
    );
  }
}
