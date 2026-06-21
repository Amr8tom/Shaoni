import 'package:flutter/material.dart';
import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import 'loan_amount_field.dart';
import 'loan_first_installment_date_field.dart';
import 'loan_kafeel_section.dart';
import 'loan_payment_period_field.dart';
import 'loan_type_field.dart';

class LoanRequestDataWidget extends StatelessWidget {
  const LoanRequestDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.padding),
      decoration: BoxDecoration(
        border: Border.all(color: ColorRes.greyForBorders),
        color: ColorRes.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoanTypeField(),
          Sizer(height: 8),
          LoanAmountField(),
          Sizer(height: 8),
          LoanPaymentPeriodField(),
          Sizer(height: 8),
          LoanFirstInstallmentDateField(),
          Sizer(height: 8),
          LoanKafeelSection(),
        ],
      ),
    );
  }
}
