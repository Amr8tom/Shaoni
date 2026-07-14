import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/features/human_resources/domain/entity/outside_working/outside_working_employee.dart';
import 'package:shaoni/features/human_resources/presentation/controller/outside_working/outside_working_cubit.dart';
import 'package:shaoni/generated/l10n.dart';

/// Searchable employee multi-select.
///
/// The list is scoped by the chosen department type: "same department" shows
/// only the applicant's colleagues, any other type shows everyone.
class OutsideWorkingEmployeesWidget extends StatelessWidget {
  const OutsideWorkingEmployeesWidget({super.key});

  /// Keeps the box from growing to the full directory length.
  static const double _listMaxHeight = 300;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OutsideWorkingCubit>();

    return BlocBuilder<OutsideWorkingCubit, OutsideWorkingState>(
      builder: (context, state) {
        final employees = state.visibleEmployees;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Search ────────────────────────────────────────────────────
            Text(
              S.current.searchEmployee,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            const Sizer(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: '${S.current.searchEmployee}...',
                filled: true,
                fillColor: ColorRes.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: ColorRes.greyShade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: ColorRes.greyShade300),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onChanged: cubit.onEmployeeSearchChanged,
            ),
            const Sizer(height: 12),

            // ── Employee checkbox list ────────────────────────────────────
            Container(
              constraints: const BoxConstraints(maxHeight: _listMaxHeight),
              decoration: BoxDecoration(
                color: ColorRes.white,
                border: Border.all(color: ColorRes.greyShade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: employees.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          S.current.noEmployeesFound,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: employees.length,
                      separatorBuilder: (_, __) =>
                          Divider(height: 1, color: ColorRes.greyShade300),
                      itemBuilder: (context, index) {
                        final employee = employees[index];
                        return _EmployeeCheckTile(
                          employee: employee,
                          isSelected: state.isEmployeeSelected(employee),
                          onTap: () => cubit.toggleEmployee(employee),
                        );
                      },
                    ),
            ),

            // ── Department scoping note ───────────────────────────────────
            const Sizer(height: 8),
            Text(
              S.current.sameDepartmentEmployeesNote,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: ColorRes.grey2),
            ),
          ],
        );
      },
    );
  }
}

class _EmployeeCheckTile extends StatelessWidget {
  final OutsideWorkingEmployee employee;
  final bool isSelected;
  final VoidCallback onTap;

  const _EmployeeCheckTile({
    required this.employee,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final label = employee.jobTitle.isEmpty
        ? employee.name
        : '${employee.name} - ${employee.jobTitle}';

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: isSelected,
                onChanged: (_) => onTap(),
                activeColor: ColorRes.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),
            const Sizer(width: 12),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
