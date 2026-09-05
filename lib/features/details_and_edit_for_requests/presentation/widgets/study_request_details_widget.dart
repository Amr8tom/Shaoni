import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/order_text_card.dart';
import '../controller/my_requests_cubit.dart';
import 'attachments_view.dart';

class StudyRequestDetailsWidget extends StatelessWidget {
  const StudyRequestDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyRequestsCubit>();
    final study = controller.state.requestDetails?.extraData?.study;

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

              /// Row 1 — study type + destination

              OrderTextCard(
                title: S.current.studyDestination,
                result: study?.studyDestinationsText ?? '',
              ),

              const Sizer(height: 12),

              /// Row 2 — required study (full-width, can be long text)
              if ((study?.study?.isNotEmpty ?? false)) ...[
                _FullWidthTextBlock(
                  label: S.current.requiredStudy,
                  value: study!.study!,
                ),
                const Sizer(height: 12),
              ],

              /// Row 3 — start date + end date
              Row(
                children: [
                  OrderTextCard(
                    title: S.current.startDate,
                    result: _formatDate(study?.studyStartDate),
                  ),
                  const Sizer(width: 10),
                  OrderTextCard(
                    title: S.current.endDate,
                    result: _formatDate(study?.studyEndDate),
                  ),
                ],
              ),
              const Sizer(height: 12),

              /// Full-width — reason / justification
              if ((study?.reason?.isNotEmpty ?? false)) ...[
                _FullWidthTextBlock(
                  label: S.current.orderReason,
                  value: study!.reason!,
                ),
                const Sizer(height: 12),
              ],

              /// Full-width — additional notes
              if ((study?.note?.isNotEmpty ?? false)) ...[
                _FullWidthTextBlock(
                  label: S.current.notes,
                  value: study!.note!,
                ),
                const Sizer(height: 12),
              ],

              /// Attachments — URL + base64, renders nothing when empty
              AttachmentsView(attachments: study?.attachments ?? const []),
            ],
          ),
        ),
      ),
    );
  }

  /// Trims the ISO datetime to `yyyy-MM-dd` for display.
  String _formatDate(String? iso) {
    if (iso == null || iso.isEmpty) return '';
    return iso.length >= 10 ? iso.substring(0, 10) : iso;
  }
}

/// Reusable full-width label + grey text block.
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
