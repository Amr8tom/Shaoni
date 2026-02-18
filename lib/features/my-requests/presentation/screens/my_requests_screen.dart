import 'package:flutter/material.dart';

import '../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../home/presentation/widgets/my_requests_grid_view.dart';

class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
      child: SizedBox(
        height: AppSizes.fullHeight * 0.66,
        child: const MyRequestGridView(),
      ),
    );
  }
}
