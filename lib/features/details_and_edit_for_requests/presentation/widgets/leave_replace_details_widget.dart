import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/order_text_card.dart';
import '../controller/my_requests_cubit.dart';

class LeaveReplaceDetailsWidget extends StatelessWidget {
  const LeaveReplaceDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyRequestsCubit>();
    final leave = controller.state.requestDetails?.extraData?.leaveReplace;

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
                S.current.leaveReplaceRequest,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Divider(color: ColorRes.grey4),
              const Sizer(height: 12),
              if ((leave?.externalName.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.requestNumber,
                  result: leave!.externalName,
                ),
                const Sizer(height: 12),
              ],
              if ((leave?.state.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.requestStatus,
                  result: leave!.state,
                ),
                const Sizer(height: 12),
              ],
              if ((leave?.requestDate.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.requestDate,
                  result: _date(leave!.requestDate),
                ),
                const Sizer(height: 12),
              ],
              if ((leave?.leaveTypeName.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.leaveType,
                  result: leave!.leaveTypeName,
                ),
                const Sizer(height: 12),
              ],
              if ((leave?.leaveStartDate.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.startDate,
                  result: _date(leave!.leaveStartDate),
                ),
                const Sizer(height: 12),
              ],
              if ((leave?.leaveEndDate.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.endDate,
                  result: _date(leave!.leaveEndDate),
                ),
                const Sizer(height: 12),
              ],
              if ((leave?.editReasons?.isNotEmpty ?? false)) ...[
                _FullWidthTextBlock(
                  label: S.current.editReasons,
                  value: leave!.editReasons!,
                ),
                const Sizer(height: 12),
              ],
              if ((leave?.rejectReasons?.isNotEmpty ?? false)) ...[
                _FullWidthTextBlock(
                  label: S.current.rejectReasons,
                  value: leave!.rejectReasons!,
                ),
                const Sizer(height: 12),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _date(String value) =>
      value.contains('T') ? value.split('T').first : value;
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
