import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/helpers/base64_file_helper.dart';
import '../../../../core/utils/helpers/image_from_base64.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/order_text_card.dart';
import '../../domain/entities/ticket_booking.dart';
import '../controller/my_requests_cubit.dart';

class TicketBookingDetailsWidget extends StatelessWidget {
  const TicketBookingDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyRequestsCubit>();
    final ticket = controller.state.requestDetails?.extraData?.ticketBooking;

    return Skeletonizer(
      enabled: controller.state.status.isLoading,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
        child: Container(
          padding: EdgeInsets.all(AppSizes.padding),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: ColorRes.greyForBorders),
            color: ColorRes.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.current.ticketBooking,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Divider(color: ColorRes.grey4),
              const Sizer(height: 12),
              if ((controller.state.requestDetails?.request?.requestNumber
                      ?.isNotEmpty ??
                  false)) ...[
                OrderTextCard(
                  title: S.current.orderNumber,
                  result:
                      controller.state.requestDetails!.request!.requestNumber!,
                ),
                const Sizer(height: 12),
              ],
              if ((ticket?.ticketType.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.ticketType,
                  result: _ticketTypeName(ticket!.ticketType),
                ),
                const Sizer(height: 12),
              ],
              if ((ticket?.taskType.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.taskType,
                  result: ticket!.taskType,
                ),
                const Sizer(height: 12),
              ],
              if ((ticket?.direction.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.itinerary,
                  result: ticket!.direction,
                ),
                const Sizer(height: 12),
              ],
              if ((ticket?.travelDate.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.travelDate,
                  result: _date(ticket!.travelDate),
                ),
                const Sizer(height: 12),
              ],
              if ((ticket?.note.isNotEmpty ?? false)) ...[
                _FullWidthTextBlock(
                  label: S.current.notes,
                  value: ticket!.note,
                ),
                const Sizer(height: 12),
              ],
              if ((ticket?.lines.isNotEmpty ?? false)) ...[
                Text(
                  S.current.employeesData,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Sizer(height: 8),
                ...(ticket?.lines ?? [])
                    .map((line) => _TicketLineCard(line: line)),
                const Sizer(height: 8),
              ],
              if ((ticket?.editReasons?.isNotEmpty ?? false)) ...[
                _FullWidthTextBlock(
                  label: S.current.editReasons,
                  value: ticket!.editReasons!,
                ),
                const Sizer(height: 12),
              ],
              if ((ticket?.rejectReasons?.isNotEmpty ?? false)) ...[
                _FullWidthTextBlock(
                  label: S.current.rejectReasons,
                  value: ticket!.rejectReasons!,
                ),
                const Sizer(height: 12),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _ticketTypeName(String code) {
    switch (code) {
      case 'in':
        return S.current.ticketIn;
      case 'out':
        return S.current.ticketOut;
      default:
        return code;
    }
  }

  String _date(String value) =>
      value.contains('T') ? value.split('T').first : value;
}

class _TicketLineCard extends StatelessWidget {
  const _TicketLineCard({required this.line});

  final TicketBookingLineEntity line;

  @override
  Widget build(BuildContext context) {
    String date(String value) =>
        value.contains('T') ? value.split('T').first : value;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(AppSizes.padding * 0.75),
      decoration: BoxDecoration(
        color: ColorRes.grey6,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
        border: Border.all(color: ColorRes.grey5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderTextCard(
            title: S.current.employee,
            result: line.employeeName.isNotEmpty
                ? line.employeeName
                : line.employeeId.toString(),
          ),
          const Sizer(height: 6),
          OrderTextCard(
            title: S.current.travelDate,
            result: date(line.travelDate),
          ),
          if (line.ticketTypeName.isNotEmpty) ...[
            const Sizer(height: 6),
            OrderTextCard(
              title: S.current.ticketType,
              result: line.ticketTypeName,
            ),
          ],
          if (line.attachment.isNotEmpty) ...[
            const Sizer(height: 6),
            Text(
              S.current.attachments,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: ColorRes.grey2,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const Sizer(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              child: imageFromBaseString(
                base64String: line.attachment,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const Sizer(height: 8),
            OutlinedButton.icon(
              onPressed: () => Base64FileHelper.downloadAndShare(
                base64String: line.attachment,
                customFileName: 'ticket_attachment_${line.employeeId}',
              ),
              icon: const Icon(Icons.download_rounded, size: 18),
              label: Text(S.current.downloadAttachment),
              style: OutlinedButton.styleFrom(
                foregroundColor: ColorRes.primary,
                side: const BorderSide(color: ColorRes.primary),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _FullWidthTextBlock extends StatelessWidget {
  const _FullWidthTextBlock({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: ColorRes.grey2,
                fontWeight: FontWeight.w600,
              ),
        ),
        const Sizer(height: 6),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppSizes.padding * 0.75),
          decoration: BoxDecoration(
            color: ColorRes.grey6,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
            border: Border.all(color: ColorRes.grey5),
          ),
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
