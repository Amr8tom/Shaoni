import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../../core/constants/app_sizes.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../generated/l10n.dart';
import '../../controller/scrap_request/scrap_request_cubit.dart';
import 'scrap_line_item_row.dart';

class ScrapRequestDataWidget extends StatelessWidget {
  const ScrapRequestDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScrapRequestCubit, ScrapRequestState>(
      builder: (context, state) {
        final controller = context.read<ScrapRequestCubit>();
        final lots = state.custodyProductId != null
            ? (state.lots[state.custodyProductId!] ?? const [])
            : const [];

        return Container(
          padding: EdgeInsets.all(AppSizes.padding),
          decoration: BoxDecoration(
            color: ColorRes.white,
            borderRadius:
                BorderRadius.circular(AppSizes.borderRadiusLarge),
            border: Border.all(color: ColorRes.greyForBorders),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.current.requestLines,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Divider(color: ColorRes.grey4),
              const Sizer(height: 8),

              ...state.lineItems.map(
                (item) => ScrapLineItemRow(
                  key: ValueKey(item.localId),
                  item: item,
                  lots: lots,
                  qtyController: controller.qtyController(item.localId),
                  reasonController:
                      controller.reasonController(item.localId),
                  onLotChanged: (id, name) =>
                      controller.updateItemLot(item.localId, id, name),
                  onDelete: state.lineItems.length > 1
                      ? () => controller.removeLineItem(item.localId)
                      : null,
                ),
              ),

              const Sizer(height: 12),

              GestureDetector(
                onTap: controller.addLineItem,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: AppSizes.padding * 0.6,
                    horizontal: AppSizes.padding,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: ColorRes.primary,
                        style: BorderStyle.solid),
                    borderRadius:
                        BorderRadius.circular(AppSizes.borderRadiusMd),
                    color: ColorRes.primary.withValues(alpha: 0.06),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, color: ColorRes.primary, size: 18),
                      const Sizer(width: 6.4),
                      Text(
                        S.current.addLine,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                              color: ColorRes.primary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
