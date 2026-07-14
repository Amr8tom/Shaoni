import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/features/human_resources/domain/entity/outside_working/outside_working_employee.dart';
import 'package:shaoni/features/human_resources/presentation/controller/outside_working/outside_working_cubit.dart';
import 'package:shaoni/generated/l10n.dart';

/// Per-employee task cards — one card per selected employee.
class OutsideWorkingTasksWidget extends StatelessWidget {
  const OutsideWorkingTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OutsideWorkingCubit, OutsideWorkingState>(
      builder: (context, state) {
        if (state.selectedEmployees.isEmpty) {
          return _EmptyHint();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: state.selectedEmployees.map((employee) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _EmployeeTaskCard(employee: employee),
            );
          }).toList(),
        );
      },
    );
  }
}

class _EmptyHint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorRes.warning.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorRes.warning.withValues(alpha: 0.3)),
      ),
      child: Text(
        S.current.selectEmployeesToShowTasks,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: ColorRes.warning),
      ),
    );
  }
}

class _EmployeeTaskCard extends StatelessWidget {
  final OutsideWorkingEmployee employee;

  const _EmployeeTaskCard({required this.employee});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OutsideWorkingCubit>();
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
        border: Border.all(color: ColorRes.greyShade300),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            employee.jobTitle.isEmpty
                ? employee.name
                : '${employee.name} - ${employee.jobTitle}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorRes.greyShade600,
                ),
          ),
          const Sizer(height: 14),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── يشمل عطلات؟ ───────────────────────────────────────────────
              Expanded(
                child: _Labeled(
                  label: S.current.includeWeekend,
                  child: _StyledDropdown(
                    value: data.includeWeekend ? 'true' : 'false',
                    items: yesNoItems,
                    onChanged: (v) => cubit.setEmployeeIncludeWeekend(
                        employee.id, v == 'true'),
                  ),
                ),
              ),
              const Sizer(width: 10),

              // ── طلب استثناء ───────────────────────────────────────────────
              Expanded(
                child: _Labeled(
                  label: S.current.exceptionRequest,
                  child: _StyledDropdown(
                    value: data.exceptionRequest ? 'true' : 'false',
                    items: yesNoItems,
                    onChanged: (v) =>
                        cubit.setExceptionRequest(employee.id, v == 'true'),
                  ),
                ),
              ),
              const Sizer(width: 10),

              // ── المهام ────────────────────────────────────────────────────
              Expanded(
                flex: 2,
                child: _Labeled(
                  label: S.current.tasks,
                  required: true,
                  child: _TaskField(
                    controller: data.tasksController,
                    hint: S.current.tasksHint,
                  ),
                ),
              ),
            ],
          ),
          const Sizer(height: 14),

          // ── المهام الخاصة ───────────────────────────────────────────────
          _Labeled(
            label: S.current.privateTasks,
            required: true,
            child: _TaskField(
              controller: data.privateTasksController,
              hint: S.current.privateTasksHint,
            ),
          ),
        ],
      ),
    );
  }
}

class _Labeled extends StatelessWidget {
  final String label;
  final bool required;
  final Widget child;

  const _Labeled({
    required this.label,
    required this.child,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            if (required) ...[
              const Sizer(width: 4),
              Text('*',
                  style: TextStyle(
                      color: ColorRes.error, fontWeight: FontWeight.bold)),
            ],
          ],
        ),
        const Sizer(height: 6),
        child,
      ],
    );
  }
}

class _TaskField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const _TaskField({required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 12, color: ColorRes.greyShade400),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ColorRes.greyShade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ColorRes.greyShade300),
        ),
      ),
      validator: (v) =>
          (v == null || v.isEmpty) ? S.current.thisFieldRequired : null,
    );
  }
}

/// Simple styled dropdown matching the request design.
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
        border: Border.all(color: ColorRes.greyShade300),
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
