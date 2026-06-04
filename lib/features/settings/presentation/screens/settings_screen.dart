import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/extensions/navigation_extension.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../generated/l10n.dart';
import '../../../language/presentation/controller/language_cubit.dart';
import '../widgets/language_badge.dart';
import '../widgets/language_picker_sheet.dart';
import '../widgets/settings_tile.dart';
import '../widgets/title_setting_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.grey6,
      appBar: DAppBar(
        title: S.current.settings,
        showBackArrow: true,
        actions: const [],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.padding,
            vertical: AppSizes.padding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Section heading — "Account" group
              TitleSettingWidget(title: S.current.password),
              const Sizer(height: 8),

              /// Change Password → existing reset-password route
              SettingsTile(
                icon: Icons.lock_outline_rounded,
                title: S.current.password,
                subtitle: S.current.createNewPassword,
                onTap: () => context.pushNamed(DRoutesName.addNewPasswordRoute),
              ),

              const Sizer(height: 24),

              /// Section heading — "Preferences" group
              TitleSettingWidget(title: S.current.appLanguage),
              const Sizer(height: 8),

              /// Change App Language → bottom-sheet picker bound to
              /// the existing global LanguageCubit.
              BlocBuilder<LanguageCubit, LanguageState>(
                builder: (context, state) {
                  final cubit = context.read<LanguageCubit>();
                  final isArabic = cubit.currentLanguage.languageCode == 'ar';
                  return SettingsTile(
                    icon: Icons.language_rounded,
                    title: S.current.appLanguage,
                    subtitle: S.current.languageDes,
                    trailing: LanguageBadge(
                      label: isArabic ? S.current.arabic : S.current.english,
                    ),
                    onTap: () => showLanguagePickerSheet(context),
                  );
                },
              ),

              const Sizer(height: 24),

              /// Section heading — "Privacy" group
              TitleSettingWidget(title: S.current.privacyPolicy),
              const Sizer(height: 8),

              /// Privacy Policy → existing terms & conditions WebView route
              SettingsTile(
                icon: Icons.privacy_tip_outlined,
                title: S.current.privacyPolicy,
                onTap: () =>
                    context.pushNamed(DRoutesName.termsAndConditionRoute),
              ),

              const Sizer(height: 24),

              /// Section heading — "Danger zone"
              TitleSettingWidget(
                title: S.current.deleteAccount,
                color: ColorRes.error,
              ),
              const Sizer(height: 8),

              /// Delete Account → existing delete-account route
              SettingsTile(
                icon: Icons.delete_outline_rounded,
                title: S.current.deleteAccount,
                subtitle: S.current.deleteBody,
                isDestructive: true,
                onTap: () => context.pushNamed(DRoutesName.deleteAccountRoute),
              ),

              const Sizer(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
