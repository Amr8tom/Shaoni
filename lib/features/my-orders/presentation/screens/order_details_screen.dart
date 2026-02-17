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
              padding: EdgeInsets.all(AppSizes.padding / 2),
              // height: AppSizes.heightcontainer,
              // width: AppSizes.widthcontainer,
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
                      const Sizer(width: 90),
                      OrderTextCard(title: S.current.orderType, result: "type"),
                    ],
                  ),
                  Row(
                    children: [
                      OrderTextCard(
                        title: S.current.orderNumber,
                        result: S.current.orderNumber,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      OrderTextCard(
                        title: S.current.orderNumber,
                        result: "orderNumber",
                      ),
                      const Sizer(width: 90),
                      OrderTextCard(title: S.current.orderType, result: "type"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Sizer(height: 5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
            child: Container(

              decoration: BoxDecoration(
                color: ColorRes.white,
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
              ),
              child: Column(
                children: [
                  Text(S.current.requestData),
                  Divider(color: ColorRes.grey4),
                  Row(
                    children: [
                      OrderTextCard(
                        title: S.current.orderNumber,
                        result: "orderNumber",
                      ),
                      const Sizer(width: 10),
                      OrderTextCard(title: S.current.orderType, result: "type"),
                    ],
                  ),
                  Row(
                    children: [
                      OrderTextCard(
                        title: S.current.orderNumber,
                        result: "orderNumber",
                      ),
                      const Sizer(width: 10),
                      OrderTextCard(title: S.current.orderType, result: "type"),
                    ],
                  ),
                  Row(
                    children: [
                      OrderTextCard(
                        title: S.current.orderNumber,
                        result: "orderNumber",
                      ),
                      const Sizer(width: 10),
                      OrderTextCard(title: S.current.orderType, result: "type"),
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
