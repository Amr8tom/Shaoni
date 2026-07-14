import 'package:flutter/material.dart';

import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/order_text_card.dart';

class RequestNumberAndDateWidget extends StatelessWidget {
  final String orderNumber;
  final String status;
  final String serviceType;
  final String date;
  final String hijriDate;

  const RequestNumberAndDateWidget(
      {super.key,
      required this.orderNumber,
      required this.status,
      required this.serviceType,
      required this.date,
      required this.hijriDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              S.current.requestData,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Divider(color: ColorRes.grey4),
            const Sizer(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderTextCard(
                  title: S.current.orderNumber,
                  result: orderNumber.length >= 9
                      ? orderNumber.substring(5)
                      : orderNumber,
                ),
                orderNumber.length >= 9
                    ? const Sizer(width: 20)
                    : const Sizer(width: 0),
                OrderTextCard(
                  title: S.current.orderStatus,
                  result: status,
                ),
              ],
            ),
            const Sizer(height: 12),
            Row(
              children: [
                OrderTextCard(
                    title: S.current.requestType, result: serviceType),
              ],
            ),
            const Sizer(height: 12),
            Row(
              children: [
                OrderTextCard(title: S.current.hijriDate, result: hijriDate),
                const Sizer(width: 3),
                OrderTextCard(title: S.current.dateBirth, result: date),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
