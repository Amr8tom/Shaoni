import 'package:flutter/material.dart';

import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';

class CommentWritingWidget extends StatefulWidget {
  final void Function(String comment)? onCommentSubmit;

  const CommentWritingWidget({
    super.key,
    this.onCommentSubmit,
  });

  @override
  State<CommentWritingWidget> createState() => _CommentWritingWidgetState();
}

class _CommentWritingWidgetState extends State<CommentWritingWidget> {
  final TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.padding),
      child: Container(
        padding: EdgeInsets.all(AppSizes.padding),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: ColorRes.greyForBorders),
          color: ColorRes.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.notes,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Divider(color: ColorRes.grey4),
            TextFormField(
              decoration: InputDecoration(
                hintText: S.current.writeAcceptOrRejectReason,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: ColorRes.grey2),
              ),
              maxLines: 3,
              controller: commentController,
              onChanged: (value) => widget.onCommentSubmit?.call(value),
            ),
            const Sizer(height: 24),
          ],
        ),
      ),
    );
  }
}
