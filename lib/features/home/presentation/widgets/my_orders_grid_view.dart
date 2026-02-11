import 'package:flutter/material.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/features/home/presentation/widgets/home_status_badge.dart';
import 'package:shaoni/features/home/presentation/widgets/order_text_card.dart';

import '../../../../generated/l10n.dart';

class MyOrdersGridView extends StatelessWidget {
  const MyOrdersGridView({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data - replace with actual data later
    final List<Map<String, dynamic>> orders = [
      {
        'status': 'approved',
        'statusColor': ColorRes.green,
        'orderNumber': '#VL2110',
        'date': '07 Oct, 2021',
        'type': 'study order',
      },
      {
        'status': 'waiting',
        'statusColor': ColorRes.blueColor,
        'orderNumber': '#VL2111',
        'date': '07 Oct, 2021',
        'type': 'order viewing',
      },
      {
        'status': 'rejectet',
        'statusColor': ColorRes.yellow,
        'orderNumber': '#VL2112',
        'date': '07 Oct, 2021',
        'type': 'order left',
      },
      {
        'status': 'deleted',
        'statusColor': ColorRes.error,
        'orderNumber': '#VL2113',
        'date': '07 Oct, 2021',
        'type': 'loan ',
      },
      {
      'status': 'deleted',
      'statusColor': ColorRes.error,
      'orderNumber': '#VL2113',
      'date': '07 Oct, 2021',
      'type': 'loan ',
      },
      {
        'status': 'deleted',
        'statusColor': ColorRes.error,
        'orderNumber': '#VL2113',
        'date': '07 Oct, 2021',
        'type': 'loan ',
      },
    ];

    return SizedBox(
      height: AppSizes.fullHeight*0.56,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 4,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return _orderCard(
            context,
            status: orders[index]['status'],
            statusColor: orders[index]['statusColor'],
            orderNumber: orders[index]['orderNumber'],
            date: orders[index]['date'],
            type: orders[index]['type'],
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
  }) {
    return Container(

      padding: EdgeInsets.all(AppSizes.padding *0.8),
      decoration: BoxDecoration(
        color: ColorRes.white,
        borderRadius: BorderRadius.circular(AppSizes.padding/2),
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
              OrderTextCard( title: S.current.orderNumber, result: orderNumber),
              const Sizer(height: 10,),
              OrderTextCard(title: S.current.orderType, result: type,),
            ],
          ),
          //
          /// Row 2: Order Type
          const Spacer(),
          //
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              HomeStatusBadge(statusColor: statusColor,status: status,),
              const Sizer(height: 10,),

              OrderTextCard(title: S.current.orderDate, result: date),
            ],
          ),
        ],
      ),
    );
  }



}
