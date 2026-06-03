import 'package:flutter/material.dart';

import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../domain/entity/service.dart';
import 'service_visuals.dart';

/// Single row inside the "All HR Services" list.
///
/// Visuals:
///   - leading tinted icon container (color + glyph driven by [ServiceVisuals])
///   - localized name (Ar / En based on `S.current.localeee`)
///   - subtle subtitle showing the raw API code so power users can see
///     which endpoint they're targeting
///   - "Available" / "Coming Soon" status pill
///   - RTL-aware chevron
class ServiceRowCard extends StatelessWidget {
  const ServiceRowCard({
    super.key,
    required this.service,
    required this.onTap,
  });

  final Service service;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final visuals = ServiceVisuals.forCode(service.nameEn);
    final isArabic = S.current.localeee != 'en';

    /// Localized title — when Arabic locale is active prefer the Arabic
    /// name, otherwise fall back to the English code as a last resort.
    final title = isArabic
        ? (service.nameAr ?? service.nameEn ?? '')
        : (service.nameEn ?? service.nameAr ?? '');

    return Material(
      color: Colors.transparent,
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
                color: visuals.color.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              /// Leading icon container
              Container(
                width: AppSizes.iconLg * 1.5,
                height: AppSizes.iconLg * 1.5,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: visuals.color.withOpacity(0.10),
                  borderRadius:
                      BorderRadius.circular(AppSizes.borderRadiusMd),
                  border: Border.all(
                    color: visuals.color.withOpacity(0.20),
                    width: 1,
                  ),
                ),
                child: Icon(
                  visuals.icon,
                  color: visuals.color,
                  size: AppSizes.iconMd,
                ),
              ),
              const Sizer(width: 14),

              /// Title + subtitle
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
                            color: ColorRes.black,
                            fontWeight: FontWeight.w700,
                            fontSize: AppSizes.fontSizeSm,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Sizer(height: 4),
                    Row(
                      children: [
                        /// Status pill — green when implemented, neutral otherwise
                        _StatusPill(
                          label: visuals.isAvailable
                              ? S.current.available
                              : S.current.featureComingSoon,
                          color: visuals.isAvailable
                              ? ColorRes.success
                              : ColorRes.grey2,
                        ),
                        const Sizer(width: 6),
                        /// Code hint
                        Flexible(
                          child: Text(
                            service.nameEn ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: ColorRes.grey2,
                                  fontSize: AppSizes.fontSizeSm * 0.8,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Sizer(width: 8),

              /// Trailing chevron — RTL-aware
              Icon(
                Directionality.of(context) == TextDirection.rtl
                    ? Icons.arrow_back_ios_new_rounded
                    : Icons.arrow_forward_ios_rounded,
                size: AppSizes.iconSm,
                color: visuals.color.withOpacity(0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Tiny rounded pill used for "Available" / "Coming Soon" state.
class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm),
        border: Border.all(color: color.withOpacity(0.30), width: 1),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: AppSizes.fontSizeSm * 0.7,
            ),
      ),
    );
  }
}
