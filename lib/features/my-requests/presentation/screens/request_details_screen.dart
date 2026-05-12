import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/service_locator/service_locator.dart';
import 'package:shaoni/features/my-requests/domain/entities/current_status.dart';
import 'package:shaoni/features/my-requests/presentation/controller/my_requests_cubit.dart';
import 'package:shaoni/features/my-requests/presentation/widgets/request_number_and_date_widget.dart';
import '../../../../core/utils/helpers/date_converter.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import '../../domain/enums_and_extentions/request_enums.dart';
import '../widgets/accept_request_button.dart';
import '../widgets/car_permission_details_widget.dart';
import '../widgets/complaint_request_details_widget.dart';
import '../widgets/comment_writing_widget.dart';
import '../widgets/exit_permission_details_widget.dart';
import '../widgets/request_stage_card.dart';

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
    final CurrentStatus currentStatus = args['currentStatus'] ?? '';
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
          title: S.current.requestDetails,
        ),
        backgroundColor: ColorRes.grey6,
        body: BlocBuilder<MyRequestsCubit, MyRequestsState>(
          builder: (context, state) {
            // final status = controller.state.requestDetails?.currentStatus?.nameAr?.trim() ??
            //     '';
            return SingleChildScrollView(
              child: Column(
                children: [
                  /// request number and date
                  RequestNumberAndDateWidget(
                      orderNumber: orderNumber,
                      status: status,
                      serviceType: serviceType,
                      date: date,
                      hijriDate: hijriDate),
                  const Sizer(height: 20),

                  /// request details
                  serviceType == "car.permission"
                      ? const CarPermissionDetailsWidget()
                      : serviceType == "complaint.request"
                          ? const ComplaintRequestDetailsWidget()
                          : const ExitPermissionDetailsWidget(),

                  const Sizer(height: 20),
                  if (currentStatus.getRequestStatusEnum== RequestStatusEnum.newRequest)
                    isManager ? const CommentWritingWidget() : const Sizer(),
                  RequestStageCard(
                    status: currentStatus,
                  ),
                  if (currentStatus.getRequestStatusEnum== RequestStatusEnum.newRequest)
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
