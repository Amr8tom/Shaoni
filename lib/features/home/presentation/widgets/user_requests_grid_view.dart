import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/custom_ui.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/core/routing/route_names.dart';
import 'package:shaoni/features/home/presentation/widgets/home_status_badge.dart';
import 'package:shaoni/features/home/presentation/widgets/order_text_card.dart';
import 'package:shaoni/features/my-requests/presentation/controller/my_requests_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/local_storage/cache_helper.dart';
import '../../../../core/local_storage/cache_keys.dart';
import '../../../../generated/l10n.dart';
import '../../../navigation/presentation/controllers/navigation_cubit.dart';

class UserRequestsGridView extends StatelessWidget {
  const UserRequestsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyRequestsCubit>();
    final navController = context.watch<NavigationCubit>();
    controller.userScrollController.addListener(() {
      // If we are 200 pixels away from the bottom, fetch more!
      if (controller.state.status.isPageLoading) {
      } else {
        if (controller.userScrollController.position.pixels >=
            controller.userScrollController.position.maxScrollExtent - 160) {
          // print("employee id in user request grid view ${CacheHelper.getString(key: CacheKeys.employeeId)}");
          // print(CacheHelper.getString(key: CacheKeys.employeeId));
          if(controller.state.requests!.totalPages > controller.userPage ){
            controller.getAllUserRequests(
                employeeId: int.parse(
                    CacheHelper.getString(key: CacheKeys.employeeId) ??
                        navController.state.user!.employeeId.toString()),
                isFirestTime: false);
          }

        }
      }
    });

    /// Sample data - replace with actual data later
    return controller.state.itemsUser?.length == 0
        ? CustomUI.noData()
        : SizedBox(
            // height: AppSizes.fullHeight * 0.5,
            child: Skeletonizer(
              enabled: controller.state.status.isLoading ? true : false,
              child: GridView.builder(
                controller: controller.userScrollController,
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.state.itemsUser?.length,
                itemBuilder: (context, index) {
                  // if (controller.state.itemsUser?[index].request?.requestId ==
                  //     null) {return SizedBox();}else
                  // {
                    return _orderCard(
                    context,
                    status: controller
                            .state.itemsUser?[index].request?.odooStatus ??
                        '',
                    statusColor: controller
                                .state.itemsUser?[index].request?.odooStatus ==
                            "new"
                        ? ColorRes.staticBlueColor
                        : ColorRes.staticGreenColor,
                    orderNumber: controller
                            .state.itemsUser?[index].request?.requestId
                            .toString() ??
                        '',
                    date: controller.state.itemsUser?[index].request?.createdAt
                            ?.substring(0, 10) ??
                        '',
                    type: S.current.localeee == "en"
                        ? controller.state.itemsUser![index].service?.nameEn ??
                            ''
                        : controller.state.itemsUser?[index].service?.nameAr ??
                            '',
                    onTap: () {
                      context.pushNamed(DRoutesName.requestDetailsRoute,
                          arguments: {
                            'status': controller.state.itemsUser?[index].request
                                    ?.odooStatus ??
                                '',
                            'orderNumber': controller
                                    .state.itemsUser?[index].request?.requestId
                                    .toString() ??
                                '',
                            'date': controller
                                    .state.itemsUser?[index].request?.createdAt
                                    ?.substring(0, 10) ??
                                '',
                            'permissionType': controller.state.itemsUser?[index]
                                .extraData?.exitPermission?.permissionType
                                .toString(),
                            'serviceType': S.current.localeee == "en"
                                ? controller.state.itemsUser![index].service
                                        ?.nameEn ??
                                    ''
                                : controller.state.itemsUser?[index].service
                                        ?.nameAr ??
                                    '',
                            'numberOfHours': controller.state.itemsUser?[index]
                                .extraData?.exitPermission?.numberOfHours
                                .toString(),
                            'permissionDate': controller.state.itemsUser?[index]
                                    .extraData?.exitPermission?.exitDate
                                    ?.substring(0, 10) ??
                                '',
                            'leavesAttachment': controller
                                    .state
                                    .itemsUser?[index]
                                    .extraData
                                    ?.exitPermission
                                    ?.leavesAttachment ??
                                S.current.noData,
                            'requestID': controller
                                    .state.itemsUser?[index].request?.id
                                    .toString() ??
                                '',
                            'isManager':
                                navController.state.user?.managerId == 0
                                    ? true
                                    : false,
                          });
                    },
                  );}
                // },
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
    required String type,
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
                OrderTextCard(title: S.current.orderType, result: type),
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
