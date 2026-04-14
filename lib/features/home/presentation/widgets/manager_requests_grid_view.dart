import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/core/routing/route_names.dart';
import 'package:shaoni/features/home/presentation/widgets/home_status_badge.dart';
import 'package:shaoni/features/home/presentation/widgets/order_text_card.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/local_storage/cache_helper.dart';
import '../../../../core/local_storage/cache_keys.dart';
import '../../../../generated/l10n.dart';
import '../../../my-requests/presentation/controller/my_requests_cubit.dart';
import '../../../navigation/presentation/controllers/navigation_cubit.dart';

class ManagerRequestsGridView extends StatelessWidget {
  const ManagerRequestsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyRequestsCubit>();
    final navController = context.watch<NavigationCubit>();

    ///
    controller.managerScrollController.addListener(() {
      // If we are 200 pixels away from the bottom, fetch more!
      if (controller.state.status.isPageLoading) {
      } else {
        if (controller.managerScrollController.position.pixels >=
            controller.managerScrollController.position.maxScrollExtent - 160) {
          if (((controller.state.managerRequests?.totalPages) ?? 0) >
              (controller.managerPage - 1 ?? 1)) {
            controller.getAllManagerRequests(
                managerID: int.parse(
                    CacheHelper.getString(key: CacheKeys.userId) ??
                        navController.state.user!.id.toString()),
                isFirestTime: false);
          }
        }
      }
    });

    return SizedBox(
      // height: AppSizes.fullHeight * 0.5,
      child: Skeletonizer(
        enabled: controller.state.status.isLoading ? true : false,
        child: GridView.builder(
          controller: controller.managerScrollController,
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 3.5,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.state.itemsManager?.length,
          itemBuilder: (context, index) {
            return _orderCard(
              context,
              status:
                  controller.state.itemsManager?[index].request?.odooStatus ??
                      '',
              statusColor:
                  controller.state.itemsManager?[index].request?.odooStatus ==
                          "new"
                      ? ColorRes.staticBlueColor
                      : ColorRes.staticGreenColor,
              orderNumber: controller
                      .state.itemsManager?[index].request?.requestId
                      .toString() ??
                  '',
              date: controller.state.itemsManager?[index].request?.createdAt
                      ?.substring(0, 10) ??
                  '',
              type: S.current.localeee == "en"
                  ? controller.state.itemsManager![index].service?.nameEn
                  : controller.state.itemsManager?[index].service?.nameAr ?? '',
              applicantName:
                  controller.state.itemsManager?[index].requesterFullName ?? '',
              onTap: () {
                context.pushNamed(DRoutesName.requestDetailsRoute, arguments: {
                  'status': controller
                          .state.itemsManager?[index].request?.odooStatus ??
                      '',
                  'orderNumber': controller
                          .state.itemsManager?[index].request?.requestId
                          .toString() ??
                      '',
                  'date': controller
                          .state.itemsManager?[index].request?.createdAt
                          ?.substring(0, 10) ??
                      '',
                  'permissionType': controller.state.itemsManager?[index]
                      .extraData?.exitPermission?.permissionType
                      .toString(),
                  'serviceType': S.current.localeee == "en"
                      ? controller.state.itemsManager![index].service?.nameEn
                      : controller.state.itemsManager?[index].service?.nameAr ??
                          '',
                  'numberOfHours': controller.state.itemsManager?[index]
                      .extraData?.exitPermission?.numberOfHours
                      .toString(),
                  'permissionDate': controller.state.itemsManager?[index]
                          .extraData?.exitPermission?.exitDate
                          ?.substring(0, 10) ??
                      '',
                  'leavesAttachment': controller.state.itemsManager?[index]
                          .extraData?.exitPermission?.leavesAttachment ??
                      S.current.noData,
                  'requestID': controller.state.itemsManager?[index].request?.id
                          .toString() ??
                      '',
                  'isManager':
                      navController.state.user?.managerId == 0 ? true : false,
                });
              },
            );
          },
        ),
      ),
    );
  }

  Widget _orderCard(
    BuildContext context, {
    required String status,
    required Color statusColor,
    required String orderNumber,
    required String date,
    required String? type,
    String? applicantName,
    required final VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSizes.padding * 0.8),
        decoration: BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.circular(AppSizes.padding / 2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.08),
              spreadRadius: 0,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderTextCard(
                  title: S.current.orderNumber,
                  result: orderNumber,
                ),
                const Sizer(height: 10),
                OrderTextCard(title: S.current.orderType, result: type ?? ''),
                const Sizer(height: 10),
                OrderTextCard(
                    title: S.current.applicantName,
                    result: applicantName ?? ''),
              ],
            ),
            //
            /// Row 2: Order Type
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeStatusBadge(statusColor: statusColor, status: status),
                const Sizer(height: 10),
                OrderTextCard(title: S.current.orderDate, result: date),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
