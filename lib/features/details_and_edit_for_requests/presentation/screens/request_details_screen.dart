import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/service_locator/service_locator.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/current_status.dart';
import 'package:shaoni/features/details_and_edit_for_requests/presentation/controller/edit/edit_cubit.dart';
import 'package:shaoni/features/details_and_edit_for_requests/presentation/controller/my_requests_cubit.dart';
import 'package:shaoni/features/details_and_edit_for_requests/presentation/widgets/edit_request_button.dart';
import 'package:shaoni/features/details_and_edit_for_requests/presentation/widgets/request_number_and_date_widget.dart';
import '../../../../core/utils/helpers/date_converter.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/constants/service_codes.dart';
import '../../domain/enums_and_extentions/request_enums.dart';
import '../helpers/get_request_details_widget.dart';
import '../widgets/accept_request_button.dart';
import '../widgets/comment_writing_widget.dart';
import '../widgets/request_stage_card.dart';
import '../widgets/update_request_button.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
            {};
    final int id = args['id'] ?? 0;
    final String status = args['status'] ?? '';
    final CurrentStatus? currentStatus = args['currentStatus'];
    final String orderNumber = args['orderNumber'] ?? '';
    final String requestID = args['requestID'] ?? '';
    final String date = args['date'] ?? '';
    final String serviceName = args['serviceName'] ?? '';
    final String serviceCode = args['serviceCode'] ?? '';
    final bool isManager = args['isManager'] as bool? ?? false;
    final bool isKafeel = args['isKafeel'] as bool? ?? false;
    final bool isEmployeeRequest = args['isEmployeeRequest'] as bool? ?? false;
    final String hijriDate = DateConverter.convertGregorianToHijri(date);
    // Services without an explicit stage list fall back to a single-element
    // list, so guard the index access instead of assuming a manager stage.
    final List<RequestStatusEnum> requestStages =
        currentStatus?.getRequestStatusEnumList(serviceType: serviceCode) ??
            const [];
    final RequestStatusEnum? currentStatusEnum =
        currentStatus?.techName.toRequestStatusEnum;
    final bool isManagerApproval =
        requestStages.length > 1 && requestStages[1] == currentStatusEnum;
    final bool isNewRequest =
        requestStages.isNotEmpty && [requestStages[1] || requestStages[0]] == currentStatusEnum;
    // Some services stay employee-editable past the first stage, so the
    // update button must not be gated on `isNewRequest` alone.
    final bool isEditableWhilePending =
        switch (ServiceCode.fromCode(serviceCode)) {
      ServiceCode.leave => currentStatusEnum == RequestStatusEnum.draft ||
          currentStatusEnum == RequestStatusEnum.confirmed,
      ServiceCode.studyRequest =>
        currentStatusEnum == RequestStatusEnum.draft ||
            currentStatusEnum == RequestStatusEnum.applied,
      ServiceCode.trainingRequest =>
        currentStatusEnum == RequestStatusEnum.draft ||
            currentStatusEnum == RequestStatusEnum.confirmed,
      _ => false,
    };
    // The kafeel (guarantor) can act while the request is in its first two
    // stages (draft / emp).
    final bool isKafeelApproval =
        currentStatusEnum == RequestStatusEnum.draft ||
            currentStatusEnum == RequestStatusEnum.emp;
    // Whoever is reviewing (manager or kafeel) sees the same accept/reject/edit
    // controls; the kafeel just hits the same endpoints with their own session.
    final bool canReview = !isEmployeeRequest &&
        ((isManagerApproval && isManager) || (isKafeelApproval && isKafeel));

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<MyRequestsCubit>()
            ..getRequestDetails(requestId: id),
        ),
        BlocProvider(
          create: (_) => serviceLocator<EditCubit>(),
        ),
      ],
      child: Scaffold(
        appBar: DAppBar(
          showBackArrow: true,
          title: S.current.requestDetails,
        ),
        backgroundColor: ColorRes.grey6,
        body: BlocBuilder<MyRequestsCubit, MyRequestsState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  /// request number and date
                  RequestNumberAndDateWidget(
                    orderNumber: orderNumber,
                    status: status,
                    serviceType: serviceName,
                    date: date,
                    hijriDate: hijriDate,
                  ),
                  const Sizer(height: 20),

                  /// request-specific details widget
                  getRequestDetailsWidget(serviceCode: serviceCode),

                  const Sizer(height: 20),

                  /// comment field — shown to the reviewer (manager or kafeel)
                  /// while the request is pending their approval
                  if (canReview)
                    CommentWritingWidget(onCommentSubmit: (comment) {
                      context.read<EditCubit>().editNotesController.text =
                          comment;
                      context.read<MyRequestsCubit>().commentController.text =
                          comment;
                    })
                  else
                    const Sizer(),

                  /// stages timeline
                  RequestStageCard(
                    status: currentStatus,
                    serviceType: serviceCode,
                  ),

                  const Sizer(height: 20),

                  /// reviewer (manager or kafeel): accept/reject + edit
                  if (canReview) ...[
                    AcceptRejecttButton(
                      requestID: requestID,
                    ),
                    const Sizer(height: 12),
                    EditRequestButton(
                      requestID: requestID,
                      serviceCode: serviceCode,
                    ),

                    /// employee: update their own request
                  ] else if (isEmployeeRequest &&
                      (isNewRequest || isEditableWhilePending))
                    UpdateRequestButton(
                      requestID: requestID,
                      serviceType: serviceCode,
                    )
                  else
                    const Sizer(),

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
