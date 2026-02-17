import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/asset_resoures.dart';
import '../../../../core/constants/colors.dart';
import '../../domain/entities/notification_entity.dart';

class NotificationCard extends StatelessWidget {
  final NotificationEntity notification;
  final bool isExpanded;
  final VoidCallback onTap;

  const NotificationCard({
    required this.notification,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.padding),
      child: Container(
        decoration: BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          boxShadow: [
            BoxShadow(
              color: ColorRes.grey.withOpacity(0.2),
              blurRadius: AppSizes.xs,
              offset: Offset(0, AppSizes.xs / 2),
            ),
          ],
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            expansionTileTheme: ExpansionTileThemeData(
              tilePadding: EdgeInsets.all(AppSizes.padding),
              childrenPadding: EdgeInsets.zero,
            ),
          ),
          child: ExpansionTile(
            leading: Container(
              height: AppSizes.heightcontainer * 2,
              padding: EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: ColorRes.primary,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                AssetRes.notificationIcon,
                width: AppSizes.iconSmall,
                height: AppSizes.iconSmall,
              ),
            ),
            // key: ValueKey('expansion_tile_$index\_${state.expandedIndex}'),
            initiallyExpanded: isExpanded,
            onExpansionChanged: (expanded) {
              // controller.setExpandedIndex(expanded ? index : null);
            },
            tilePadding: EdgeInsets.symmetric(
              horizontal: AppSizes.md,
              vertical: AppSizes.sm / 2,
            ),
            title: Text(
              // questions[index].question,
              notification.title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: isExpanded ? ColorRes.primary : ColorRes.black,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              maxLines: 2,
            ),
            trailing: Container(
              width: AppSizes.iconMd,
              height: AppSizes.iconMd,
              padding: EdgeInsets.all(AppSizes.xs / 1.5),
              decoration: BoxDecoration(
                color: ColorRes.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm),
              ),

              child: Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down_outlined,
                color: ColorRes.black,
                size: AppSizes.iconMd,
              ),
            ),
            iconColor: Colors.transparent,
            collapsedIconColor: Colors.transparent,
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(AppSizes.sm),
                padding: EdgeInsets.all(AppSizes.md),

                child: Text(
                  notification.description,
                  // questions[index].answer,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorRes.black,
                    height: 1.5,
                    fontSize: 13,
                  ),
                  maxLines: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
