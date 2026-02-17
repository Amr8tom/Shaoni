import 'package:flutter/material.dart';

import '../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';

class MarkAllCheckboxWidget extends StatefulWidget {
  const MarkAllCheckboxWidget({super.key});


  @override
  State<MarkAllCheckboxWidget> createState() => _MarkAllCheckboxWidgetState();
}

class _MarkAllCheckboxWidgetState extends State<MarkAllCheckboxWidget> {
  bool markAllAsRead = false;

  @override
  Widget build(BuildContext context) {
    return        Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.md,
        vertical: AppSizes.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            S.current.addCorrectSignAtAll,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: ColorRes.grey,
            ),
          ),
         const Sizer(width: 8),
          Checkbox(
            value: markAllAsRead,
            onChanged: (value) {
              setState(() {
                markAllAsRead = value ?? false;
              });
            },
            activeColor: ColorRes.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm),
            ),
          ),
        ],
      ),
    ) ;
  }
}
