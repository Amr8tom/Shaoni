import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/dummay.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/core/routing/route_names.dart';
import 'package:shaoni/features/home/presentation/widgets/home_status_badge.dart';
import 'package:shaoni/features/home/presentation/widgets/order_text_card.dart';
import 'package:shaoni/features/my-requests/presentation/controller/my_requests_cubit.dart';
import '../../../../generated/l10n.dart';

class MyRequestGridView extends StatelessWidget {
  const MyRequestGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<MyRequestsCubit>();
    /// Sample data - replace with actual data later
    return SizedBox(
      // height: AppSizes.fullHeight * 0.5,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: Dummy.orders.length,
        itemBuilder: (context, index) {
          return _orderCard(
            context,
            status: controller.state.requests?.items[index].request?.odooStatus??'',
            statusColor: Dummy.orders[index]['statusColor'],
            orderNumber: controller.state.requests?.items[index].request?.requestId.toString()??'',
            date: controller.state.requests?.items[index].request?.createdAt?.substring(0,10)??'',
            type: S.current.localeee=="en"?controller.state.requests?.items[index].service?.nameEn??'':controller.state.requests?.items[index].service?.nameAr??'',
            onTap: () {
              context.pushNamed(DRoutesName.requestDetailsRoute, arguments: {
                'status': controller.state.requests?.items[index].request?.odooStatus??'',
                'orderNumber': controller.state.requests?.items[index].request?.requestId.toString()??'',
                'date': controller.state.requests?.items[index].request?.createdAt?.substring(0,10)??'',
                'type':controller.state.requests?.items[index].extraData?.exitPermission?.permissionType.toString(),
                'numberOfHours':controller.state.requests?.items[index].extraData?.exitPermission?.numberOfHours.toString(),
                'permissionDate': controller.state.requests?.items[index].extraData?.exitPermission?.exitDate?.substring(0,10)??'',
                'leavesAttachment': controller.state.requests?.items[index].extraData?.exitPermission?.leavesAttachment??S.current.noData,
              });
            },
          );
        },
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
