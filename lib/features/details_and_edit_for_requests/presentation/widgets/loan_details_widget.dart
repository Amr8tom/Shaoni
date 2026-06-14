import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/order_text_card.dart';
import '../../domain/entities/loan_installment.dart';
import '../controller/my_requests_cubit.dart';

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
                  OrderTextCard(
                    title: S.current.odooRequestNumber,
                    result: loanRequest.externalName!,
                  ),
                  const Sizer(height: 12),
                ],

                /// Loan type + amount
                Row(
                  children: [
                    Expanded(
                      child: OrderTextCard(
                        title: S.current.loanType,
                        result: loanRequest.loanTypeName ?? '',
                      ),
                    ),
                    const Sizer(width: 10),
                    Expanded(
                      child: OrderTextCard(
                        title: S.current.loanAmount,
                        result: loanRequest.loanRequestAmount?.toString() ?? '',
                      ),
                    ),
                  ],
                ),
                const Sizer(height: 12),

                /// Payment period + first installment date
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: OrderTextCard(
                        title: S.current.loanPaymentPeriod,
                        result: loanRequest.loanPaymentPeriod?.toString() ?? '',
                      ),
                    ),
                    const Sizer(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OrderTextCard(
                            title: S.current.firstInstallmentDate,
                            result:
                                _formatDate(loanRequest.firstInstallmentDate),
                          ),
                          if (firstHijri?.isNotEmpty == true) ...[
                            const Sizer(height: 2),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppSizes.padding / 3),
                              child: Text(
                                firstHijri!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: ColorRes.grey2,
                                      fontSize: AppSizes.fontSizeSm * 0.78,
                                    ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                const Sizer(height: 12),

                /// needEmp badge
                Row(
                  children: [
                    Text(
                      '${S.current.needsGuarantor}: ',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: ColorRes.black,
                            fontSize: AppSizes.fontSizeSm * 0.80,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const Sizer(width: 6),
                    _NeedEmpBadge(needEmp: loanRequest.needEmp),
                  ],
                ),
                const Sizer(height: 16),

                /// Installments table
                if (loanRequest.installments?.isNotEmpty == true) ...[
                  Text(
                    S.current.loanInstallments,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Sizer(height: 8),
                  _InstallmentsTable(
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

// ---------------------------------------------------------------------------
// needEmp badge
// ---------------------------------------------------------------------------
class _NeedEmpBadge extends StatelessWidget {
  final bool? needEmp;
  const _NeedEmpBadge({this.needEmp});

  @override
  Widget build(BuildContext context) {
    final isNeeded = needEmp == true;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isNeeded
            ? ColorRes.staticBlueColor.withOpacity(0.12)
            : ColorRes.grey5,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
        border: Border.all(
          color: isNeeded
              ? ColorRes.staticBlueColor.withOpacity(0.4)
              : ColorRes.greyForBorders,
        ),
      ),
      child: Text(
        isNeeded ? S.current.yes : S.current.no,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isNeeded ? ColorRes.staticBlueColor : ColorRes.grey2,
              fontWeight: FontWeight.w600,
              fontSize: AppSizes.fontSizeSm * 0.82,
            ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Installments table
// ---------------------------------------------------------------------------
class _InstallmentsTable extends StatelessWidget {
  final List<LoanInstallment> installments;
  const _InstallmentsTable({required this.installments});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorRes.greyForBorders),
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          /// Header row
          _TableRow(
            isHeader: true,
            col1: S.current.gregorianDateHeader,
            col2: S.current.hijriDateHeader,
            col3: S.current.installmentAmount,
            col4: S.current.status,
          ),

          /// Data rows
          ...installments.asMap().entries.map((entry) {
            final idx = entry.key;
            final inst = entry.value;
            return _TableRow(
              isHeader: false,
              isEven: idx.isEven,
              col1: _formatDate(inst.installmentDate),
              col2: inst.hijriDate ?? '',
              col3: inst.installmentAmount?.toStringAsFixed(2) ?? '',
              col4Widget: _StatusChip(status: inst.status),
            );
          }),
        ],
      ),
    );
  }

  String _formatDate(String? iso) {
    if (iso == null || iso.isEmpty) return '';
    return iso.length >= 10 ? iso.substring(0, 10) : iso;
  }
}

class _TableRow extends StatelessWidget {
  final bool isHeader;
  final bool isEven;
  final String col1;
  final String col2;
  final String col3;
  final String? col4;
  final Widget? col4Widget;

  const _TableRow({
    required this.isHeader,
    this.isEven = false,
    this.col1 = '',
    this.col2 = '',
    this.col3 = '',
    this.col4,
    this.col4Widget,
  });

  @override
  Widget build(BuildContext context) {
    final bg =
        isHeader ? ColorRes.grey4 : (isEven ? ColorRes.white : ColorRes.grey6);

    final textStyle = isHeader
        ? Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorRes.black,
              fontSize: AppSizes.fontSizeSm * 0.78,
            )
        : Theme.of(context).textTheme.bodySmall?.copyWith(
              color: ColorRes.grey2,
              fontSize: AppSizes.fontSizeSm * 0.78,
            );

    Widget cell(String text, {Widget? child}) => Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
            child: child ??
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: textStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
          ),
        );

    return Container(
      color: bg,
      child: Row(
        children: [
          cell(col1),
          _VerticalDivider(),
          cell(col2),
          _VerticalDivider(),
          cell(col3),
          _VerticalDivider(),
          cell('',
              child: col4Widget ??
                  Text(col4 ?? '',
                      textAlign: TextAlign.center, style: textStyle)),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 36.h, color: ColorRes.greyForBorders);
  }
}

class _StatusChip extends StatelessWidget {
  final String? status;
  const _StatusChip({this.status});

  @override
  Widget build(BuildContext context) {
    final isPaid = status == 'paid';
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
        decoration: BoxDecoration(
          color: isPaid
              ? ColorRes.green.withOpacity(0.12)
              : ColorRes.red.withOpacity(0.12),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isPaid
                ? ColorRes.green.withOpacity(0.4)
                : ColorRes.red.withOpacity(0.4),
          ),
        ),
        child: Text(
          isPaid ? S.current.paid : S.current.notPaid,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isPaid ? ColorRes.green : ColorRes.red,
                fontWeight: FontWeight.w600,
                fontSize: AppSizes.fontSizeSm * 0.72,
              ),
        ),
      ),
    );
  }
}
