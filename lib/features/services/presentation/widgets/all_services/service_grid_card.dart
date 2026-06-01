import 'package:flutter/material.dart';

import '../../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../domain/entity/service.dart';
import 'service_visuals.dart';

class ServiceGridCard extends StatelessWidget {
  const ServiceGridCard({
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
    final title = isArabic
        ? (service.nameAr ?? service.nameEn ?? '')
        : (service.nameEn ?? service.nameAr ?? '');

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        child: Container(
          width: double.infinity,
          height: AppSizes.heightcontainer * 1.2,
          decoration: BoxDecoration(
            color: ColorRes.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
            border: Border.all(color: ColorRes.grey5, width: 1),
            boxShadow: [
              BoxShadow(
                color: visuals.color.withValues(alpha: 0.06),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Sizer(height: 6),

              /// Big tinted icon — the focal point of each tile.
              Flexible(
                flex: 2,
                child: Center(
                  child: Container(
                    width: AppSizes.iconXLarge * 1.7,
                    height: AppSizes.iconXLarge * 1.7,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: visuals.color.withValues(alpha: 0.12),
                      borderRadius:
                          BorderRadius.circular(AppSizes.borderRadiusLg),
                      border: Border.all(
                        color: visuals.color.withValues(alpha: 0.25),
                        width: 1.5,
                      ),
                    ),
                    child: Icon(
                      visuals.icon,
                      color: visuals.color,
                      size: AppSizes.iconXLarge,
                    ),
                  ),
                ),
              ),

              /// Localized title — bold, centered, max 2 lines.
              Flexible(
                flex: 1,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppSizes.padding / 2),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: ColorRes.black,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
