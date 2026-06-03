import 'package:flutter/material.dart';

import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import 'attendance_status_dot.dart';

/// Neutral grey box used for the secondary attendance info — checkout
/// and out-mode. Two of these sit side-by-side under the check-in box.
///
/// Renders:
///   [label]
///   [value or "غير محدد"]   ← status dot
///   [detail or "-"]
class AttendanceInfoBox extends StatelessWidget {
  const AttendanceInfoBox({
    super.key,
    required this.label,
    required this.value,
    required this.detail,
    required this.isAvailable,
  });

  final String label;
  final String value;
  final String detail;
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    final Color valueColor =
        isAvailable ? ColorRes.black : ColorRes.grey2;

    return Container(
      padding: EdgeInsets.all(AppSizes.padding * 0.9),
      height: AppSizes.fullHeight/5,
      decoration: BoxDecoration(
        color: ColorRes.grey6,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        border: Border.all(color: ColorRes.grey5, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Label
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorRes.black.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.fontSizeSm,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Sizer(height: 8),

          /// Value with status dot
          AttendanceStatusDot(
            label: value,
            color: isAvailable ? ColorRes.success : ColorRes.grey2,
          ),
          const Sizer(height: 6),

          /// Detail line (hijri remainder / dash for empty)
          Text(
            detail.substring(0,15),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: valueColor.withOpacity(0.8),
                  fontSize: AppSizes.fontSizeSm * 0.85,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
