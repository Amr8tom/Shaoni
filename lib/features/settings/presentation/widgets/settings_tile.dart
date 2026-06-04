import 'package:flutter/material.dart';

import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';

/// A reusable modern settings row used inside [SettingsScreen].
///
/// It renders a clean white card with:
/// - a soft, primary-tinted icon container on the leading side
/// - a title (bold) + optional subtitle / description
/// - an optional trailing widget (chevron by default, or a value chip
///   for items like "App Language" → "English")
///
/// The [isDestructive] flag re-skins the tile in the app's [ColorRes.error]
/// palette to clearly mark dangerous actions (e.g. Delete Account).
class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.trailing,
    this.isDestructive = false,
  });

  /// Leading icon (uses Material icons to match the existing drawer items
  /// like `Icons.security` and `Icons.logout_outlined`).
  final IconData icon;

  /// Localized title (e.g. `S.current.password`).
  final String title;

  /// Optional localized helper line below the title.
  final String? subtitle;

  /// Optional trailing widget. Defaults to a chevron arrow.
  final Widget? trailing;

  /// Action when the tile is tapped.
  final VoidCallback onTap;

  /// When `true`, paints the tile in the error palette.
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    /// Pull the accent color once so primary / destructive variants share
    /// the exact same layout / sizing.
    final Color accent = isDestructive ? ColorRes.error : ColorRes.primary;

    return Material(
      color: ColorRes.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.padding,
            vertical: AppSizes.padding * 0.9,
          ),
          decoration: BoxDecoration(
            color: ColorRes.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
            border: Border.all(color: ColorRes.grey5, width: 1),
            boxShadow: [
              BoxShadow(
                color: ColorRes.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              /// Leading icon container — soft tinted background of [accent]
              Container(
                width: AppSizes.iconLg * 1.4,
                height: AppSizes.iconLg * 1.4,
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
                ),
                child: Icon(icon, color: accent, size: AppSizes.iconMd),
              ),
              const Sizer(width: 14),

              /// Title + optional subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                            color:
                                isDestructive ? ColorRes.error : ColorRes.black,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    if (subtitle != null) ...[
                      const Sizer(height: 4),
                      Text(
                        subtitle!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: ColorRes.grey2),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              const Sizer(width: 8),

              /// Trailing — chevron by default
              trailing ??
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: AppSizes.iconSm,
                    color: ColorRes.grey2,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
