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
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 2,
          child: Text(
            "${title}: ",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: ColorRes.black,
                  fontSize: AppSizes.fontSizeSm * 0.80,
                  fontWeight: FontWeight.w800,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Sizer(width: 4),
        Flexible(
          flex: 2,
          child: Text(
            result,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorRes.grey,
                  fontSize: AppSizes.fontSizeSm * 0.86,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
