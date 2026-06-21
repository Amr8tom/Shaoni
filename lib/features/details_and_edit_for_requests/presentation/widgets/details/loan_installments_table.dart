import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../domain/entities/loan_installment.dart';
import 'loan_vertical_divider.dart';

class LoanInstallmentsTable extends StatelessWidget {
  final List<LoanInstallment> installments;
  const LoanInstallmentsTable({super.key, required this.installments});

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
          const LoanVerticalDivider(),
          cell(col2),
          const LoanVerticalDivider(),
          cell(col3),
          const LoanVerticalDivider(),
          cell('',
              child: col4Widget ??
                  Text(col4 ?? '',
                      textAlign: TextAlign.center, style: textStyle)),
        ],
      ),
    );
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
