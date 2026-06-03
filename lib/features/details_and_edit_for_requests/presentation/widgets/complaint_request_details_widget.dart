import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/order_text_card.dart';
import '../controller/my_requests_cubit.dart';
import 'attachements_widget.dart';

class ComplaintRequestDetailsWidget extends StatelessWidget {
  const ComplaintRequestDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyRequestsCubit>();
    final complaint =
        controller.state.requestDetails?.extraData?.complaintRequest;

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
              /// Section header.
              Text(
                S.current.complaintRequestDetails,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Divider(color: ColorRes.grey4),
              const Sizer(height: 12),

              /// Row 1 — request status + complaint type.
              Row(
                children: [
                  OrderTextCard(
                    title: S.current.requestState,
                    result: complaint?.state ?? '',
                  ),
                  const Sizer(width: 10),
                  OrderTextCard(
                    title: S.current.complaintTypeLabel,
                    result: complaint?.complaintType ?? '',
                  ),
                ],
              ),
              const Sizer(height: 12),

              /// Row 2 — complaint reason.
              Row(
                children: [
                  OrderTextCard(
                    title: S.current.complaintReasonLabel,
                    result: complaint?.complaintReason ?? '',
                  ),
                ],
              ),
              const Sizer(height: 12),

              /// Full-width — complaint description.
              if ((complaint?.complaintDescription?.isNotEmpty ?? false))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.current.complaintDescriptionLabel,
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
                        borderRadius:
                            BorderRadius.circular(AppSizes.borderRadiusMd),
                        border: Border.all(color: ColorRes.grey5),
                      ),
                      child: Text(
                        complaint!.complaintDescription!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const Sizer(height: 12),
                  ],
                ),

              /// Attachment — when present.
              if ((complaint?.attachments?.isNotEmpty ?? false))
                LeavesAttachmentWidget(
                  leavesAttachment: complaint!.attachments?.first,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
