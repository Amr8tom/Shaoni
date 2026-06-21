import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../generated/l10n.dart';

class LoanNeedEmpBadge extends StatelessWidget {
  final bool? needEmp;
  const LoanNeedEmpBadge({super.key, this.needEmp});

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
