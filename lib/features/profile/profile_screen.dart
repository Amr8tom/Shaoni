import 'package:flutter/material.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/device/device_utility.dart';
import 'package:shaoni/core/widgets/buttons/d_button.dart';

import '../../common/widgets/sized_boxes/sizer.dart';
import '../../generated/l10n.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: 'مصطفى زكريا محمد');
    final phoneController = TextEditingController(text: '010123456789');
    final emailController = TextEditingController(text: 'm.zakaria@ejad.sa');
    final passwordController = TextEditingController(text: '*************');

    return Scaffold(
      appBar: DAppBar(
        title: S.current.profile,
        showBackArrow: true,
        appHeight: DDeviceUtils.getAppBarHeight() * 3,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppSizes.padding, vertical: AppSizes.ld),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Sizer(height: 24),

              // Avatar with small edit badge
              SizedBox(
                height: AppSizes.productImageSize,
                child: Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: AppSizes.productImageSize / 2,
                        backgroundColor: ColorRes.white,
                        child: CircleAvatar(
                          radius: (AppSizes.productImageSize / 2) - 6,
                          backgroundImage:
                              const AssetImage('assets/images/ss/avatar.png'),
                          // use actual user image or placeholder
                        ),
                      ),
                      Positioned(
                        bottom: -6,
                        right: -6,
                        child: GestureDetector(
                          onTap: () {
                            // TODO: implement image picker
                          },
                          child: Container(
                            padding: EdgeInsets.all(AppSizes.sm),
                            decoration: BoxDecoration(
                              color: ColorRes.primary,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: ColorRes.white, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorRes.black.withOpacity(0.12),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.edit,
                              size: AppSizes.iconSm,
                              color: ColorRes.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Sizer(height: 28),

              // Form fields - using reusable ProfileField widget
              ProfileField(
                controller: nameController,
                hintText: S.current.profileInfo,
                trailingIcon: Icons.person,
              ),
              const Sizer(height: 12),
              ProfileField(
                controller: phoneController,
                hintText: '010123456789',
                keyboardType: TextInputType.phone,
                trailingIcon: Icons.smartphone,
              ),
              const Sizer(height: 12),
              ProfileField(
                controller: emailController,
                hintText: 'm.zakaria@ejad.sa',
                keyboardType: TextInputType.emailAddress,
                trailingIcon: Icons.email,
              ),
              const Sizer(height: 12),
              ProfileField(
                controller: passwordController,
                hintText: '*************',
                isObscure: true,
                trailingIcon: Icons.lock,
              ),

              const Sizer(height: 36),

              DButton(
                text: S.current.update,
                onPressed: () {
                  // TODO: save profile changes
                },
                variant: DButtonVariant.primary,
                size: DButtonSize.large,
                height: AppSizes.buttonHeight,
                width: double.infinity,
              ),

              const Sizer(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable profile field that matches the app style and allows toggling edit mode
class ProfileField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final IconData? trailingIcon;
  final TextInputType? keyboardType;
  final bool isObscure;

  const ProfileField({
    super.key,
    required this.controller,
    this.hintText,
    this.trailingIcon,
    this.keyboardType,
    this.isObscure = false,
  });

  @override
  State<ProfileField> createState() => _ProfileFieldState();
}

class _ProfileFieldState extends State<ProfileField> {
  bool isEditing = false;
  bool obscure = false;

  @override
  void initState() {
    super.initState();
    obscure = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorRes.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
        border: Border.all(color: ColorRes.borderTextFormField),
        boxShadow: [
          BoxShadow(
            color: ColorRes.black.withOpacity(0.03),
            blurRadius: 6,
            spreadRadius: 0.5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // edit square icon
          GestureDetector(
            onTap: () => setState(() => isEditing = true),
            child: Container(
              margin: EdgeInsets.all(AppSizes.sm),
              padding: EdgeInsets.all(AppSizes.sm),
              decoration: BoxDecoration(
                color: ColorRes.grey6,
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              ),
              child: Icon(
                Icons.edit,
                size: AppSizes.iconMd,
                color: ColorRes.grey2,
              ),
            ),
          ),

          // Expanded text field
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              readOnly: !isEditing,
              keyboardType: widget.keyboardType,
              obscureText: obscure,
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                    vertical: AppSizes.md, horizontal: AppSizes.sm),
              ),
              style: TextStyle(
                  color: ColorRes.black, fontSize: AppSizes.fontSizeMd),
              onFieldSubmitted: (_) => setState(() => isEditing = false),
            ),
          ),

          // trailing icon
          if (widget.trailingIcon != null)
            Padding(
              padding: EdgeInsets.only(right: AppSizes.md, left: AppSizes.sm),
              child: IconButton(
                onPressed: () {
                  if (widget.isObscure) {
                    setState(() => obscure = !obscure);
                  }
                },
                icon: Icon(
                  widget.isObscure
                      ? (obscure ? Icons.lock : Icons.lock_open)
                      : widget.trailingIcon,
                  color: ColorRes.grey2,
                  size: AppSizes.iconMd,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
