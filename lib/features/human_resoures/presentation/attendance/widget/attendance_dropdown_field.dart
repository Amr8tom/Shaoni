import 'package:flutter/material.dart';

import '../../../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../../../core/constants/app_sizes.dart';
import '../../../../../../core/constants/colors.dart';

class DDropdownField extends StatelessWidget {
  const DDropdownField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.items,
    required this.onChanged,
    this.value,
    this.validator,
  });

  final String? label;
  final String hint;
  final IconData icon;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;
  final String? value;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        label?.trim()==''?const Sizer():Text(
          label!,
          textAlign: TextAlign.end,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorRes.grey2,
                fontSize: AppSizes.fontSizeSm * 0.85,
                fontWeight: FontWeight.w600,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        // const Sizer(height: 6),

        DropdownButtonFormField<String>(
          value: (value != null && value!.isNotEmpty) ? value : null,
          items: items,
          onChanged: onChanged,
          validator: validator,
          isExpanded: true,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorRes.black,
                fontWeight: FontWeight.w700,
                fontSize: AppSizes.fontSizeSm,
              ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: ColorRes.grey2,
            size: AppSizes.iconMd,
          ),
          dropdownColor: ColorRes.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          decoration: InputDecoration(
            isDense: true,
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorRes.grey2.withOpacity(0.6),
                  fontSize: AppSizes.fontSizeSm,
                ),
            prefixIcon: Padding(
              padding:  EdgeInsets.symmetric(horizontal: AppSizes.padding * 0.8),
              child: Icon(
                icon,
                size: AppSizes.iconMd,
                // color: ColorRes.primary,
              ),
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
