import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/features/my-requests/presentation/controller/my_requests_cubit.dart';

import '../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';

class CommentWritingWidget extends StatelessWidget {
  const CommentWritingWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = context.read<MyRequestsCubit>();
    return Padding(
      padding: EdgeInsets.all(AppSizes.padding),
      child: Container(
        padding: EdgeInsets.all(AppSizes.padding),
        decoration: BoxDecoration(
          border: Border.all(width: 1,color: ColorRes.greyForBorders),
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.notes,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Divider(color: ColorRes.grey4),
            TextFormField(
              maxLines: 5,
              controller: controller.commentController,
            ),
            const Sizer(height: 24),
          ],
        ),
      ),
    );

  }
}
