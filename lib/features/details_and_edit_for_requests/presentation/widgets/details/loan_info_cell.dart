import 'package:flutter/material.dart';
import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';

class LoanInfoCell extends StatelessWidget {
  final String label;
  final String value;
  final Widget? valueWidget;

  const LoanInfoCell({
    super.key,
    required this.label,
    this.value = '',
    this.valueWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: ColorRes.grey2,
                fontSize: AppSizes.fontSizeSm * 0.80,
                fontWeight: FontWeight.w600,
              ),
        ),
        const Sizer(height: 4),
        valueWidget ??
            Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorRes.black,
                    fontWeight: FontWeight.w700,
                    fontSize: AppSizes.fontSizeSm * 0.90,
                  ),
            ),
      ],
    );
  }
}
