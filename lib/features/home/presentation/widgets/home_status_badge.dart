import 'package:flutter/material.dart';

import '../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';

class HomeStatusBadge extends StatelessWidget {
  final Color statusColor;
  final String status;
  const HomeStatusBadge({super.key, required this.statusColor, required this.status});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Text(
          S.current.orderStatus+":    ",
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: ColorRes.black,
            fontSize: AppSizes.fontSizeSm*0.8,
            fontWeight: FontWeight.w800,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const Sizer(height: 2),
        /// Status Badge
        Container(
          padding:  EdgeInsets.symmetric(horizontal:AppSizes.padding/2 , vertical: AppSizes.padding/5),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          ),
          child: Text(
            status,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: ColorRes.white,fontSize:
            AppSizes.fontSizeSm*0.8),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
