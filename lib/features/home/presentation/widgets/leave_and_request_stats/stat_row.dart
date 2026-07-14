import 'package:flutter/material.dart';
import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';

class StatRow extends StatelessWidget {
  const StatRow({
    super.key,
    required this.label,
    required this.value,
    required this.dotColor,
  });

  final String label;
  final String value;
  final Color dotColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizes.padding * 0.5),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              const Sizer(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorRes.grey2,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Spacer(),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorRes.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
              ),
            ],
          ),
        ),
        Divider(
          color: ColorRes.grey.withValues(alpha: 0.1),
          height: 1,
        ),
      ],
    );
  }
}
