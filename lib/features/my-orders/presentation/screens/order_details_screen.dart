import 'package:flutter/material.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/device/device_utility.dart';

import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import '../widgets/order_stage_card.dart';
import '../../../home/presentation/widgets/order_text_card.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DAppBar(
        showBackArrow: true,
        appHeight: DDeviceUtils.getAppBarHeight() * 3,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: ColorRes.grey6,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Sizer(height: 200),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
            child: Container(
              padding: EdgeInsets.all(AppSizes.padding ),
              decoration: BoxDecoration(
                color: ColorRes.white,
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.current.requestData,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Divider(color: ColorRes.grey4),
                  Row(
                    children: [
                      OrderTextCard(
                        title: S.current.orderNumber,
                        result: "orderNumber",
                      ),
                      const Sizer(width: 80),
                      OrderTextCard(title: S.current.orderStatus, result: "type"),
                    ],
                  ),
                  Row(
                    children: [
                      OrderTextCard(
                        title: S.current.requestType,
                        result: S.current.orderNumber,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      OrderTextCard(
                        title: S.current.hijriDate,
                        result: "orderNumber",
                      ),
                      const Sizer(width: 80),
                      OrderTextCard(title: S.current.dateBirth, result: "type"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Sizer(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
            child: Container(
              padding: EdgeInsets.all(AppSizes.padding ),
              decoration: BoxDecoration(
                color: ColorRes.white,
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.current.orderDetails,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Divider(color: ColorRes.grey4),
                  Row(
                    children: [
                      OrderTextCard(
                        title: S.current.permissionDate,
                        result: "orderNumber",
                      ),
                      const Sizer(width: 80),
                      OrderTextCard(title: S.current.permissionTime, result: "type"),
                    ],
                  ),

                  Row(
                    children: [
                      OrderTextCard(
                        title: S.current.permissionType,
                        result: "orderNumber",
                      ),
                      const Sizer(width: 80),
                      OrderTextCard(title: S.current.durationInHours, result: "type"),
                    ],
                  ),
                  Row(
                    children: [
                      OrderTextCard(
                        title: S.current.attachments,
                        result: S.current.medicalReportFromDoctor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Sizer(height: 20),
          OrderStageCard(),
        ],
      ),
    );
  }
}
