import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../generated/l10n.dart';

/// Generic Yes/No state badge — same visual style as [LoanNeedEmpBadge],
/// reusable across any feature that needs to render a boolean flag
/// (kafala, tabaq, etc.) as a colored chip instead of plain text.
class YesNoBadge extends StatelessWidget {
  final bool? value;
  const YesNoBadge({super.key, this.value});

  @override
  Widget build(BuildContext context) {
    final isYes = value == true;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color:
            isYes ? ColorRes.staticBlueColor.withOpacity(0.12) : ColorRes.grey5,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
        border: Border.all(
          color: isYes
              ? ColorRes.staticBlueColor.withOpacity(0.4)
              : ColorRes.greyForBorders,
        ),
      ),
      child: Text(
        isYes ? S.current.yes : S.current.no,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isYes ? ColorRes.staticBlueColor : ColorRes.grey2,
              fontWeight: FontWeight.w600,
              fontSize: AppSizes.fontSizeSm * 0.82,
            ),
      ),
    );
  }
}

/// Solid colored chip for short type labels (e.g. request type "تجديد").
class TypeBadge extends StatelessWidget {
  final String label;
  const TypeBadge({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: ColorRes.staticBlueColor,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: ColorRes.white,
              fontWeight: FontWeight.w700,
              fontSize: AppSizes.fontSizeSm * 0.82,
            ),
      ),
    );
  }
}
