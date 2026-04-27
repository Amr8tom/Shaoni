import 'package:flutter/material.dart';

import '../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';

class HomeStatusBadge extends StatelessWidget {
  final Color statusColor;
  final String status;

  const HomeStatusBadge({
    super.key,
    required this.statusColor,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: Text(
            S.current.orderStatus + ":    ",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: ColorRes.black,
              fontSize: AppSizes.fontSizeSm * 0.70,
              fontWeight: FontWeight.w800,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        const Sizer(height: 2),

        /// Status Badge
        Flexible(
          flex: 2,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.padding / 2,
              // vertical: AppSizes.padding / 5,
            ),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.8),
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm),
            ),
            child: Center(
              child: Text(
                status,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: ColorRes.white,

                  fontSize: AppSizes.fontSizeSm * 0.7,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
