import 'package:flutter/material.dart';
import 'package:shaoni/core/local_storage/cache_keys.dart';
import '../../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/local_storage/cache_helper.dart';
import '../../../../../generated/l10n.dart';
import '../../../../auth/presentation/widgets/auth_text_filed.dart';

class ApplicantDataWidget extends StatelessWidget {
  final bool useEnhancedDesign;

  const ApplicantDataWidget({
    super.key,
    this.useEnhancedDesign = false,
  });
  @override
  Widget build(BuildContext context) {

    if (useEnhancedDesign) {
      return _buildEnhancedDesign(context);
    }
    return _buildDefaultDesign(context);
  }

  /// Enhanced card design matching the screenshot
  Widget _buildEnhancedDesign(BuildContext context) {
    final userName = CacheHelper.getString(key: CacheKeys.userName)??'';
    final orgName = CacheHelper.getString(key: CacheKeys.organizationName)??'';
    final location = CacheHelper.getString(key: CacheKeys.departmentAddress)??'';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        Text(
          S.current.requestApplicantData,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: ColorRes.black,
            fontSize: 20,
          ),
          textAlign: TextAlign.right,
        ),
        const Sizer(height: 20),

        /// Employee Card with light cyan background
        _buildApplicantCardWithBackground(
          context: context,
          title: S.current.applicantName,
          value: userName,
          icon: Icons.person_rounded,
          iconBgColor: ColorRes.primary,
          cardBgColor: const Color(0xFFE0F4F1),
          isFirstCard: true,
        ),

        Row(
          children: [
            Flexible(
              flex: 2,
              child: _buildApplicantCardWithBackground(
                context: context,
                title: S.current.organizationalUnit,
                value: orgName,
                icon: Icons.home_work_rounded,
                iconBgColor: ColorRes.primary,
                cardBgColor: Colors.white,
                isFirstCard: false,
              ),
            ),

            /// Location Card
            Flexible(
              flex: 1,
              child: _buildApplicantCardWithBackground(
                context: context,
                title: S.current.location,
                value: location,
                icon: Icons.work_outline_rounded,
                iconBgColor: ColorRes.primary,
                cardBgColor: Colors.white,
                isFirstCard: false,
              ),
            ),
          ],
        ),
        /// Organization Card

      ],
    );
  }

  /// Helper to build individual applicant card with background
  Widget _buildApplicantCardWithBackground({
    required BuildContext context,
    required String title,
    required String value,
    required IconData icon,
    required Color iconBgColor,
    required Color cardBgColor,
    required bool isFirstCard,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: isFirstCard
          ? Border.all(color: ColorRes.primary.withValues(alpha: 0.2), width: 1)
          : Border.all(color: ColorRes.grey2.withValues(alpha: 0.1), width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.padding/2,
          vertical: AppSizes.padding/2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /// Icon with background
            Container(
              width: AppSizes.iconXLarge,
              height: AppSizes.iconXLarge,
              decoration: BoxDecoration(
                color: iconBgColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppSizes.blurSmall),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: iconBgColor,
                  size: AppSizes.iconMedium,
                ),
              ),
            ),
            const Sizer(width: 8),
            /// Text information
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: ColorRes.grey2.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                ),
                const Sizer(height: 6),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorRes.black,
                    fontSize: 15,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  /// Default design with form fields
  Widget _buildDefaultDesign(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.requestApplicantData,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Sizer(height: 12),
        Column(
          children: [
            /// name
            AuthTextField(
              hint: S.current.applicantName,
              readOnly: true,
              controller: TextEditingController(text: CacheHelper.getString(key: CacheKeys.userName)),
              borderRadius: AppSizes.borderRadiusMd,
              prefixIcon: const Icon(Icons.person),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.current.pleaseEndterValue;
                }
                return null;
              },
            ),
            const Sizer(height: 12),

            /// organization
            AuthTextField(
              hint: S.current.organizationalUnit,
              readOnly: true,
              controller: TextEditingController(text: CacheHelper.getString(key: CacheKeys.organizationName)),
              borderRadius: AppSizes.borderRadiusMd,
              prefixIcon: const Icon(Icons.home_work),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.current.pleaseEndterValue;
                }
                return null;
              },
            ),
            const Sizer(height: 12),

            /// location
            AuthTextField(
              hint: S.current.location,
              readOnly: true,
              controller: TextEditingController(text: CacheHelper.getString(key: CacheKeys.departmentAddress)),
              borderRadius: AppSizes.borderRadiusMd,
              prefixIcon: const Icon(Icons.location_on),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.current.pleaseEndterValue;
                }
                return null;
              },
            ),
          ],
        ),
      ],
    );
  }
}
