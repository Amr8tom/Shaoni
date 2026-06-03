import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/features/human_resources/domain/entity/outside_working/outside_working_employee.dart';
import 'package:shaoni/features/human_resources/presentation/controller/outside_working/outside_working_cubit.dart';
import 'package:shaoni/generated/l10n.dart';

/// Per-employee task cards — one card per selected employee
class OutsideWorkingTasksWidget extends StatelessWidget {
  const OutsideWorkingTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<OutsideWorkingCubit>();
    final employees = cubit.selectedEmployees;

    if (employees.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: employees.map((employee) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _EmployeeTaskCard(employee: employee),
        );
      }).toList(),
    );
  }
}

class _EmployeeTaskCard extends StatelessWidget {
  final OutsideWorkingEmployee employee;

  const _EmployeeTaskCard({required this.employee});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<OutsideWorkingCubit>();
    final data = cubit.employeeTaskData[employee.id];
    if (data == null) return const SizedBox.shrink();

    final yesNoItems = [
      DropdownMenuItem<String>(
        value: 'true',
        child: Text(S.current.yes, style: const TextStyle(fontSize: 13)),
      ),
      DropdownMenuItem<String>(
        value: 'false',
        child: Text(S.current.no, style: const TextStyle(fontSize: 13)),
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: ColorRes.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ───────────────────────────────────────────────────────
          Text(
            'Employee ID: ${employee.id}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
          ),
          const Sizer(height: 14),

          // ── Row: يشمل عطلات + Exception Request + Tasks ──────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // يشمل عطلات؟
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('يشمل عطلات؟',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            )),
                    const SizedBox(height: 6),
                    _StyledDropdown(
                      value: data.includeWeekend ? 'true' : 'false',
                      items: yesNoItems,
                      onChanged: (val) =>
                          cubit.setIncludeWeekend(employee.id, val == 'true'),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),

              // Exception Request
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Exception Request',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            )),
                    const SizedBox(height: 6),
                    _StyledDropdown(
                      value: data.exceptionRequest ? 'true' : 'false',
                      items: yesNoItems,
                      onChanged: (val) =>
                          cubit.setExceptionRequest(employee.id, val == 'true'),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),

              // Tasks
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Tasks',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    )),
                        const SizedBox(width: 4),
                        Text('*',
                            style: TextStyle(
                                color: ColorRes.error,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: data.tasksController,
                      decoration: InputDecoration(
                        hintText: 'المهام الموكلة لهذا الموظف...',
                        hintStyle: TextStyle(
                            fontSize: 12, color: Colors.grey.shade400),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      validator: (v) => (v == null || v.isEmpty)
                          ? S.current.thisFieldRequired
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Sizer(height: 14),

          // ── Private Tasks ─────────────────────────────────────────────────
          Row(
            children: [
              Text('Private Tasks',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      )),
              const SizedBox(width: 4),
              Text('*',
                  style: TextStyle(
                      color: ColorRes.error, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: data.privateTasksController,
            decoration: InputDecoration(
              hintText: 'مهمة خاصة ...',
              hintStyle:
                  TextStyle(fontSize: 12, color: Colors.grey.shade400),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            validator: (v) =>
                (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
          ),
        ],
      ),
    );
  }
}

/// Simple styled dropdown matching the screenshot.
class _StyledDropdown extends StatelessWidget {
  final String value;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;

  const _StyledDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: items,
          onChanged: onChanged,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
