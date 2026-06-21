import 'package:flutter/material.dart';
import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../generated/l10n.dart';
import '../../../../auth/presentation/widgets/auth_text_filed.dart';
import '../../controller/loan/loan_cubit.dart';
import 'loan_field_label.dart';

/// First installment date. Read-only field; the date picker logic lives in the
/// cubit so this widget stays declarative.
class LoanFirstInstallmentDateField extends StatelessWidget {
  const LoanFirstInstallmentDateField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = LoanCubit.get(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LoanFieldLabel(S.current.firstInstallmentDate),
        const Sizer(height: 8),
        AuthTextField(
          hint: S.current.selectDate,
          controller: cubit.firstInstallmentDateController,
          readOnly: true,
          borderRadius: AppSizes.borderRadiusMd,
          suffixIcon: const Icon(Icons.calendar_today_outlined),
          onTap: () => cubit.pickFirstInstallmentDate(context),
          validator: (v) =>
              (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,

        ),
      ],
    );
  }
}
