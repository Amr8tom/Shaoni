import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/order_text_card.dart';
import '../controller/my_requests_cubit.dart';

class TrainingRequestDetailsWidget extends StatelessWidget {
  const TrainingRequestDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyRequestsCubit>();
    final tr = controller.state.requestDetails?.extraData?.trainingRequest;

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

              /// Course name
              if ((tr?.courseName?.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.course,
                  result: tr?.courseName ?? '',
                ),
                const Sizer(height: 12),
              ],

              /// Start date
              if ((tr?.startDate?.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.startDate,
                  result: _formatDate(tr?.startDate),
                ),
                const Sizer(height: 12),
              ],

              /// End date
              if ((tr?.endDate?.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.endDate,
                  result: _formatDate(tr?.endDate),
                ),
                const Sizer(height: 12),
              ],

              /// Nomination start date
              if ((tr?.nominationStartDate?.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.nominationStartDate,
                  result: _formatDate(tr?.nominationStartDate),
                ),
                const Sizer(height: 12),
              ],

              /// Nomination end date
              if ((tr?.nominationEndDate?.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.nominationEndDate,
                  result: _formatDate(tr?.nominationEndDate),
                ),
                const Sizer(height: 12),
              ],

              /// Course period months
              if (tr?.coursePeriodMonths != null) ...[
                OrderTextCard(
                  title: S.current.coursePeriodMonths,
                  result: tr!.coursePeriodMonths.toString(),
                ),
                const Sizer(height: 12),
              ],

              /// Nomination period days
              if (tr?.nominationPeriodDays != null) ...[
                OrderTextCard(
                  title: S.current.nominationPeriodDays,
                  result: tr!.nominationPeriodDays.toString(),
                ),
                const Sizer(height: 12),
              ],

              /// Note (full-width)
              if ((tr?.note?.isNotEmpty ?? false)) ...[
                _FullWidthTextBlock(
                  label: S.current.notes,
                  value: tr!.note!,
                ),
                const Sizer(height: 12),
              ],

              /// Edit reasons (full-width, conditional)
              if ((tr?.editReasons?.isNotEmpty ?? false)) ...[
                _FullWidthTextBlock(
                  label: S.current.editReasons,
                  value: tr!.editReasons!,
                ),
                const Sizer(height: 12),
              ],

              /// Reject reasons (full-width, conditional)
              if ((tr?.rejectReasons?.isNotEmpty ?? false)) ...[
                _FullWidthTextBlock(
                  label: S.current.rejectReasons,
                  value: tr!.rejectReasons!,
                ),
                const Sizer(height: 12),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String? iso) {
    if (iso == null || iso.isEmpty) return '';
    return iso.length >= 10 ? iso.substring(0, 10) : iso;
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
