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

class ExitPermissionDetailsWidget extends StatelessWidget {
  const ExitPermissionDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyRequestsCubit>();
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
                S.current.orderDetails,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Divider(color: ColorRes.grey4),
              const Sizer(height: 12),
              Row(
                children: [
                  OrderTextCard(
                    title: S.current.permissionDate,
                    result: controller.state.requestDetails?.extraData
                            ?.exitPermission?.exitDate
                            ?.substring(0, 10) ??
                        '',
                  ),
                  const Sizer(width: 10),
                  OrderTextCard(
                    title: S.current.permissionTime,
                    result: controller.state.requestDetails?.extraData
                            ?.exitPermission?.permissionTimeValue ??
                        '',
                  ),
                ],
              ),
              const Sizer(height: 12),
              Row(
                children: [
                  OrderTextCard(
                    title: S.current.permissionType,
                    result: controller.state.requestDetails?.extraData
                            ?.exitPermission?.permissionTimeValue ??
                        '',
                  ),
                  const Sizer(width: 20),
                  OrderTextCard(
                    title: S.current.durationInHours,
                    result: controller.state.requestDetails?.extraData
                            ?.exitPermission?.numberOfHours
                            .toString() ??
                        '',
                  ),
                ],
              ),
              const Sizer(height: 12),
              AttachmentsView(
                attachments: controller.state.requestDetails?.extraData
                        ?.exitPermission?.attachments ??
                    const [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
