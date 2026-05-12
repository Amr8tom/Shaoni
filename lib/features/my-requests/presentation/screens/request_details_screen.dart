import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/service_locator/service_locator.dart';
import 'package:shaoni/features/my-requests/presentation/controller/my_requests_cubit.dart';
import 'package:shaoni/features/my-requests/presentation/widgets/attachements_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/utils/helpers/date_converter.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import '../widgets/accept_request_button.dart';
import '../widgets/car_permission_details_widget.dart';
import '../widgets/complaint_request_details_widget.dart';
import '../widgets/comment_writing_widget.dart';
import '../widgets/exit_permission_details_widget.dart';
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

    final int id = args['id'] ?? '';
    final String status = args['status'] ?? '';
    final String enStatus = args['en_status'] ?? '';
    final String orderNumber = args['orderNumber'] ?? '';
    final String requestID = args['requestID'] ?? '';
    final String date = args['date'] ?? '';
    final String serviceType = args['serviceType'] ?? '';

    final bool isManager = args['isManager'];

    /// Convert date to Hijri format
    final String hijriDate = DateConverter.convertGregorianToHijri(date);

    return BlocProvider(
      create: (context) =>
          serviceLocator<MyRequestsCubit>()..getRequestDetails(requestId: id),
      child: Scaffold(
        appBar: DAppBar(
          showBackArrow: true,
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: ColorRes.grey6,
        body: BlocBuilder<MyRequestsCubit, MyRequestsState>(
          builder: (context, state) {
            // final status = controller.state.requestDetails?.currentStatus?.nameAr?.trim() ??
            //     '';
            return SingleChildScrollView(
              child: Column(
                children: [
                  const Sizer(height: 220),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
                    child: Container(
                      padding: EdgeInsets.all(AppSizes.padding),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: ColorRes.greyForBorders),
                        color: ColorRes.white,
                        borderRadius:
                            BorderRadius.circular(AppSizes.borderRadiusLarge),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.current.requestData,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          Divider(color: ColorRes.grey4),
                          const Sizer(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OrderTextCard(
                                title: S.current.orderNumber,
                                result: orderNumber.length >= 9
                                    ? orderNumber.substring(9)
                                    : orderNumber ?? ' ',
                              ),
                              // const Sizer(width: 20),
                              orderNumber.length >= 9
                                  ? const Sizer(width: 20)
                                  : const Sizer(width: 0),
                              OrderTextCard(
                                title: S.current.orderStatus,
                                result: status ?? '',
                              ),
                            ],
                          ),
                          const Sizer(height: 12),
                          Row(
                            children: [
                              OrderTextCard(
                                  title: S.current.requestType,
                                  result: serviceType),
                            ],
                          ),
                          const Sizer(height: 12),
                          Row(
                            children: [
                              OrderTextCard(
                                  title: S.current.hijriDate,
                                  result: hijriDate),
                              const Sizer(width: 3),
                              OrderTextCard(
                                  title: S.current.dateBirth, result: date),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Sizer(height: 20),

                  /// request details
                  serviceType == "car.permission"
                      ? const CarPermissionDetailsWidget()
                      : serviceType == "complaint.request"
                          ? const ComplaintRequestDetailsWidget()
                          : const ExitPermissionDetailsWidget(),

                  const Sizer(height: 20),
                  if (enStatus.toLowerCase() == "new")
                    isManager ? const CommentWritingWidget() : const Sizer(),
                  RequestStageCard(
                    status: enStatus,
                  ),
                  if (enStatus.toLowerCase() == "new")
                    isManager
                        ? AcceptRequestButton(requestID: requestID)
                        : const Sizer(),
                  const Sizer(height: 65),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
