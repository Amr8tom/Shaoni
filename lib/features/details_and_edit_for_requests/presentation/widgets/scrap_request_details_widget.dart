import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/order_text_card.dart';
import '../../domain/entities/scrap_request.dart';
import '../controller/my_requests_cubit.dart';

class ScrapRequestDetailsWidget extends StatelessWidget {
  const ScrapRequestDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyRequestsCubit>();
    final scrap = controller.state.requestDetails?.extraData?.scrapRequest;

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
                S.current.scrapRequest,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Divider(color: ColorRes.grey4),
              const Sizer(height: 12),
              if ((scrap?.custodyName.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.custody,
                  result: scrap!.custodyName,
                ),
                const Sizer(height: 12),
              ],
              if ((scrap?.stockRequestName.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.stockRequest,
                  result: scrap!.stockRequestName,
                ),
                const Sizer(height: 12),
              ],
              if ((scrap?.reasonName.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.scrapReason,
                  result: scrap!.reasonName,
                ),
                const Sizer(height: 12),
              ],
              if ((scrap?.lines.isNotEmpty ?? false)) ...[
                Text(
                  S.current.requestLines,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Sizer(height: 8),
                ...(scrap?.lines ?? [])
                    .map((line) => _ScrapLineCard(line: line)),
                const Sizer(height: 8),
              ],
              if ((scrap?.editReasons?.isNotEmpty ?? false)) ...[
                _FullWidthTextBlock(
                  label: S.current.editReasons,
                  value: scrap!.editReasons!,
                ),
                const Sizer(height: 12),
              ],
              if ((scrap?.rejectReasons?.isNotEmpty ?? false)) ...[
                _FullWidthTextBlock(
                  label: S.current.rejectReasons,
                  value: scrap!.rejectReasons!,
                ),
                const Sizer(height: 12),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ScrapLineCard extends StatelessWidget {
  const _ScrapLineCard({required this.line});

  final ScrapRequestLineItemEntity line;

  @override
  Widget build(BuildContext context) {
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
            title: S.current.product,
            result: line.productName,
          ),
          const Sizer(height: 6),
          OrderTextCard(
            title: S.current.quantity,
            result: line.quantity.toString(),
          ),
          if (line.lotName.isNotEmpty) ...[
            const Sizer(height: 6),
            OrderTextCard(
              title: S.current.lotNumber,
              result: line.lotName,
            ),
          ],
          if (line.reason.isNotEmpty) ...[
            const Sizer(height: 6),
            _FullWidthTextBlock(
              label: S.current.requestReason,
              value: line.reason,
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
