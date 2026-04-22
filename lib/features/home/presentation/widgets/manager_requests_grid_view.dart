import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/core/routing/route_names.dart';
import 'package:shaoni/features/home/presentation/widgets/home_status_badge.dart';
import 'package:shaoni/features/home/presentation/widgets/order_text_card.dart';
import 'package:shaoni/features/home/presentation/widgets/request_card.dart';
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
    final validRequests = controller.state.itemsManager.where((request) =>request.request?.requestNumber !=null).toList();

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
          itemCount: validRequests.length,
          itemBuilder: (context, index) {
            return RequestCard(

              status: S.current.localeee=='en'?validRequests[index].currentStatus?.nameEn ?? '':validRequests[index].currentStatus?.nameAr ?? '',

              statusColor:
                 validRequests[index].request?.odooStatus ==
                          "new"
                      ? ColorRes.staticBlueColor
                      : ColorRes.staticGreenColor,
              orderNumber:validRequests[index].request?.requestNumber ??
                  '',
              date:validRequests[index].request?.createdAt
                      ?.substring(0, 10) ??
                  '',
              type: S.current.localeee == "en"
                  ? controller.state.itemsManager![index].service?.nameEn
                  :validRequests[index].service?.nameAr ?? '',
              applicantName:
                 validRequests[index].requesterFullName ?? '',
              onTap: () {
                context.pushNamed(DRoutesName.requestDetailsRoute, arguments: {
                  'status': S.current.localeee=='en'?validRequests[index].currentStatus?.nameEn ?? '':validRequests[index].currentStatus?.nameAr ?? '',

                  'id':validRequests[index].request?.id ??
                      '',
                  'en_status':
                  validRequests[index].currentStatus?.nameEn ??
                      '',
                  'orderNumber': validRequests[index].request?.requestNumber
                          .toString() ??
                      '',
                  'date': validRequests[index].request?.createdAt
                          ?.substring(0, 10) ??
                      '',
                  'permissionType':validRequests[index]
                      .extraData?.exitPermission?.permissionType
                      .toString(),
                  'serviceType': S.current.localeee == "en"
                      ? controller.state.itemsManager![index].service?.nameEn
                      :validRequests[index].service?.nameAr ??
                          '',
                  'numberOfHours':validRequests[index]
                      .extraData?.exitPermission?.numberOfHours
                      .toString(),
                  'permissionDate':validRequests[index]
                          .extraData?.exitPermission?.exitDate
                          ?.substring(0, 10) ??
                      '',
                  'leavesAttachment':validRequests[index]
                          .extraData?.exitPermission?.leavesAttachment ??
                      S.current.noData,
                  'requestID':validRequests[index].request?.id
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

}
