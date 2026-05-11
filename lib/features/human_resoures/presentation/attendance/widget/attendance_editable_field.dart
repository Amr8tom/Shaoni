import 'package:flutter/material.dart';

import '../../../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../../../core/constants/app_sizes.dart';
import '../../../../../../core/constants/colors.dart';

class DEditableField extends StatelessWidget {
  const DEditableField({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    required this.hint,
    this.onTap,
    this.iconColor,
    this.readOnly = true,
    this.validator,
    this.keyboardType,
  });

  final String label;
  final String hint;
  final Color? iconColor;
  final IconData icon;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final bool readOnly;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          textAlign: TextAlign.end,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorRes.grey2,
                fontSize: AppSizes.fontSizeSm * 0.85,
                fontWeight: FontWeight.w600,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const Sizer(height: 6),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          validator: validator,
          keyboardType: keyboardType,
          textAlign: TextAlign.end,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorRes.black,
                fontWeight: FontWeight.w700,
                fontSize: AppSizes.fontSizeSm,
              ),
          decoration: InputDecoration(
            isDense: true,
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorRes.grey2.withOpacity(0.6),
                  fontSize: AppSizes.fontSizeSm,
                ),
            prefixIcon: Icon(
              icon,
              size: AppSizes.iconSm,
              color: iconColor??ColorRes.primary,
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: AppSizes.iconLg,
              minHeight: AppSizes.iconLg,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSizes.padding * 0.8,
              vertical: AppSizes.padding * 0.6,
            ),
            filled: true,
            fillColor: ColorRes.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              borderSide: BorderSide(color: ColorRes.grey5, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              borderSide: BorderSide(color: ColorRes.grey5, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              borderSide:
                  BorderSide(color: ColorRes.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              borderSide: BorderSide(color: ColorRes.error, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              borderSide: BorderSide(color: ColorRes.error, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
