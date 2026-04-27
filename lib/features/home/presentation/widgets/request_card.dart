import 'package:flutter/material.dart';
import '../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import 'home_status_badge.dart';
import 'order_text_card.dart';

class RequestCard extends StatelessWidget {
  final String status;
  final Color statusColor;
  final String orderNumber;
  final String? applicantName;
  final String date;
  final String? type;
  final VoidCallback? onTap;

  const RequestCard(
      {super.key,
      required this.status,
      required this.statusColor,
      required this.orderNumber,
      required this.date,
      this.type,
      this.onTap,
      this.applicantName});

  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
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
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                OrderTextCard(
                    title: S.current.orderNumber,
                    result: orderNumber.substring(9)??' ',
                  ),
                  const Sizer(height: 10),
                  OrderTextCard(title: S.current.orderType, result: type ?? ''),
                  if (applicantName != null) ...[
                    const Sizer(height: 10),
                    OrderTextCard(
                        title: S.current.applicantName,
                        result: applicantName ?? ''),
                  ]
                ],
              ),
            ),
            Expanded(

              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrderTextCard(title: S.current.orderDate, result: date),
                  const Sizer(height:12),
                  HomeStatusBadge(statusColor: statusColor, status: status),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
