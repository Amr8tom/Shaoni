import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/order_text_card.dart';
import '../controller/my_requests_cubit.dart';
import 'attachements_widget.dart';

class SalaryTransferDetailsWidget extends StatelessWidget {
  const SalaryTransferDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyRequestsCubit>();
    final requestData = controller.state.requestDetails;

    final salaryRequest = requestData?.extraData?.salaryRequest;

    return Skeletonizer(
      enabled: controller.state.status.isLoading,
      child: Padding(
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
              /// Section header
              Text(
                S.current.orderDetails,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Divider(color: ColorRes.grey4),
              const Sizer(height: 12),

              /// Row 1 — request number + request date
              Row(
                children: [
                  Expanded(
                    child: OrderTextCard(
                      title: S.current.requestNumber,
                      result: requestData?.request?.requestNumber ?? '',
                    ),
                  ),
                  const Sizer(width: 10),
                  Expanded(
                    child: OrderTextCard(
                      title: S.current.date,
                      result: _formatDate(requestData?.request?.createdAt),
                    ),
                  ),
                ],
              ),
              const Sizer(height: 12),

              /// Manager name (conditional)
              if ((requestData?.managerFullName?.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.manager,
                  result: requestData?.managerFullName ?? '',
                ),
                const Sizer(height: 12),
              ],

              if (salaryRequest != null) ...[
                Row(
                  children: [
                    Expanded(
                      child: OrderTextCard(
                        title: S.current.requestType,
                        result: _getSalaryRequestTypeLabel(
                            salaryRequest.salaryRequestType),
                      ),
                    ),
                    const Sizer(width: 10),
                    Expanded(
                      child: OrderTextCard(
                        title: S.current.accountNumber,
                        result: salaryRequest.accountNumber ?? '',
                      ),
                    ),
                  ],
                ),
                const Sizer(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OrderTextCard(
                        title: S.current.salaryDocumentType,
                        result: _getRequiredDocumentLabel(
                            salaryRequest.requiredDocument),
                      ),
                    ),
                    const Sizer(width: 10),
                    Expanded(
                      child: OrderTextCard(
                        title: S.current.ibanNumber,
                        result: salaryRequest.iban ?? '',
                      ),
                    ),
                  ],
                ),
                const Sizer(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OrderTextCard(
                        title: S.current.salaryTypeTarget,
                        result: _getSalaryTypeLabel(salaryRequest.salaryType),
                      ),
                    ),
                    const Sizer(width: 10),
                    Expanded(
                      child: OrderTextCard(
                        title: S.current.notesLabel,
                        result: salaryRequest.note ?? '',
                      ),
                    ),
                  ],
                ),
                if (salaryRequest.bankId != null) ...[
                  const Sizer(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OrderTextCard(
                          title: S.current.bankName,
                          result: salaryRequest.bankId!.toString(),
                        ),
                      ),
                      const Sizer(width: 10),
                      const Expanded(child: SizedBox.shrink()),
                    ],
                  ),
                ],
                if ((salaryRequest.ibanAttachment?.isNotEmpty ?? false)) ...[
                  const Sizer(height: 12),
                  LeavesAttachmentWidget(
                    leavesAttachment: salaryRequest.ibanAttachment!,
                    title: S.current.ibanAttachment,
                  ),
                ],
                if ((salaryRequest.disclaimerAttachment?.isNotEmpty ??
                    false)) ...[
                  const Sizer(height: 12),
                  LeavesAttachmentWidget(
                    leavesAttachment: salaryRequest.disclaimerAttachment!,
                    title: S.current.disclaimerAttachment,
                  ),
                ],
                const Sizer(height: 12),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _getSalaryRequestTypeLabel(String? code) {
    if (code == null) return '';
    if (code == 'salary_transfer_request') {
      return S.current.salaryTransfer;
    }
    if (code == 'salary_definition_request') {
      return S.current.salaryDefinitionRequest;
    }
    return code;
  }

  String _getSalaryTypeLabel(String? code) {
    if (code == null) return '';
    if (code == 'basic') {
      return S.current.basic;
    }
    if (code == 'total' || code == 'gross') {
      return S.current.totalSalary;
    }
    return code;
  }

  String _getRequiredDocumentLabel(String? code) {
    if (code == null) return '';
    if (code == 'salary_definition' || code == 'salary_certificate') {
      return S.current.salaryDefinition;
    }
    return code;
  }

  String _formatDate(String? iso) {
    if (iso == null || iso.isEmpty) return '';
    return iso.length >= 10 ? iso.substring(0, 10) : iso;
  }
}
