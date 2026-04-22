import 'package:flutter/material.dart';

import '../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/helpers/image_from_base64.dart';
import '../../../../generated/l10n.dart';

class LeavesAttachmentWidget extends StatelessWidget {
  final String leavesAttachment;
  const LeavesAttachmentWidget({super.key, required this.leavesAttachment});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(color: ColorRes.grey4),
        const Sizer(height: 16),
        /// Attachments Section
        Row(
          children: [
            Icon(
              Icons.attach_file,
              color: ColorRes.primary,
              size: AppSizes.iconMd,
            ),
            const Sizer(width: 10),
            Text(
              S.current.attachments,
              style:
              Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorRes.primary,
                fontSize: AppSizes.fontSizeSm,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const Sizer(height: 16),

        /// Attachment Image Container
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorRes.primary.withOpacity(0.2),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(
              AppSizes.borderRadiusMd,
            ),
            color: ColorRes.primary.withOpacity(0.05),
          ),
          padding: EdgeInsets.all(AppSizes.padding),
          child: ClipRRect(
            borderRadius:
            BorderRadius.circular(AppSizes.borderRadiusMd),
            child: Center(
              child: ImageFromBase64String(
                  base64String: leavesAttachment,
                  height: AppSizes.heightcontainer * 7,
                  width: double.infinity
              ),
            ),
          ),
        ),
        const Sizer(height: 16),
      ],
    );
  }
}
