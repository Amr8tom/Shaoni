import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/device/device_utility.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/widgets/buttons/d_button.dart';

import '../../generated/l10n.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: 'مصطفى زكريا محمد');
    final phoneController = TextEditingController(text: '010123456789');
    final emailController = TextEditingController(text: 'm.zakaria@ejad.sa');
    final positionController = TextEditingController(text: 'Senior Developer');
    final departmentController = TextEditingController(text: 'IT Department');
    final passwordController = TextEditingController(text: '*************');

    return Scaffold(
      backgroundColor: ColorRes.scaffoldBG,
      appBar: DAppBar(
        title: S.current.profile,
        showBackArrow: true,
        appHeight: DDeviceUtils.getAppBarHeight() * 3,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Sizer(height: 24),

                    // Avatar with edit badge (bottom-left, olive/gold color)
                    Center(
                      child: SizedBox(
                        width: 120.w,
                        height: 120.w,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Red/salmon background circle
                            Container(
                              width: 120.w,
                              height: 120.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFE8B4A8), // salmon/peach color behind avatar
                              ),
                            ),
                            // Avatar image
                            Positioned.fill(
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: const AssetImage('assets/images/pngs/profile.png'),
                              ),
                            ),
                            // Edit badge - bottom left
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: GestureDetector(
                                onTap: () {
                                  // TODO: implement image picker
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: ColorRes.yellow, // olive/gold color
                                    shape: BoxShape.circle,
                                    border: Border.all(color: ColorRes.white, width: 2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorRes.black.withOpacity(0.15),
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.edit_outlined,
                                    size: 16.sp,
                                    color: ColorRes.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Sizer(height: 32),

                    // Form fields - using reusable ProfileField widget
                    ProfileField(
                      controller: nameController,
                      trailingIcon: Icons.person_outline,
                    ),
                    const Sizer(height: 12),
                    ProfileField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      trailingIcon: Icons.smartphone_outlined,
                    ),
                    const Sizer(height: 12),
                    ProfileField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      trailingIcon: Icons.mail_outline,
                    ),
                    const Sizer(height: 12),
                    ProfileField(
                      controller: positionController,
                      trailingIcon: Iconsax.briefcase,
                    ),
                    const Sizer(height: 12),
                    ProfileField(
                      controller: departmentController,
                      trailingIcon: Iconsax.building,
                    ),
                    const Sizer(height: 12),
                    ProfileField(
                      controller: passwordController,
                      isObscure: true,
                      trailingIcon: Icons.lock_outline,
                    ),
                    
                    const Sizer(height: 32),
                    
                    // Settings Section
                    _buildSettingsSection(context),
                    
                    const Sizer(height: 24),
                  ],
                ),
              ),
            ),
          ),

          // Bottom button - fixed at bottom
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.padding, vertical: AppSizes.md),
            child: SafeArea(
              top: false,
              child: DButton(
                text: S.current.update,
                onPressed: () {
                  // TODO: save profile changes
                },
                variant: DButtonVariant.primary,
                size: DButtonSize.large,
                height: 50.h,
                width: double.infinity,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Settings section with menu options
  Widget _buildSettingsSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorRes.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
        border: Border.all(color: ColorRes.grey4, width: 1),
      ),
      child: Column(
        children: [
          _buildSettingsItem(
            icon: Iconsax.notification,
            title: 'Notifications',
            onTap: () {
              // TODO: Navigate to notifications settings
            },
          ),
          Divider(height: 1, color: ColorRes.grey4),
          _buildSettingsItem(
            icon: Iconsax.security,
            title: 'Privacy & Security',
            onTap: () {
              // TODO: Navigate to privacy settings
            },
          ),
          Divider(height: 1, color: ColorRes.grey4),
          _buildSettingsItem(
            icon: Iconsax.setting_2,
            title: 'Settings',
            onTap: () {
              // TODO: Navigate to app settings
            },
          ),
          Divider(height: 1, color: ColorRes.grey4),
          _buildSettingsItem(
            icon: Iconsax.info_circle,
            title: 'Help & Support',
            onTap: () {
              // TODO: Navigate to help
            },
          ),
        ],
      ),
    );
  }
  
  // Individual settings item
  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: ColorRes.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                size: 20.sp,
                color: ColorRes.primary,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorRes.darkGrey,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: ColorRes.grey2,
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable profile field that matches the design exactly
class ProfileField extends StatefulWidget {
  final TextEditingController controller;
  final IconData? trailingIcon;
  final TextInputType? keyboardType;
  final bool isObscure;

  const ProfileField({
    super.key,
    required this.controller,
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
      height: 56.h,
      decoration: BoxDecoration(
        color: ColorRes.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
        border: Border.all(color: ColorRes.grey4, width: 1),
      ),
      child: Row(
        children: [
          // Edit square icon - LEFT side
          GestureDetector(
            onTap: () => setState(() => isEditing = true),
            child: Container(
              margin: EdgeInsets.only(left: 8.w, right: 8.w),
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: ColorRes.grey4,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.edit_outlined,
                size: 20.sp,
                color: ColorRes.grey2,
              ),
            ),
          ),

          // Expanded text field - CENTER (text aligned to end/right)
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              readOnly: !isEditing,
              keyboardType: widget.keyboardType,
              obscureText: obscure,
              textAlign: TextAlign.end, // Right aligned text
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
              ),
              style: TextStyle(
                color: ColorRes.darkGrey,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              onFieldSubmitted: (_) => setState(() => isEditing = false),
              onTapOutside: (_) => setState(() => isEditing = false),
            ),
          ),

          // Trailing icon - RIGHT side
          if (widget.trailingIcon != null)
            Padding(
              padding: EdgeInsets.only(right: 16.w, left: 8.w),
              child: Icon(
                widget.trailingIcon,
                color: ColorRes.grey2,
                size: 24.sp,
              ),
            ),
        ],
      ),
    );
  }
}
