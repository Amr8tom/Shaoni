import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/order_text_card.dart';
import '../controller/my_requests_cubit.dart';

class SalaryTransferDetailsWidget extends StatelessWidget {
  const SalaryTransferDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyRequestsCubit>();
    final requestData = controller.state.requestDetails;
    
    // Note: Assuming extraData contains a salaryRequest object in the future
    // For now we map available base fields.

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

              /// Row 1 — request number + request date
              Row(
                children: [
                  Expanded(
                    child: OrderTextCard(
                      title: S.current.requestNumber,
                      result: requestData?.request?.requestNumber ?? '',
                    ),
                  ),
                  const Sizer(width: 10),
                  Expanded(
                    child: OrderTextCard(
                      title: S.current.date,
                      result: _formatDate(requestData?.request?.createdAt),
                    ),
                  ),
                ],
              ),
              const Sizer(height: 12),

              /// Manager name (conditional)
              if ((requestData?.managerFullName?.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.manager,
                  result: requestData?.managerFullName ?? '',
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
