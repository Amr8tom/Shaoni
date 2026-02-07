import 'package:flutter/material.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/contancts.dart';
import '../../../core/routing/route_names.dart';
import '../../../generated/l10n.dart';

/// Widget that displays contact buttons for email, phone, and login
class ContactButtonsWidget extends StatelessWidget {
  const ContactButtonsWidget({super.key});



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Contact Options Text
        Text(
          S.current.guestContactUs,
          style: TextStyle(
            fontSize: AppSizes.fontSizeSm,
            color: ColorRes.grey,
            fontWeight: FontWeight.w600,
          ),
        ),

        SizedBox(height: AppSizes.md),

        /// All Buttons in One Row
        Row(
          children: [
            /// whats app Button
            Expanded(
              child: _ContactButton(
                icon: Icons.chat_outlined,
                label: S.current.guestContactWhatsApp,
                gradient: LinearGradient(
                  colors: [
                    ColorRes.primary,
                    ColorRes.primary.withOpacity(0.8),
                  ],
                ),
                onPressed: (){
                  Contacts.openWhatsAppChat(num:"+201011577033");
                },
                isCompact: true,
              ),
            ),

            SizedBox(width: AppSizes.sm),

            /// Phone Button
            Expanded(
              child: _ContactButton(
                icon: Icons.phone_outlined,
                label: S.current.guestContactPhone,
                gradient: LinearGradient(
                  colors: [
                    ColorRes.yellow,
                    ColorRes.yellow.withOpacity(0.8),
                  ],
                ),
                onPressed: (){
                  Contacts.makePhoneCall("+201011577033");
                },
                isCompact: true,
              ),
            ),

            SizedBox(width: AppSizes.sm),

            /// Login Button
            Expanded(
              child: _ContactButton(
                icon: Icons.login,
                label: S.current.login,
                gradient: LinearGradient(
                  colors: [
                    ColorRes.green,
                    ColorRes.green.withOpacity(0.8),
                  ],
                ),
                onPressed: () {
                  context.pushNamed(DRoutesName.loginRoute);
                },
                isCompact: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Private widget for contact button
class _ContactButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Gradient gradient;
  final VoidCallback onPressed;
  final bool isCompact;

  const _ContactButton({
    required this.icon,
    required this.label,
    required this.gradient,
    required this.onPressed,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppSizes.md),
      child: Container(
        width: isCompact ? null : double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: AppSizes.md,
          horizontal: isCompact ? AppSizes.sm : AppSizes.ld,
        ),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(AppSizes.md),
          boxShadow: [
            BoxShadow(
              color: ColorRes.primary.withOpacity(0.3),
              blurRadius: AppSizes.borderRadiusLg,
              offset: Offset(0, AppSizes.borderRadiusSm * 1.5),
            ),
          ],
        ),
        child: isCompact
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: ColorRes.white,
                    size: AppSizes.iconMd,
                  ),
                  SizedBox(height: AppSizes.xs),
                  Text(
                    label,
                    style: TextStyle(
                      color: ColorRes.white,
                      fontSize: AppSizes.fontSizeSm * 0.75, // ~12
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: ColorRes.white,
                    size: AppSizes.iconMd,
                  ),
                  SizedBox(width: AppSizes.borderRadiusLg),
                  Text(
                    label,
                    style: TextStyle(
                      color: ColorRes.white,
                      fontSize: AppSizes.fontSizeSm,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

