import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/extensions/navigation_extension.dart';
import 'package:shaoni/core/routing/route_names.dart';
import 'package:shaoni/features/home/presentation/widgets/request_card.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../generated/l10n.dart';
import '../../../details_and_edit_for_requests/presentation/controller/my_requests_cubit.dart';
import '../../../navigation/presentation/controllers/navigation_cubit.dart';

class KafeelRequestsGridView extends StatelessWidget {
  const KafeelRequestsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyRequestsCubit>();
    final navController = context.watch<NavigationCubit>();
    final validRequests = controller.state.itemsKafeel
        .where((request) => request.request?.requestNumber != null)
        .toList();

    controller.kafeelScrollController.addListener(() {
      if (controller.state.status.isPageLoading) return;
      if (controller.kafeelScrollController.position.pixels >=
          controller.kafeelScrollController.position.maxScrollExtent - 160) {
        if (((controller.state.kafeelRequests?.totalPages) ?? 0) >
            (controller.kafeelPage - 1)) {
          controller.getAllKafeelRequests(
            userId: navController.state.user!.employeeId ?? 1,
            isFirestTime: false,
          );
        }
      }
    });

    return Skeletonizer(
      enabled: controller.state.status.isLoading,
      child: GridView.builder(
        controller: controller.kafeelScrollController,
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 2.4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        shrinkWrap: true,
        itemCount: validRequests.length,
        itemBuilder: (context, index) {
          final request = validRequests[index];
          return RequestCard(
            status: S.current.localeee == 'en'
                ? request.currentStatus?.nameEn ?? ''
                : request.currentStatus?.nameAr ?? '',
            statusColor: request.request?.odooStatus == 'new'
                ? ColorRes.staticBlueColor
                : ColorRes.staticGreenColor,
            orderNumber: request.request?.requestNumber ?? '',
            date: request.request?.createdAt?.substring(0, 10) ?? '',
            type: S.current.localeee == 'en'
                ? controller.state.itemsKafeel[index].service?.nameEn
                : request.service?.nameAr ?? '',
            applicantName: request.requesterFullName ?? '',
            serviceCode: request.service?.nameEn ?? '',
            currentStatus: request.currentStatus,
            onTap: () {
              context.pushNamed(
                DRoutesName.requestDetailsRoute,
                arguments: {
                  'status': S.current.localeee == 'en'
                      ? request.currentStatus?.nameEn ?? ''
                      : request.currentStatus?.nameAr ?? '',
                  'id': request.request?.id ?? '',
                  'en_status': request.currentStatus?.nameEn ?? '',
                  'currentStatus': request.currentStatus,
                  'orderNumber':
                      request.request?.requestNumber.toString() ?? '',
                  'date': request.request?.createdAt?.substring(0, 10) ?? '',
                  'permissionType': request
                      .extraData?.exitPermission?.permissionType
                      .toString(),
                  'serviceName': S.current.localeee == 'en'
                      ? controller.state.itemsKafeel[index].service?.nameEn
                      : request.service?.nameAr ?? '',
                  'serviceCode': request.service?.nameEn ?? '',
                  'numberOfHours': request
                      .extraData?.exitPermission?.numberOfHours
                      .toString(),
                  'permissionDate': request.extraData?.exitPermission?.exitDate
                          ?.substring(0, 10) ??
                      '',
                  'leavesAttachment':
                      request.extraData?.exitPermission?.leavesAttachment ??
                          S.current.noData,
                  'requestID': request.request?.id.toString() ?? '',
                  'isManager': false,
                  'isEmployeeRequest': false,
                },
              );
            },
          );
        },
      ),
    );
  }
}
