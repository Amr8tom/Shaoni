import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/features/auth/presentation/widgets/auth_text_filed.dart';
import 'package:shaoni/features/booking_managment/presentation/controller/ticket_booking/ticket_booking_cubit.dart';
import 'package:shaoni/features/booking_managment/presentation/visa_request/widget/visa_date_field.dart';
import 'package:shaoni/generated/l10n.dart';

class TicketDataWidget extends StatelessWidget {
  const TicketDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TicketBookingCubit>();

    return BlocBuilder<TicketBookingCubit, TicketBookingState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.requestData,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Sizer(height: 16),

            /// Travel date
            VisaDateField(
              label: S.current.travelDate,
              date: state.travelDate,
              onPicked: controller.setTravelDate,
            ),
            const Sizer(height: 16),

            /// Ticket type (in / out)
            TicketLabeledDropdown<String>(
              label: S.current.ticketType,
              hint: S.current.selectTicketType,
              value: state.selectedTicketType.isEmpty
                  ? null
                  : state.selectedTicketType,
              items: [
                DropdownMenuItem(value: 'in', child: Text(S.current.ticketIn)),
                DropdownMenuItem(
                    value: 'out', child: Text(S.current.ticketOut)),
              ],
              validator: (value) =>
                  (value == null) ? S.current.pleaseEndterValue : null,
              onChanged: (value) {
                if (value != null) controller.selectTicketType(value);
              },
            ),
            const Sizer(height: 16),

            /// Task type
            AuthTextField(
              label: S.current.taskType,
              hint: S.current.taskType,
              controller: controller.taskTypeController,
              borderRadius: AppSizes.borderRadiusMd,
              validator: (value) =>
                  (value?.isEmpty ?? true) ? S.current.pleaseEndterValue : null,
            ),
            const Sizer(height: 16),

            /// Direction / itinerary
            AuthTextField(
              label: S.current.itinerary,
              hint: S.current.itinerary,
              controller: controller.directionController,
              borderRadius: AppSizes.borderRadiusMd,
              validator: (value) =>
                  (value?.isEmpty ?? true) ? S.current.pleaseEndterValue : null,
            ),
            const Sizer(height: 16),

            /// Note (optional)
            AuthTextField(
              label: S.current.notes,
              hint: S.current.notes,
              controller: controller.noteController,
              borderRadius: AppSizes.borderRadiusMd,
            ),
          ],
        );
      },
    );
  }
}

// ── Labeled dropdown ──────────────────────────────────────────────────────────

class TicketLabeledDropdown<T> extends StatelessWidget {
  const TicketLabeledDropdown({
    super.key,
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
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
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
