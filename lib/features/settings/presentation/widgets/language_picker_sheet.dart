import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/extentions/navigation_extension.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../generated/l10n.dart';
import '../../../language/presentation/controller/language_cubit.dart';

/// Shows a modal bottom sheet that lets the user switch the app language
/// between Arabic and English.
///
/// It hooks into the existing global [LanguageCubit] (registered in
/// `main.dart`) so the change is persisted via `CacheHelper` and the entire
/// `MaterialApp` rebuilds with the new locale (same mechanism used by the
/// drawer dropdown today).
Future<void> showLanguagePickerSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: ColorRes.transparent,
    isScrollControlled: true,
    builder: (_) => const _LanguagePickerSheet(),
  );
}

class _LanguagePickerSheet extends StatelessWidget {
  const _LanguagePickerSheet();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        final cubit = context.read<LanguageCubit>();
        final currentCode = cubit.currentLanguage.languageCode;

        return Container(
          decoration: BoxDecoration(
            color: ColorRes.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSizes.borderRadiusXXLg),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.padding,
            vertical: AppSizes.padding,
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// Drag handle (subtle pill at the top of the sheet)
                Center(
                  child: Container(
                    width: 48,
                    height: 4,
                    decoration: BoxDecoration(
                      color: ColorRes.grey5,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const Sizer(height: 16),

                /// Sheet title
                Text(
                  S.current.selectLanguage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: ColorRes.black,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const Sizer(height: 16),

                /// English option
                _LanguageOption(
                  code: 'en',
                  label: S.current.english,
                  flagEmoji: '🇺🇸',
                  isSelected: currentCode == 'en',
                  onTap: () => _selectLanguage(context, 'en'),
                ),
                const Sizer(height: 12),

                /// Arabic option
                _LanguageOption(
                  code: 'ar',
                  label: S.current.arabic,
                  flagEmoji: '🇸🇦',
                  isSelected: currentCode == 'ar',
                  onTap: () => _selectLanguage(context, 'ar'),
                ),
                const Sizer(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Persists the choice through [LanguageCubit] and reboots the navigation
  /// stack so the whole UI picks up the new locale (same pattern used by
  /// `CustomSideMenu`'s dropdown).
  void _selectLanguage(BuildContext context, String code) {
    final cubit = context.read<LanguageCubit>();
    if (cubit.currentLanguage.languageCode == code) {
      Navigator.of(context).pop();
      return;
    }
    cubit.changeLanguage(code);
    Navigator.of(context).pop();
    context.pushReplacementNamed(DRoutesName.navigationMenuRoute);
  }
}

/// A single language card inside [_LanguagePickerSheet].
class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.code,
    required this.label,
    required this.flagEmoji,
    required this.isSelected,
    required this.onTap,
  });

  final String code;
  final String label;
  final String flagEmoji;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorRes.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.padding,
            vertical: AppSizes.padding * 0.9,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? ColorRes.primary.withOpacity(0.08)
                : ColorRes.grey6,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
            border: Border.all(
              color: isSelected ? ColorRes.primary : ColorRes.grey5,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              /// Flag bubble
              Container(
                width: AppSizes.iconLg * 1.2,
                height: AppSizes.iconLg * 1.2,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorRes.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorRes.grey5, width: 1),
                ),
                child: Text(flagEmoji, style: const TextStyle(fontSize: 20)),
              ),
              const Sizer(width: 14),

              /// Label
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorRes.black,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                ),
              ),

              /// Selection indicator
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: isSelected
                    ? Icon(
                        Icons.check_circle_rounded,
                        key: const ValueKey('selected'),
                        color: ColorRes.primary,
                        size: AppSizes.iconLg,
                      )
                    : Icon(
                        Icons.radio_button_unchecked_rounded,
                        key: const ValueKey('unselected'),
                        color: ColorRes.grey2,
                        size: AppSizes.iconLg,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
