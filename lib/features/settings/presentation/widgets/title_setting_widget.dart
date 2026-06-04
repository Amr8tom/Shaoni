import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';

class TitleSettingWidget extends StatelessWidget {
  final String title;
  final Color? color;
  const TitleSettingWidget({super.key, required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: AppSizes.xs, right: AppSizes.xs),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: color ?? ColorRes.grey2,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
      ),
    );
  }
}
