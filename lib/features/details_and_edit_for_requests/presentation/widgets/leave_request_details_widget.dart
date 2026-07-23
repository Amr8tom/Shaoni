import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/order_text_card.dart';
import '../../domain/entities/leave_request.dart';
import '../controller/my_requests_cubit.dart';

class LeaveRequestDetailsWidget extends StatelessWidget {
  const LeaveRequestDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyRequestsCubit>();
    final leave = controller.state.requestDetails?.extraData?.leaveRequest;
    final isEn = S.current.localeee == 'en';

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
                S.current.leaveRequestTitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Divider(color: ColorRes.grey4),
              const Sizer(height: 12),
              if (leave == null)
                Center(
                  child: Text(
                    S.current.noData,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              else ...[
                _row(S.current.requestNumber, leave.name),
                // _row(S.current.mode, _modeLabel(leave.holidayType)),
                _row(S.current.employeeName, leave.employeeName),
                _row(S.current.leaveType, leave.holidayStatusName),
                _row(S.current.alternativeEmployee,
                    leave.alternativeEmployeeName),
                _row(
                  S.current.validationType,
                  isEn ? leave.validationTypeEn : leave.validationTypeAr,
                ),
                _row(S.current.startDate, _date(leave.requestDateFrom)),
                _row(S.current.endDate, _date(leave.requestDateTo)),
                _row(S.current.duration, _duration(context, leave)),
                _row(
                  S.current.halfDay,
                  leave.requestUnitHalf ? S.current.yes : S.current.no,
                ),
                _row(
                  S.current.byHours,
                  leave.requestUnitHours ? S.current.yes : S.current.no,
                ),
                _row(
                  S.current.requestStatus,
                  isEn ? leave.stateEn : leave.stateAr,
                ),
                _row(S.current.editReasons, leave.editReasons ?? ''),
                _row(S.current.rejectReasons, leave.rejectReasons ?? ''),
                if (leave.attachments.isNotEmpty) ...[
                  const Sizer(height: 4),
                  Text(
                    S.current.attachments,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Sizer(height: 8),
                  ...leave.attachments.map(_AttachmentTile.new),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String title, String value) {
    if (value.trim().isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: OrderTextCard(title: title, result: value),
    );
  }

  /// Inclusive day count between the two dates, e.g. 01→07 = 7 days.
  String _duration(BuildContext context, LeaveRequestEntity leave) {
    final from = DateTime.tryParse(leave.requestDateFrom);
    final to = DateTime.tryParse(leave.requestDateTo);
    if (from == null || to == null) return '';
    final days = to.difference(from).inDays + 1;
    return '$days ${S.current.days}';
  }

  String _date(String value) =>
      value.contains('T') ? value.split('T').first : value;
}

class _AttachmentTile extends StatelessWidget {
  const _AttachmentTile(this.attachment);

  final LeaveRequestAttachment attachment;

  Future<void> _open() async {
    if (attachment.url.isEmpty) return;
    final uri = Uri.tryParse(attachment.url);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(AppSizes.padding * 0.75),
      decoration: BoxDecoration(
        color: ColorRes.grey6,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
        border: Border.all(color: ColorRes.grey5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              attachment.name,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Sizer(width: 8),
          if (attachment.url.isNotEmpty)
            TextButton.icon(
              onPressed: _open,
              icon: Icon(Icons.attach_file, size: 16, color: ColorRes.primary),
              label: Text(
                S.current.openAttachment,
                style: TextStyle(color: ColorRes.primary, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
