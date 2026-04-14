import 'package:flutter/material.dart';
import 'package:shaoni/core/constants/colors.dart';
import '../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/buttons/d_button.dart';
import '../../../../generated/l10n.dart';

class SplashLanguageSection extends StatelessWidget {
  const SplashLanguageSection({super.key, required this.onLanguageSelected});

  final Function(String) onLanguageSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.padding * 2),
      child: ListView(
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              children: [
                Expanded(
                  child: DButton(
                    borderRadius: AppSizes.borderRadiusXXLg,
                    height: AppSizes.heightcontainer,
                    text: S.current.languageEnglish,
                    onPressed: () => onLanguageSelected('en'),
                    variant: DButtonVariant.secondary,
                    size: DButtonSize.medium,
                  ),
                ),
                const Sizer(width: 8),
                Expanded(
                  child: DButton(
                    borderRadius: AppSizes.borderRadiusXXLg,
                    height: AppSizes.heightcontainer,
                    text: S.current.languageArabic,
                    onPressed: () => onLanguageSelected('ar'),
                    variant: DButtonVariant.primary,
                    size: DButtonSize.medium,
                    useShadow: true,
                  ),
                ),

              ],
            ),
          ),
          Sizer(width: double.infinity, height: AppSizes.fullHeight / 16),
          Center(
            child: Text(
              S.current.designDevelopment,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorRes.black,
              ),
            ),
          ),
          const Sizer(height: 2),
          Center(
            child: Text(
              S.current.ejad,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorRes.black,
              ),
            ),
          ),
          const Sizer(height: 16),
        ],
      ),
    );
  }
}
