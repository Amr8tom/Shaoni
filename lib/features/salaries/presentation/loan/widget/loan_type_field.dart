import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../generated/l10n.dart';
import '../../../../human_resources/presentation/attendance/widget/attendance_dropdown_field.dart';
import '../../../domain/entity/loan/loan_type.dart';
import '../../controller/loan/loan_cubit.dart';
import '../../controller/loan/loan_state.dart';
import 'loan_field_label.dart';

/// Loan type dropdown. Reads the loaded lookups and the current selection
/// from state; selection is delegated to the cubit.
class LoanTypeField extends StatelessWidget {
  const LoanTypeField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoanCubit, LoanState>(
      buildWhen: (previous, current) => current is LoanLookupsLoaded,
      builder: (context, state) {
        final cubit = LoanCubit.get(context);
        final loaded = state is LoanLookupsLoaded ? state : null;
        final loanTypes = loaded?.loanTypes ?? const <LoanType>[];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoanFieldLabel(S.current.loanType),
            const Sizer(height: 8),
            DDropdownField(
              label: '',
              hint: S.current.loanType,
              icon: Icons.account_balance_wallet_outlined,
              value: loaded?.selectedLoanTypeName,
              items: loanTypes
                  .map(
                    (t) => DropdownMenuItem<String>(
                      value: t.name,
                      child: Text(t.name, overflow: TextOverflow.ellipsis),
                    ),
                  )
                  .toList(),
              onChanged: (name) {
                if (name == null) return;
                cubit.selectLoanType(
                  loanTypes.firstWhere((t) => t.name == name),
                );
              },
              validator: (v) => v == null ? S.current.thisFieldRequired : null,
            ),
          ],
        );
      },
    );
  }
}
