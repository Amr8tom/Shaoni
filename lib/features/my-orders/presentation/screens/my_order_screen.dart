import 'package:flutter/material.dart';

import '../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../home/presentation/widgets/my_orders_grid_view.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        const Sizer( height: 200,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
          child: const MyOrdersGridView(),
        ),
      ],
    );
  }
}
