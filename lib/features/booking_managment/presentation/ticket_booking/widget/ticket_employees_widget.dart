import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/features/booking_managment/domain/entity/visa_request/visa_employee.dart';
import 'package:shaoni/features/booking_managment/presentation/controller/ticket_booking/ticket_booking_cubit.dart';
import 'package:shaoni/features/booking_managment/presentation/ticket_booking/widget/ticket_data_widget.dart';
import 'package:shaoni/features/booking_managment/presentation/visa_request/widget/visa_date_field.dart';
import 'package:shaoni/features/human_resources/presentation/widgets/general_request_templates/file_upload_widget.dart';
import 'package:shaoni/generated/l10n.dart';

class TicketEmployeesWidget extends StatelessWidget {
  const TicketEmployeesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TicketBookingCubit>();

    return BlocBuilder<TicketBookingCubit, TicketBookingState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    S.current.employeesData,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                TextButton.icon(
                  onPressed: controller.addLine,
                  icon: Icon(Icons.add, color: ColorRes.primary),
                  label: Text(
                    S.current.addEmployee,
                    style: TextStyle(
                        color: ColorRes.primary, fontSize: AppSizes.fontSizeSm),
                  ),
                ),
                Sizer(
                  width: 10,
                )
              ],
            ),
            const Sizer(height: 12),
            if (state.lines.isEmpty)
              _InfoBox(message: S.current.noEmployeesAdded)
            else
              ...state.lines.asMap().entries.map(
                    (entry) => _TicketLineCard(
                      index: entry.key + 1,
                      line: entry.value,
                      classes: state.ticketClasses,
                      employees: state.employees,
                      controller: controller,
                    ),
                  ),
          ],
        );
      },
    );
  }
}

class _TicketLineCard extends StatelessWidget {
  const _TicketLineCard({
    required this.index,
    required this.line,
    required this.classes,
    required this.employees,
    required this.controller,
  });

  final int index;
  final TicketLineState line;
  final List classes;
  final List<VisaEmployee> employees;
  final TicketBookingCubit controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(AppSizes.padding),
      decoration: BoxDecoration(
        color: ColorRes.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
        border: Border.all(color: ColorRes.greyForBorders),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${S.current.employee} $index',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              IconButton(
                onPressed: () => controller.removeLine(line.localId),
                icon: Icon(Icons.delete_outline, color: ColorRes.error),
              ),
            ],
          ),
          const Sizer(height: 8),

          /// Employee
          TicketLabeledDropdown<int>(
            label: S.current.employee,
            hint: S.current.selectEmployee,
            value: line.employeeId,
            items: employees
                .map((e) => DropdownMenuItem<int>(
                      value: e.id,
                      child: Text(
                        e.displayName,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            validator: (value) =>
                value == null ? S.current.pleaseEndterValue : null,
            onChanged: (id) {
              if (id == null) return;
              final employee = employees.firstWhere((e) => e.id == id);
              controller.setLineEmployee(line.localId, employee);
            },
          ),
          const Sizer(height: 12),

          /// Travel date
          VisaDateField(
            label: S.current.travelDate,
            date: line.travelDate,
            onPicked: (d) => controller.setLineTravelDate(line.localId, d),
          ),
          const Sizer(height: 12),

          /// Ticket class
          TicketLabeledDropdown<int>(
            label: S.current.ticketClass,
            hint: S.current.selectTicketClass,
            value: line.ticketClassId,
            items: classes
                .map<DropdownMenuItem<int>>((c) => DropdownMenuItem<int>(
                      value: c.id as int,
                      child: Text(
                        c.name as String,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            validator: (value) =>
                value == null ? S.current.pleaseEndterValue : null,
            onChanged: (id) {
              if (id != null) controller.setLineTicketClass(line.localId, id);
            },
          ),
          const Sizer(height: 12),

          /// Optional per-line attachment
          FileUploadWidget(
            title: S.current.attachmentOptional,
            onPickedFile: (name, base64) =>
                controller.setLineAttachment(line.localId, name, base64),
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
