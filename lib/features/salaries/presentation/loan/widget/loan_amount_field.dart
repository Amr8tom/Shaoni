import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/utils/helpers/arabic_to_english_number_formatter.dart';
import '../../../../../generated/l10n.dart';
import '../../../../auth/presentation/widgets/auth_text_filed.dart';
import '../../controller/loan/loan_cubit.dart';
import 'loan_field_label.dart';

/// Loan amount input (decimal). The controller lives in the cubit.
class LoanAmountField extends StatelessWidget {
  const LoanAmountField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = LoanCubit.get(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LoanFieldLabel(S.current.loanAmount),
        const Sizer(height: 8),
        AuthTextField(
          hint: S.current.loanAmount,
          controller: cubit.amountController,
          borderRadius: AppSizes.borderRadiusMd,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            ArabicToEnglishNumberFormatter(),
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
          ],
          validator: (v) =>
              (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
        ),
      ],
    );
  }
}
