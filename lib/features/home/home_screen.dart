import 'package:flutter/material.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/features/home/select_list_view.dart';

import '../../generated/l10n.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Sizer(height: 160),
        Padding(
          padding: EdgeInsets.all(AppSizes.padding/2),
          child: const SelectListView(),
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: AppSizes.padding),
          child: Row(children: [
            Text(S.current.myOrders,style: Theme.of(context).textTheme.titleSmall),
            Spacer(),
            Row(
              children: [
                Text(S.current.seeAll,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorRes.grey
                ),),
                  const Sizer(width: 8,),
                  Icon(Icons.arrow_forward_ios,size: AppSizes.iconXs,)

              ],
            ),

          ],),
        )
      ],
    );
  }

}
