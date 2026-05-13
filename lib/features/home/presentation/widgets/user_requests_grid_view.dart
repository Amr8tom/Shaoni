import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/custom_ui.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/core/routing/route_names.dart';
import 'package:shaoni/features/home/presentation/widgets/request_card.dart';
import 'package:shaoni/features/my-requests/domain/entities/request_with_stage.dart';
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
    final List<RequestWithStage> validRequests =
        controller.state.status.isLoading
            ? List.filled(
                6,
                RequestWithStage(
                    odooStageId: 1, requesterFullName: '', managerFullName: ''))
            : controller.state.itemsUser
                .where((request) => request.request?.requestNumber != null)
                .toList();

    controller.userScrollController.addListener(() {
      /// If we are 160 pixels away from the bottom, fetch more!
      if (controller.state.status.isPageLoading) {
      } else {
        if (controller.userScrollController.position.pixels >=
            controller.userScrollController.position.maxScrollExtent - 160) {
          if (((controller.state.userRequests?.totalPages) ?? 0) >
              (controller.userPage - 1 ?? 1)) {
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
    return validRequests.length == 0
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
                    childAspectRatio: 4.2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: validRequests.length,
                  itemBuilder: (context, index) {
                    return RequestCard(
                      status: S.current.localeee == 'en'
                          ? validRequests[index].currentStatus?.nameEn ?? ''
                          : validRequests[index].currentStatus?.nameAr ?? '',
                      statusColor:
                          validRequests[index].request?.odooStatus == "new"
                              ? ColorRes.staticBlueColor
                              : ColorRes.staticGreenColor,
                      orderNumber: validRequests[index]
                              .request
                              ?.requestNumber
                              .toString() ??
                          '',
                      date: validRequests[index]
                              .request
                              ?.createdAt
                              ?.substring(0, 10) ??
                          '',
                      type: S.current.localeee == "en"
                          ? validRequests[index].service?.nameEn ?? ''
                          : validRequests[index].service?.nameAr ?? '',
                      onTap: () {
                        // controller.getRequestDetails(requestId: validRequests[index].request?.id);

                        context.pushNamed(DRoutesName.requestDetailsRoute,
                            arguments: {
                              'id': validRequests[index].request?.id ?? '',
                              'en_status':
                                  validRequests[index].currentStatus?.nameEn ??
                                      '',
                              'status': S.current.localeee == 'en'
                                  ? validRequests[index]
                                          .currentStatus
                                          ?.nameEn ??
                                      ''
                                  : validRequests[index]
                                          .currentStatus
                                          ?.nameAr ??
                                      '',
                              'currentStatus':
                                  validRequests[index].currentStatus,
                              'orderNumber': validRequests[index]
                                      .request
                                      ?.requestNumber
                                      .toString() ??
                                  '',
                              'date': validRequests[index]
                                      .request
                                      ?.createdAt
                                      ?.substring(0, 10) ??
                                  '',
                              'permissionType': validRequests[index]
                                  .extraData
                                  ?.exitPermission
                                  ?.permissionType
                                  .toString(),
                              'serviceName': S.current.localeee == "en"
                                  ? validRequests[index].service?.nameEn ?? ''
                                  : validRequests[index].service?.nameAr ?? '',
                              'serviceCode':
                                  validRequests[index].service?.nameEn ?? '',
                              'numberOfHours': validRequests[index]
                                  .extraData
                                  ?.exitPermission
                                  ?.numberOfHours
                                  .toString(),
                              'permissionDate': validRequests[index]
                                      .extraData
                                      ?.exitPermission
                                      ?.exitDate
                                      ?.substring(0, 10) ??
                                  '',
                              'leavesAttachment': validRequests[index]
                                      .extraData
                                      ?.exitPermission
                                      ?.leavesAttachment ??
                                  S.current.noData,
                              'requestID':
                                  validRequests[index].request?.id.toString() ??
                                      '',
                              'isManager':
                                  navController.state.user?.managerId == 0
                                      ? true
                                      : false,
                              "isEmployeeRequest": true,
                            });
                      },
                    );
                  }
                  // },
                  ),
            ),
          );
  }
}
