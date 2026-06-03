import 'package:flutter/material.dart';

import '../../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../../core/constants/app_sizes.dart';
import '../../../../../../core/constants/colors.dart';

/// Read-only labelled tile used inside [AttendanceRequestDataWidget] to
/// display values returned by the API (check-in time from the record,
/// check-out time, in/out mode, fingerprint display name, etc.).
///
/// Layout:
///   [label]                                       (small grey text above)
///   ┌─────────────────────────────────────────┐
///   │  [icon]                       [value]   │  (white pill card)
///   └─────────────────────────────────────────┘
class AttendanceInfoTile extends StatelessWidget {
  const AttendanceInfoTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.iconColor,
    this.valueColor,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color? iconColor;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Tiny grey label above the pill — e.g. "وقت الحضور (من السجل)".
        Text(
          label,
          textAlign: TextAlign.end,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorRes.grey2,
                fontSize: AppSizes.fontSizeSm * 0.85,
                fontWeight: FontWeight.w600,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const Sizer(height: 6),

        /// White pill containing the icon + the value.
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.padding * 0.8,
            vertical: AppSizes.padding * 0.6,
          ),
          decoration: BoxDecoration(
            color: ColorRes.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
            border: Border.all(color: ColorRes.grey5, width: 1),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: AppSizes.iconSm,
                color: iconColor ?? ColorRes.primary,
              ),
              const Sizer(width: 8),
              Expanded(
                child: Text(
                  value,
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: valueColor ?? ColorRes.black,
                        fontWeight: FontWeight.w700,
                        fontSize: AppSizes.fontSizeSm,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
