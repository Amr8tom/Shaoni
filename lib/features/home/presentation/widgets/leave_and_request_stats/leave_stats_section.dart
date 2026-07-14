import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../generated/l10n.dart';
import '../attendance_stats/attendance_stat_ring.dart';
import 'stat_row.dart';

class LeaveStatsSection extends StatelessWidget {
  const LeaveStatsSection({
    super.key,
    this.totalAnnualLeaves = 80,
    this.remainingLeaves = 80,
    this.takenLeaves = 0,
  });

  final int totalAnnualLeaves;
  final int remainingLeaves;
  final int takenLeaves;

  @override
  Widget build(BuildContext context) {
    final isAr = S.current.localeee == 'ar';

    return AnimationLimiter(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(AppSizes.padding),
        decoration: BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
          border:
              Border.all(color: ColorRes.grey.withValues(alpha: 0.1), width: 1),
          boxShadow: [
            BoxShadow(
              color: ColorRes.black.withValues(alpha: 0.03),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              Text(
                isAr ? "اجازاتي" : "My Leaves",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: ColorRes.black,
                      fontSize: AppSizes.fontSizeMd,
                    ),
              ),
              const Sizer(height: 8),
              Divider(color: ColorRes.grey.withValues(alpha: 0.1)),
              const Sizer(height: 16),
              Center(
                child: AttendanceStatRing(
                  color: ColorRes.staticVioletColor,
                  progress: totalAnnualLeaves > 0
                      ? (remainingLeaves / totalAnnualLeaves)
                      : 0,
                  size: 160,
                  strokeWidth: 14,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isAr ? "رصيد الاجازات السنوية" : "Annual Leave Balance",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: ColorRes.grey2,
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                      ),
                      const Sizer(height: 6),
                      Text(
                        remainingLeaves.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: ColorRes.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 28,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const Sizer(height: 32),
              StatRow(
                label: isAr ? "الاجازات المتبقية" : "Remaining Leaves",
                value: isAr ? "$remainingLeaves يوم" : "$remainingLeaves Days",
                dotColor: ColorRes.staticVioletColor,
              ),
              StatRow(
                label: isAr ? "الاجازات التي تم اخذها" : "Taken Leaves",
                value: isAr ? "$takenLeaves يوم" : "$takenLeaves Days",
                dotColor: ColorRes.staticBlueColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
