import 'package:flutter/material.dart';

import '../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';

class SideMenuItem extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;
  final bool isIcon;
  final IconData? iconData;

  const SideMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconData,
    this.isIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(AppSizes.padding / 2),
        child: Row(
          children: [
            const Sizer(width: 20),
            isIcon
                ? Icon(iconData,
                    color: ColorRes.primary, size: AppSizes.iconLg)
                : Image.asset(
                    icon,
                    color: ColorRes.primary,
                    width: AppSizes.iconLg,
                    height: AppSizes.iconLg,
                  ),
            const Sizer(width: 12),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(color: ColorRes.grey2),
            ),
          ],
        ),
      ),
    );
  }
}
