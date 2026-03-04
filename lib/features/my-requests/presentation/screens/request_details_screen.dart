import 'package:flutter/material.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/device/device_utility.dart';

import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import '../widgets/request_stage_card.dart';
import '../../../home/presentation/widgets/order_text_card.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({super.key});

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
          const Sizer(height: 220),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
            child: Container(
              padding: EdgeInsets.all(AppSizes.padding ),
              decoration: BoxDecoration(
                border: Border.all(width: 1,color: ColorRes.greyForBorders),
                color: ColorRes.white,
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    S.current.requestData,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Divider(color: ColorRes.grey4),
                  const Sizer(height: 12,),

                  Row(
                    children: [
                      OrderTextCard(
                        title: S.current.orderNumber,
                        result: "orderNumber",
                      ),
                      const Sizer(width: 20),
                      OrderTextCard(title: S.current.orderStatus, result: "type"),
                    ],
                  ),
                  const Sizer(height: 12,),
                  Row(
                    children: [
                      OrderTextCard(
                        title: S.current.requestType,
                        result: S.current.orderNumber,
                      ),
                    ],
                  ),
                  const Sizer(height: 12,),

                  Row(
                    children: [
                      OrderTextCard(
                        title: S.current.hijriDate,
                        result: "orderNumber",
                      ),
                      const Sizer(width: 20),
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
                border: Border.all(width: 1,color: ColorRes.greyForBorders),

                color: ColorRes.white,
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    S.current.orderDetails,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),

                  Divider(color: ColorRes.grey4),
                  const Sizer(height: 12,),

                  Row(
                    children: [
                      OrderTextCard(
                        title: S.current.permissionDate,
                        result: "orderNumber",
                      ),
                      const Sizer(width: 20),
                      OrderTextCard(title: S.current.permissionTime, result: "type"),
                    ],
                  ),
                  const Sizer(height: 12,),

                  Row(
                    children: [
                      OrderTextCard(
                        title: S.current.permissionType,
                        result: "orderNumber",
                      ),
                      const Sizer(width: 20),
                      OrderTextCard(title: S.current.durationInHours, result: "type"),
                    ],
                  ),
                  const Sizer(height: 12,),

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
          RequestStageCard(),
        ],
      ),
    );
  }
}
