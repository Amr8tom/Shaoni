import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';

import '../../../../generated/l10n.dart';

class RequestStageCard extends StatelessWidget {
  const RequestStageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.padding),
      child: Container(
        padding: EdgeInsets.all(AppSizes.padding),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.requestStage,
              style: Theme.of(context).textTheme.titleSmall
            ),
            Divider(color: ColorRes.grey4),

            const Sizer(height: 24),
            _StepItem(title: S.current.NNew, isLast: false),
            _StepItem(title: S.current.managerApproval, isLast: false,isDotLine: true,),
            _StepItem(
              title: S.current.hrManagerApproval,
              isCompleted: false,
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final bool isLast;
  final bool isDotLine;

  const _StepItem({
    required this.title,
    this.isCompleted = true,
    required this.isLast,
     this.isDotLine=false,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = Colors.teal;
    final inactiveColor = Colors.grey.shade400;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Timeline
        Column(
          children: [
            Container(
              width: AppSizes.iconLg,
              height: AppSizes.iconLg,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCompleted ? activeColor : inactiveColor,
                  width: 3,
                ),
              ),
              child: Center(
                child: Container(
                  width: AppSizes.iconSm,
                  height: AppSizes.iconSm,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted ? activeColor : Colors.transparent,
                  ),
                ),
              ),
            ),
            if (!isLast)
              Dash(
                direction: Axis.vertical,
                length: AppSizes.iconXLarge,
                dashLength: 2,
                dashGap: isDotLine ? AppSizes.xs :0 ,
                dashThickness: 2,
                dashColor: isCompleted ? activeColor : inactiveColor,
              ),
            // Container(
            //   width: 1,
            //   height: AppSizes.iconXLarge,
            //   color: isCompleted ? activeColor : inactiveColor,
            // ),
          ],
        ),
        Sizer(width: 10),

        /// Text
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: isLast ? ColorRes.grey : ColorRes.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
