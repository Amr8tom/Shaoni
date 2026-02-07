import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/colors.dart';
import '../../../generated/l10n.dart';

/// Widget that displays available features icons
class FeaturesPreviewWidget extends StatelessWidget {
  const FeaturesPreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.borderRadiusLg),
      decoration: BoxDecoration(
        color: ColorRes.white,
        borderRadius: BorderRadius.circular(AppSizes.md),
        boxShadow: [
          BoxShadow(
            color: ColorRes.primary.withOpacity(0.05),
            blurRadius: AppSizes.iconPadding,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            S.current.guestAccessTo,
            style: TextStyle(
              fontSize: AppSizes.fontSizeSm,
              color: ColorRes.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppSizes.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _FeatureIcon(
                icon: Icons.restaurant_menu,
                label: S.current.guestFeatureMeals,
              ),
              _FeatureIcon(
                icon: Icons.groups,
                label: S.current.guestFeatureGroups,
              ),
              _FeatureIcon(
                icon: Icons.home,
                label: S.current.guestFeatureResidence,
              ),
              _FeatureIcon(
                icon: Icons.event,
                label: S.current.guestFeatureActivities,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Private widget for feature icon with label
class _FeatureIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureIcon({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: AppSizes.containerSmall * 0.83, // ~50
          height: AppSizes.containerSmall * 0.83, // ~50
          decoration: BoxDecoration(
            color: ColorRes.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: ColorRes.primary,
            size: AppSizes.iconMd,
          ),
        ),
        SizedBox(height: AppSizes.sm),
        Text(
          label,
          style: TextStyle(
            fontSize: AppSizes.fontSizeSm * 0.75, // ~12
            color: ColorRes.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

