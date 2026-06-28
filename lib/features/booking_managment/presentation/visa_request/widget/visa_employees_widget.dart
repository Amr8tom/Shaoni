import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/features/auth/presentation/widgets/auth_text_filed.dart';
import 'package:shaoni/features/booking_managment/presentation/controller/visa_request/visa_request_cubit.dart';
import 'package:shaoni/features/booking_managment/presentation/visa_request/widget/visa_date_field.dart';
import 'package:shaoni/generated/l10n.dart';

class VisaEmployeesWidget extends StatelessWidget {
  const VisaEmployeesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<VisaRequestCubit>();

    return BlocBuilder<VisaRequestCubit, VisaRequestState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.employees,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Sizer(height: 12),

            /// Gate: a visa type must be chosen before listing employees
            if (state.selectedVisaTypeId == null)
              _InfoBox(message: S.current.selectVisaTypeFirst)
            else if (state.employeesLoading)
              Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.padding),
                  child: CircularProgressIndicator(color: ColorRes.primary),
                ),
              )
            else ...[
              /// Search
              AuthTextField(
                label: S.current.search,
                hint: S.current.searchByName,
                controller: controller.searchController,
                borderRadius: AppSizes.borderRadiusMd,
                prefixIcon: const Icon(Icons.search),
                onChanged: controller.setSearchQuery,
              ),
              const Sizer(height: 12),

              /// Employees checkbox list
              Container(
                constraints: const BoxConstraints(maxHeight: 320),
                decoration: BoxDecoration(
                  border: Border.all(color: ColorRes.greyForBorders),
                  borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
                  color: ColorRes.white,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding:
                      EdgeInsets.symmetric(vertical: AppSizes.padding * 0.5),
                  itemCount: state.filteredEmployees.length,
                  itemBuilder: (context, index) {
                    final employee = state.filteredEmployees[index];
                    final selected = state.isEmployeeSelected(employee.id);
                    return CheckboxListTile(
                      dense: true,
                      value: selected,
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: ColorRes.primary,
                      title: Text(
                        employee.displayName,
                        style: const TextStyle(fontSize: 12),
                      ),
                      onChanged: (_) => controller.toggleEmployee(employee),
                    );
                  },
                ),
              ),

              /// Per-employee visa dates
              if (state.lines.isNotEmpty) ...[
                const Sizer(height: 24),
                Text(
                  S.current.visaDatesPerEmployee,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Sizer(height: 12),
                ...state.lines.map(
                  (line) => _EmployeeDatesCard(
                    name: line.employee.displayName,
                    dateFrom: line.dateFrom,
                    dateTo: line.dateTo,
                    onPickFrom: (d) =>
                        controller.setLineDateFrom(line.employee.id, d),
                    onPickTo: (d) =>
                        controller.setLineDateTo(line.employee.id, d),
                  ),
                ),
              ],
            ],
          ],
        );
      },
    );
  }
}

class _EmployeeDatesCard extends StatelessWidget {
  const _EmployeeDatesCard({
    required this.name,
    required this.dateFrom,
    required this.dateTo,
    required this.onPickFrom,
    required this.onPickTo,
  });

  final String name;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final ValueChanged<DateTime> onPickFrom;
  final ValueChanged<DateTime> onPickTo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(AppSizes.padding),
      decoration: BoxDecoration(
        color: ColorRes.grey6,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
        border: Border.all(color: ColorRes.grey5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const Sizer(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: VisaDateField(
                  label: S.current.startDate,
                  date: dateFrom,
                  onPicked: onPickFrom,
                ),
              ),
              const Sizer(width: 12),
              Expanded(
                child: VisaDateField(
                  label: S.current.endDate,
                  date: dateTo,
                  firstDate: dateFrom,
                  onPicked: onPickTo,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  const _InfoBox({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.padding),
      decoration: BoxDecoration(
        color: ColorRes.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
        border: Border.all(color: ColorRes.primary.withValues(alpha: 0.2)),
      ),
      child: Text(
        message,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: ColorRes.primary),
      ),
    );
  }
}
