import 'package:flutter/material.dart';

import '../../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../generated/l10n.dart';

/// Compact search field used to filter the long HR services list.
///
/// Reports the latest text via [onChanged] so the parent screen can
/// filter its `state.services` list locally without needing to call
/// the API on every keystroke.
class ServicesSearchBar extends StatelessWidget {
  const ServicesSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorRes.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusXXLg),
        border: Border.all(color: ColorRes.grey5, width: 1),
        boxShadow: [
          BoxShadow(
            color: ColorRes.primary.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: AppSizes.padding * 0.6),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            color: ColorRes.primary,
            size: AppSizes.iconMd,
          ),
          const Sizer(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorRes.black,
                    fontSize: AppSizes.fontSizeSm,
                  ),
              decoration: InputDecoration(
                isDense: true,
                hintText: S.current.searchPlaceholder,
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorRes.grey2,
                      fontSize: AppSizes.fontSizeSm,
                    ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: AppSizes.padding * 0.8,
                ),
              ),
            ),
          ),

          /// Clear button — appears only when the field has content.
          if (controller.text.isNotEmpty)
            IconButton(
              icon: Icon(
                Icons.cancel_rounded,
                color: ColorRes.grey2,
                size: AppSizes.iconMd,
              ),
              onPressed: () {
                controller.clear();
                onChanged('');
              },
            ),
        ],
      ),
    );
  }
}
