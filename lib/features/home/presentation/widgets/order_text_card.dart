import 'package:flutter/material.dart';

import '../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';

class OrderTextCard extends StatelessWidget {
  final String title;
  final String result;
  const OrderTextCard({super.key, required this.title, required this.result});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          title+ ":    ",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: ColorRes.black,
            fontSize: AppSizes.fontSizeSm*0.74,
            fontWeight: FontWeight.w800,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const Sizer(height: 2),

        Text(
          result ,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: ColorRes.grey),
        ),
      ],
    );
  }
}
