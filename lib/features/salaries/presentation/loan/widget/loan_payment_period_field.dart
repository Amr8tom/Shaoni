import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/utils/helpers/arabic_to_english_number_formatter.dart';
import '../../../../../generated/l10n.dart';
import '../../../../auth/presentation/widgets/auth_text_filed.dart';
import '../../controller/loan/loan_cubit.dart';
import 'loan_field_label.dart';

/// Repayment period in months (whole number). The controller lives in the cubit.
class LoanPaymentPeriodField extends StatelessWidget {
  const LoanPaymentPeriodField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = LoanCubit.get(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LoanFieldLabel(S.current.loanPaymentPeriod),
        const Sizer(height: 8),
        AuthTextField(
          hint: S.current.loanPaymentPeriod,
          controller: cubit.paymentPeriodController,
          borderRadius: AppSizes.borderRadiusMd,
          keyboardType: TextInputType.number,
          inputFormatters: [
            ArabicToEnglishNumberFormatter(),
            FilteringTextInputFormatter.digitsOnly,
          ],
          validator: (v) =>
              (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
        ),
      ],
    );
  }
}
