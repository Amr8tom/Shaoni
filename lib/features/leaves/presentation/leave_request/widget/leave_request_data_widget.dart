import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/features/leaves/presentation/controller/leave_request/leave_request_cubit.dart';
import 'package:shaoni/features/leaves/presentation/leave_interruption/widget/leave_date_field.dart';
import 'package:shaoni/generated/l10n.dart';

class LeaveRequestDataWidget extends StatelessWidget {
  const LeaveRequestDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<LeaveRequestCubit>();
    final isEn = S.current.localeee == 'en';

    return BlocBuilder<LeaveRequestCubit, LeaveRequestState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.current.requestData,
                style: Theme.of(context).textTheme.headlineMedium),
            const Sizer(height: 16),

            /// Leave type
            _Dropdown<int>(
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

            /// Alternative employee
            _Dropdown<int>(
              label: S.current.alternativeEmployee,
              hint: S.current.selectAlternativeEmployee,
              value: state.selectedAlternativeEmployeeId,
              items: state.employees
                  .map((e) => DropdownMenuItem<int>(
                        value: e.id,
                        child: Text(e.name,
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis),
                      ))
                  .toList(),
              validator: (v) => v == null ? S.current.pleaseEndterValue : null,
              onChanged: (id) {
                if (id != null) controller.selectAlternativeEmployee(id);
              },
            ),
            const Sizer(height: 24),

            /// From date
            Text(S.current.startDate,
                style: Theme.of(context).textTheme.headlineMedium),
            const Sizer(height: 12),
            LeaveDateField(
              label: S.current.date,
              date: state.startDate,
              onPicked: controller.setStartDate,
            ),
            const Sizer(height: 24),

            /// To date
            Text(S.current.endDate,
                style: Theme.of(context).textTheme.headlineMedium),
            const Sizer(height: 12),
            LeaveDateField(
              label: S.current.date,
              date: state.endDate,
              onPicked: controller.setEndDate,
            ),

            /// Pre-booked leaves (view only)
            if (state.appointments.isNotEmpty) ...[
              const Sizer(height: 24),
              Text(S.current.preBookedLeaves,
                  style: Theme.of(context).textTheme.headlineMedium),
              const Sizer(height: 12),
              ...state.appointments.map((a) => Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(AppSizes.padding * 0.75),
                    decoration: BoxDecoration(
                      color: ColorRes.grey6,
                      borderRadius:
                          BorderRadius.circular(AppSizes.borderRadiusMd),
                      border: Border.all(color: ColorRes.grey5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(a.holidayStatusName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600)),
                        const Sizer(height: 6),
                        Text(
                          '${a.requestDateFrom}  →  ${a.requestDateTo}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        if (a.stageName.isNotEmpty) ...[
                          const Sizer(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: ColorRes.primary.withValues(alpha: 0.10),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(a.stageName,
                                style: TextStyle(
                                    color: ColorRes.primary, fontSize: 11)),
                          ),
                        ],
                      ],
                    ),
                  )),
            ],

            /// Existing attachments (edit mode) — open or remove
            if (state.existingAttachments.isNotEmpty) ...[
              const Sizer(height: 24),
              Text(S.current.attachments,
                  style: Theme.of(context).textTheme.headlineMedium),
              const Sizer(height: 12),
              ...state.existingAttachments.map((a) => Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: EdgeInsets.all(AppSizes.padding * 0.75),
                    decoration: BoxDecoration(
                      color: ColorRes.grey6,
                      borderRadius:
                          BorderRadius.circular(AppSizes.borderRadiusMd),
                      border: Border.all(color: ColorRes.grey5),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(a.name,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                        if (a.url.isNotEmpty)
                          TextButton(
                            onPressed: () {
                              final uri = Uri.tryParse(a.url);
                              if (uri != null) {
                                launchUrl(uri,
                                    mode: LaunchMode.externalApplication);
                              }
                            },
                            child: Text(S.current.openAttachment,
                                style: TextStyle(
                                    color: ColorRes.primary, fontSize: 12)),
                          ),
                        TextButton(
                          onPressed: () =>
                              controller.removeExistingAttachment(a.id),
                          child: Text(S.current.delete,
                              style: TextStyle(
                                  color: ColorRes.error, fontSize: 12)),
                        ),
                      ],
                    ),
                  )),
            ],
          ],
        );
      },
    );
  }
}

class _Dropdown<T> extends StatelessWidget {
  const _Dropdown({
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
        Text(label,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600)),
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
