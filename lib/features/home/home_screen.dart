import 'package:flutter/material.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/features/home/presentation/widgets/show_all_requests.dart';
import 'package:shaoni/features/home/presentation/widgets/statistics_list_view.dart';
import '../../generated/l10n.dart';
import 'presentation/widgets/my_requests_grid_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// show some statistics
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.padding / 2),
          child: const StatisticsListView(),
        ),

        /// make size
        const Sizer(height: 10),

        /// show all request button and title
        const ShowAllRequests(),

        /// make size
        const Sizer(height: 10),

        /// display lastest requests in listView with scrolling
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
          child: SizedBox(

              height: AppSizes.fullHeight * 0.5,
              child: const MyRequestGridView()),
        ),
      ],
    );
  }
}
