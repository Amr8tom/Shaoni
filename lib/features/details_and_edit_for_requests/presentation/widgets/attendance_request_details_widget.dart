import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/order_text_card.dart';
import '../controller/my_requests_cubit.dart';


class AttendanceRequestDetailsWidget extends StatelessWidget {
  const AttendanceRequestDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyRequestsCubit>();
    final attendance = controller.state.requestDetails?.extraData?.attendance;

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
              /// Section header
              Text(
                S.current.orderDetails,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Divider(color: ColorRes.grey4),
              const Sizer(height: 12),

              /// Row 1 — attendance type
                  OrderTextCard(
                    title: S.current.attendanceType,
                    result: attendance?.attendanceType ?? '',
                  ),

              const Sizer(height: 12),

              /// Row 2 — forget reason
              if ((attendance?.forgetReason?.isNotEmpty ?? false)) ...[
                Row(
                  children: [
                    OrderTextCard(
                      title: S.current.forgetReason,
                      result: attendance?.forgetReason ?? '',
                    ),
                  ],
                ),
                const Sizer(height: 12),
              ],

              /// Full-width — order reason
              if ((attendance?.orderReason?.isNotEmpty ?? false)) ...[
                _FullWidthTextBlock(
                  label: S.current.orderReason,
                  value: attendance!.orderReason!,
                ),
                const Sizer(height: 12),
              ],

              /// Full-width — notes
              if ((attendance?.notes?.isNotEmpty ?? false))
                _FullWidthTextBlock(
                  label: S.current.notes,
                  value: attendance!.notes!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Reusable full-width label + text block (same style as ComplaintDescription).
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
