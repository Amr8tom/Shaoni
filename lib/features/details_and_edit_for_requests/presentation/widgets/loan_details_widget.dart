import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/order_text_card.dart';
import '../controller/my_requests_cubit.dart';
import 'details/loan_info_cell.dart';
import 'details/loan_installments_table.dart';
import 'details/loan_need_emp_badge.dart';

class LoanDetailsWidget extends StatelessWidget {
  const LoanDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyRequestsCubit>();
    final requestData = controller.state.requestDetails;
    final loanRequest = requestData?.extraData?.loanRequest;
    final firstHijri = loanRequest?.installments?.isNotEmpty == true
        ? loanRequest!.installments!.first.hijriDate
        : null;

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

              /// Manager name
              if ((requestData?.managerFullName?.isNotEmpty ?? false)) ...[
                OrderTextCard(
                  title: S.current.manager,
                  result: requestData?.managerFullName ?? '',
                ),
                const Sizer(height: 12),
              ],

              if (loanRequest != null) ...[
                /// Odoo request number — full width
                if (loanRequest.externalName?.isNotEmpty == true) ...[
                  LoanInfoCell(
                    label: S.current.odooRequestNumber,
                    value: loanRequest.externalName!,
                  ),
                  const Sizer(height: 16),
                ],

                /// Loan type + amount
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: LoanInfoCell(
                        label: S.current.loanType,
                        value: loanRequest.loanTypeName ?? '',
                      ),
                    ),
                    const Sizer(width: 16),
                    Expanded(
                      child: LoanInfoCell(
                        label: S.current.loanAmount,
                        value: loanRequest.loanRequestAmount?.toString() ?? '',
                      ),
                    ),
                  ],
                ),
                const Sizer(height: 16),

                /// Payment period + first installment date
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: LoanInfoCell(
                        label: S.current.loanPaymentPeriod,
                        value: loanRequest.loanPaymentPeriod?.toString() ?? '',
                      ),
                    ),
                    const Sizer(width: 16),
                    Expanded(
                      child: LoanInfoCell(
                        label: S.current.firstInstallmentDate,
                        valueWidget: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _formatDate(loanRequest.firstInstallmentDate),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: ColorRes.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: AppSizes.fontSizeSm * 0.90,
                                  ),
                            ),
                            if (firstHijri?.isNotEmpty == true) ...[
                              const Sizer(height: 2),
                              Text(
                                firstHijri!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: ColorRes.grey2,
                                      fontSize: AppSizes.fontSizeSm * 0.78,
                                    ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Sizer(height: 16),

                /// needEmp badge  +  kafeel ID (when applicable)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: LoanInfoCell(
                        label: S.current.needsGuarantor,
                        valueWidget: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: LoanNeedEmpBadge(needEmp: loanRequest.needEmp),
                        ),
                      ),
                    ),
                    if (loanRequest.needEmp == true &&
                        loanRequest.kafeelId != null) ...[
                      const Sizer(width: 16),
                      Expanded(
                        child: LoanInfoCell(
                          label: 'رقم الكفيل',
                          value: loanRequest.kafeelId.toString(),
                        ),
                      ),
                    ],
                  ],
                ),
                const Sizer(height: 16),

                /// Edit reasons (shown when not null/empty)
                if (loanRequest.editReasons?.isNotEmpty == true) ...[
                  LoanInfoCell(
                    label: S.current.editReasons,
                    value: loanRequest.editReasons!,
                  ),
                  const Sizer(height: 16),
                ],

                /// Reject reasons (shown when not null/empty)
                if (loanRequest.rejectReasons?.isNotEmpty == true) ...[
                  LoanInfoCell(
                    label: S.current.rejectReasons,
                    value: loanRequest.rejectReasons!,
                  ),
                  const Sizer(height: 16),
                ],

                /// Installments table
                if (loanRequest.installments?.isNotEmpty == true) ...[
                  Text(
                    S.current.loanInstallments,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Sizer(height: 8),
                  LoanInstallmentsTable(
                    installments: loanRequest.installments!,
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String? iso) {
    if (iso == null || iso.isEmpty) return '';
    return iso.length >= 10 ? iso.substring(0, 10) : iso;
  }
}
