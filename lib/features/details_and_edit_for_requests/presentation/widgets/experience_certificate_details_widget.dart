import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/order_text_card.dart';
import '../controller/my_requests_cubit.dart';

class ExperienceCertificateDetailsWidget extends StatelessWidget {
  const ExperienceCertificateDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyRequestsCubit>();
    final cert =
        controller.state.requestDetails?.extraData?.experienceCertificate;

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

              /// Certificate reason
              OrderTextCard(
                title: S.current.certificateReason,
                result: cert?.certificateReasonName ?? '',
              ),
              const Sizer(height: 12),

              /// Date
              if ((cert?.date.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.startDate,
                  result: _formatDate(cert?.date),
                ),
                const Sizer(height: 12),
              ],

              /// Reason / justification (full-width)
              if ((cert?.reason?.isNotEmpty ?? false)) ...[
                _FullWidthTextBlock(
                  label: S.current.orderReason,
                  value: cert!.reason!,
                ),
                const Sizer(height: 12),
              ],

              /// Note (full-width)
              if ((cert?.note?.isNotEmpty ?? false)) ...[
                _FullWidthTextBlock(
                  label: S.current.notes,
                  value: cert!.note!,
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
