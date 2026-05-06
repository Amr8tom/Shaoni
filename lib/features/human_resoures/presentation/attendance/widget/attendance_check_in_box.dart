import 'package:flutter/material.dart';

import '../../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../generated/l10n.dart';
import 'attendance_status_dot.dart';

/// Featured "check-in" box inside the attendance card.
///
/// Soft primary tint with a primary border, contains:
///   - "تسجيل الدخول – CHECKIN" label
///   - Time + gregorian date row
///   - Hijri date with calendar icon
///   - Status dot ("تم التسجيل" / "لم يتم")
class AttendanceCheckInBox extends StatelessWidget {
  const AttendanceCheckInBox({
    super.key,
    required this.time,
    required this.gregorianDate,
    required this.hijriDate,
    required this.isCheckedIn,
  });

  final String? time;
  final String gregorianDate;
  final String hijriDate;
  final bool isCheckedIn;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.padding,vertical:AppSizes.padding/1.5),
      height: AppSizes.fullHeight/5,
      decoration: BoxDecoration(
        color: ColorRes.primary.withOpacity(0.06),
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        border: Border.all(
          color: ColorRes.primary.withOpacity(0.25),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Label
          Text(
            S.current.checkIn,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorRes.black.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.fontSizeSm,
                ),
          ),

          /// Time + gregorian date
          Text(
            time ?? '—',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: ColorRes.primary,
                  fontWeight: FontWeight.w800,
                ),
          ),

          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: ColorRes.grey2,
              shape: BoxShape.circle,
            ),
          ),
          Text(
            gregorianDate.substring(0, 10),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: ColorRes.black,
                  fontWeight: FontWeight.w700,
                ),
          ),

          const Sizer(height: 6),

          /// Hijri date row
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.calendar_month_rounded,
                color: ColorRes.grey2,
                size: AppSizes.iconSm,
              ),
              const Sizer(width: 6),
              Flexible(
                child: Text(
                  hijriDate,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorRes.grey2,
                        fontSize: AppSizes.fontSizeSm,
                      ),
                  maxLines: 2,
                ),
              ),
            ],
          ),
          const Sizer(height: 12),

          /// Status dot
          AttendanceStatusDot(
            label: isCheckedIn ? S.current.checkedIn : S.current.notCheckedIn,
            color: isCheckedIn ? ColorRes.success : ColorRes.grey2,
          ),
        ],
      ),
    );
  }
}
