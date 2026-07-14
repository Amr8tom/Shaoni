import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../generated/l10n.dart';
import 'stat_row.dart';

class RequestStatsSection extends StatelessWidget {
  const RequestStatsSection({
    super.key,
    this.totalRequests = 15,
    this.approvedCount = 1,
    this.rejectedCount = 0,
    this.pendingCount = 14,
  });

  final int totalRequests;
  final int approvedCount;
  final int rejectedCount;
  final int pendingCount;

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
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    totalRequests.toString(),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: ColorRes.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 32,
                        ),
                  ),
                  const Sizer(width: 12),
                  Text(
                    isAr ? "اجمالي الطلبات" : "Total Requests",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: ColorRes.grey2,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
              const Sizer(height: 12),
              Divider(color: ColorRes.grey.withValues(alpha: 0.1)),
              const Sizer(height: 16),
              StatRow(
                label: isAr ? "معتمد" : "Approved",
                value: approvedCount.toString(),
                dotColor: ColorRes.staticGreenColor,
              ),
              StatRow(
                label: isAr ? "مرفوض" : "Rejected",
                value: rejectedCount.toString(),
                dotColor: ColorRes.staticRedColor,
              ),
              StatRow(
                label: isAr ? "قيد المعالجة" : "Under Processing",
                value: pendingCount.toString(),
                dotColor: ColorRes.staticYellowColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
