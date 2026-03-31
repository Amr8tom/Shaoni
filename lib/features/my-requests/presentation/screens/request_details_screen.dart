import 'package:flutter/material.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/device/device_utility.dart';
import '../../../../core/utils/helpers/date_converter.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import '../widgets/request_stage_card.dart';
import '../../../home/presentation/widgets/order_text_card.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Extract arguments from navigation
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
        {};

    final String status = args['status'] ?? '';
    final String orderNumber = args['orderNumber'] ?? '';
    final String date = args['date'] ?? '';
    final String type = args['type'] ?? '';
    final String numberOfHours = args['numberOfHours'] ?? '';
    final String permissionDate = args['permissionDate'] ?? '';
    final String leavesAttachment = args['leavesAttachment'] ?? '';

    /// Convert date to Hijri format
    final String hijriDate = DateConverter.convertGregorianToHijri(date);

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
                  Divider(color: ColorRes.grey4),
                  const Sizer(height: 12),

                  Row(
                    children: [
                      OrderTextCard(
                        title: S.current.orderNumber,
                        result: orderNumber,
                      ),
                      const Sizer(width: 20),
                      OrderTextCard(
                        title: S.current.orderStatus,
                        result: status,
                      ),
                    ],
                  ),
                  const Sizer(height: 12),
                  Row(
                    children: [
                      OrderTextCard(title: S.current.requestType, result: type),
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
          ),
          const Sizer(height: 20),
          Padding(
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
                    S.current.orderDetails,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Divider(color: ColorRes.grey4),
                  const Sizer(height: 12),

                  Row(
                    children: [
                      OrderTextCard(
                        title: S.current.permissionDate,
                        result: permissionDate,
                      ),
                      const Sizer(width: 20),
                      OrderTextCard(
                        title: S.current.permissionTime,
                        result:permissionDate,
                      ),
                    ],
                  ),
                  const Sizer(height: 12),

                  Row(
                    children: [
                      OrderTextCard(
                        title: S.current.permissionType,
                        result: type,
                      ),
                      const Sizer(width: 20),
                      OrderTextCard(
                        title: S.current.durationInHours,
                        result: numberOfHours,
                      ),
                    ],
                  ),
                  const Sizer(height: 12),

                  Row(
                    children: [
                      OrderTextCard(
                        title: S.current.attachments,
                        result: leavesAttachment??S.current.noData,
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
