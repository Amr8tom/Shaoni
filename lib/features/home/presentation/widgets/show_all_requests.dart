import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/features/navigation/presentation/controllers/navigation_cubit.dart';
import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';

class ShowAllRequests extends StatelessWidget {
  const ShowAllRequests({super.key});

  @override
  Widget build(BuildContext context) {
    final navController = context.read<NavigationCubit>();
    return GestureDetector(
      onTap: () {
        navController.changeIndex(2);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
        child: Row(
          children: [
            Text(
              S.current.myOrders,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  S.current.seeAll,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: ColorRes.grey),
                ),
                const Sizer(width: 8),
                Icon(Icons.arrow_forward_ios, size: AppSizes.iconXs),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
