import 'package:flutter/material.dart';

import '../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';

class LanguageBadge extends StatelessWidget {
  final String label;

  const LanguageBadge({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.sm * 1.2,
        vertical: AppSizes.xs,
      ),
      decoration: BoxDecoration(
        color: ColorRes.primary.withOpacity(0.10),
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusXXLg),
        border: Border.all(
          color: ColorRes.primary.withOpacity(0.30),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ColorRes.primary,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const Sizer(width: 4),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: AppSizes.iconXs,
            color: ColorRes.primary,
          ),
        ],
      ),
    );
  }
}
