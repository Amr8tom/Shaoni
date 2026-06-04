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

/// Displays the four core fields of a Car-Permission request inside the
/// request-details screen:
///   - `requestState` (الحالة)
///   - `carType` (نوع السيارة / الماركة)
///   - `carColor` (لون السيارة)
///   - `plateNumber` (رقم اللوحة)
///
/// All strings are localized through `S.current` so the same widget
/// renders correctly in both Arabic and English. Source of data is
/// `state.requestDetails.extraData.carPermission` — populated by
/// `CarPermission.fromJson` when the backend returns this request type.
class CarPermissionDetailsWidget extends StatelessWidget {
  const CarPermissionDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyRequestsCubit>();
    final car = controller.state.requestDetails?.extraData?.carPermission;

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
                S.current.orderDetails,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Divider(color: ColorRes.grey4),
              const Sizer(height: 12),

              /// Row 1 — request status + car type (brand).
              Row(
                children: [
                  OrderTextCard(
                    title: S.current.requestState,
                    result: car?.state ?? '',
                  ),
                  const Sizer(width: 10),
                  OrderTextCard(
                    title: S.current.carType,
                    result: car?.carType ?? '',
                  ),
                ],
              ),
              const Sizer(height: 12),

              /// Row 2 — car color + plate number.
              Row(
                children: [
                  OrderTextCard(
                    title: S.current.carColor,
                    result: car?.carColor ?? '',
                  ),
                  const Sizer(width: 20),
                  OrderTextCard(
                    title: S.current.plateNumber,
                    result: car?.carNumber ?? '',
                  ),
                ],
              ),
              const Sizer(height: 12),

              /// Attachment — first item of `carPermission.attachments`
              /// when present. The shared `LeavesAttachmentWidget` already
              /// handles base64 → typed file detection + share-sheet
              /// download, so we just feed it the first attachment.
              if ((car?.attachments?.isNotEmpty ?? false))
                LeavesAttachmentWidget(
                  leavesAttachment: car!.attachments!.first,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
