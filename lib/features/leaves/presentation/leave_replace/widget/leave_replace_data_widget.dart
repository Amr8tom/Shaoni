import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/features/leaves/presentation/controller/leave_replace/leave_replace_cubit.dart';
import 'package:shaoni/features/leaves/presentation/leave_interruption/widget/leave_date_field.dart';
import 'package:shaoni/generated/l10n.dart';

class LeaveReplaceDataWidget extends StatelessWidget {
  const LeaveReplaceDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<LeaveReplaceCubit>();
    final isEn = S.current.localeee == 'en';

    return BlocBuilder<LeaveReplaceCubit, LeaveReplaceState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.requestData,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Sizer(height: 16),

            /// Leave type
            _LeaveDropdown<int>(
              label: S.current.leaveType,
              hint: S.current.selectLeaveType,
              value: state.selectedLeaveTypeId,
              items: state.leaveTypes
                  .map((t) => DropdownMenuItem<int>(
                        value: t.id,
                        child: Text(isEn ? t.nameEn : t.nameAr,
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis),
                      ))
                  .toList(),
              validator: (v) => v == null ? S.current.pleaseEndterValue : null,
              onChanged: (id) {
                if (id != null) controller.selectLeaveType(id);
              },
            ),
            const Sizer(height: 16),

            /// Leave (cascading on leave type)
            if (state.leavesLoading)
              Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.padding),
                  child: CircularProgressIndicator(color: ColorRes.primary),
                ),
              )
            else
              _LeaveDropdown<int>(
                label: S.current.leaveField,
                hint: state.selectedLeaveTypeId == null
                    ? S.current.selectLeaveTypeFirst
                    : S.current.selectLeave,
                value: state.selectedLeaveId,
                items: state.employeeLeaves
                    .map((l) => DropdownMenuItem<int>(
                          value: l.id,
                          child: Text(l.name,
                              style: const TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis),
                        ))
                    .toList(),
                validator: (v) =>
                    v == null ? S.current.pleaseEndterValue : null,
                onChanged: (id) {
                  if (id != null) controller.selectLeave(id);
                },
              ),
            const Sizer(height: 24),

            /// Start date
            Text(
              S.current.startDate,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Sizer(height: 12),
            LeaveDateField(
              label: S.current.date,
              date: state.startDate,
              onPicked: controller.setStartDate,
            ),
            const Sizer(height: 24),

            /// End date
            Text(
              S.current.endDate,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Sizer(height: 12),
            LeaveDateField(
              label: S.current.date,
              date: state.endDate,
              onPicked: controller.setEndDate,
            ),
          ],
        );
      },
    );
  }
}

// ── Labeled dropdown ──────────────────────────────────────────────────────────

class _LeaveDropdown<T> extends StatelessWidget {
  const _LeaveDropdown({
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  final String label;
  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        const Sizer(height: 6),
        DropdownButtonFormField<T>(
          hint: Text(hint, style: const TextStyle(fontSize: 12)),
          value: value,
          isExpanded: true,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSizes.padding * 0.75,
              vertical: AppSizes.padding * 0.5,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              borderSide: BorderSide(color: ColorRes.greyForBorders),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              borderSide: BorderSide(color: ColorRes.greyForBorders),
            ),
            filled: true,
            fillColor: ColorRes.white,
          ),
          items: items,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
