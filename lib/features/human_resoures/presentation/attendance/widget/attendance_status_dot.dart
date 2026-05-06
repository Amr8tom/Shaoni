import 'package:flutter/material.dart';

import '../../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';

/// Small pill-style status indicator: a colored dot followed by a label.
///
/// Used inside the check-in / check-out / out-mode boxes to show
/// "تم التسجيل", "غير متاح", etc. The [color] is whatever palette token
/// fits the meaning (success / warning / grey).
class AttendanceStatusDot extends StatelessWidget {
  const AttendanceStatusDot({
    super.key,
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Colored dot
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const Sizer(width: 6),

        /// Label
        Flexible(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontSize: AppSizes.fontSizeSm*0.9,
                ),
          ),
        ),
      ],
    );
  }
}
