import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../generated/l10n.dart';
import '../../../../human_resources/presentation/attendance/widget/attendance_dropdown_field.dart';
import '../../../domain/entity/loan/kafeel_employee.dart';
import '../../controller/loan/loan_cubit.dart';
import '../../controller/loan/loan_state.dart';
import 'loan_field_label.dart';

/// "Needs guarantor" checkbox plus the guarantor dropdown shown when enabled.
/// Both the toggle and the selection are owned by the cubit and read from state.
class LoanKafeelSection extends StatelessWidget {
  const LoanKafeelSection({super.key});

  String _label(KafeelEmployee e) =>
      e.quadName.isNotEmpty ? e.quadName : e.engFullName;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoanCubit, LoanState>(
      buildWhen: (previous, current) => current is LoanLookupsLoaded,
      builder: (context, state) {
        final cubit = LoanCubit.get(context);
        final loaded = state is LoanLookupsLoaded ? state : null;
        final kafeelEmployees =
            loaded?.kafeelEmployees ?? const <KafeelEmployee>[];
        final needKafeel = loaded?.needKafeel ?? false;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: needKafeel,
                  activeColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppSizes.borderRadiusSmall / 2),
                  ),
                  onChanged: (value) => cubit.toggleNeedKafeel(value ?? false),
                ),
                LoanFieldLabel(S.current.needsGuarantor),
              ],
            ),
            if (needKafeel) ...[
              const Sizer(height: 4),
              DDropdownField(
                label: '',
                hint: S.current.selectGuarantor,
                icon: Icons.person_outline,
                value: loaded?.selectedKafeelName,
                items: kafeelEmployees
                    .map(
                      (e) => DropdownMenuItem<String>(
                        value: _label(e),
                        child: Text(_label(e), overflow: TextOverflow.ellipsis),
                      ),
                    )
                    .toList(),
                onChanged: (name) {
                  if (name == null) return;
                  final employee =
                      kafeelEmployees.firstWhere((e) => _label(e) == name);
                  cubit.selectKafeelEmployee(employee.id, name);
                },
                validator: (v) => needKafeel && v == null
                    ? S.current.thisFieldRequired
                    : null,
              ),
            ],
          ],
        );
      },
    );
  }
}
