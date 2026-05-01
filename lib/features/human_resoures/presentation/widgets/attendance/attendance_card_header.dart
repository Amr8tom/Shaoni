import 'package:flutter/material.dart';

import '../../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';

/// Top teal banner of the attendance card.
///
/// Layout:
///   [employee pill]        [title]
///                          [date row with calendar icon]
class AttendanceCardHeader extends StatelessWidget {
  const AttendanceCardHeader({
    super.key,
    required this.title,
    required this.employeeName,
  });

  final String title;
  final String employeeName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.padding,
        vertical: AppSizes.padding,
      ),
      decoration: BoxDecoration(
        color: ColorRes.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.borderRadiusLg),
          topRight: Radius.circular(AppSizes.borderRadiusLg),
        ),
      ),
      child: Row(
        children: [

          /// Employee pill — white-translucent badge with person icon
          _EmployeePill(name: employeeName),

          const Spacer(),

          /// Title + date stacked on the right
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorRes.white,
                      fontWeight: FontWeight.w700,
                      fontSize: AppSizes.fontSizeMd,
                    ),
              ),
              const Sizer(height: 4),
            ],
          ),
          const Sizer(width: 8,),
          Icon(
            Icons.calendar_today_rounded,
            color: ColorRes.white.withOpacity(0.9),
            size: AppSizes.iconMd,
          ),
        ],
      ),
    );
  }
}

/// Translucent white pill used for the employee name in the header.
class _EmployeePill extends StatelessWidget {
  const _EmployeePill({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.sm * 1.2,
        vertical: AppSizes.xs,
      ),
      decoration: BoxDecoration(
        color: ColorRes.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        border: Border.all(
          color: ColorRes.white.withOpacity(0.30),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorRes.white,
                  fontWeight: FontWeight.w700,
                  fontSize: AppSizes.fontSizeSm,
                ),
          ),
          const Sizer(width: 6),
          Icon(
            Icons.person_rounded,
            color: ColorRes.white,
            size: AppSizes.iconSm,
          ),
        ],
      ),
    );
  }
}
