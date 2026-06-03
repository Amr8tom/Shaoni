import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/features/human_resoures/domain/entity/outside_working/outside_working_employee.dart';
import 'package:shaoni/features/human_resoures/presentation/controller/outside_working/outside_working_cubit.dart';
import 'package:shaoni/generated/l10n.dart';

/// Searchable employee multi-select list (plain checkbox tiles)
class OutsideWorkingEmployeesWidget extends StatelessWidget {
  const OutsideWorkingEmployeesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<OutsideWorkingCubit>();
    final employees = cubit.filteredEmployees;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Search label + field ──────────────────────────────────────────
        Text(
          S.current.searchEmployee,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const Sizer(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: '${S.current.searchEmployee}...',
            filled: true,
            fillColor: ColorRes.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          onChanged: cubit.onEmployeeSearchChanged,
        ),
        const Sizer(height: 12),

        // ── Employee checkbox list ────────────────────────────────────────
        Container(
          decoration: BoxDecoration(
            color: ColorRes.white,
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(10),
          ),
          child: employees.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Text(S.current.noEmployeesFound,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: employees.length,
                  separatorBuilder: (_, __) =>
                      Divider(height: 1, color: Colors.grey.shade200),
                  itemBuilder: (context, index) {
                    final employee = employees[index];
                    final isSelected = cubit.isEmployeeSelected(employee);
                    return _EmployeeCheckTile(
                      employee: employee,
                      isSelected: isSelected,
                      onTap: () => cubit.toggleEmployee(employee),
                    );
                  },
                ),
        ),

        // ── Department note ───────────────────────────────────────────────
        const Sizer(height: 8),
        Text(
          '* الخاصة بالمستخدم الحالي فقط Department إذا كان نوع القسم "نفس القسم" سيتم عرض موظفي نفس.',
          textDirection: TextDirection.rtl,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Colors.grey.shade600),
        ),
      ],
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
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                employee.name,
                style: Theme.of(context).textTheme.bodyMedium,
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
