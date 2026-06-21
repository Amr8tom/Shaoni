import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/features/details_and_edit_for_requests/presentation/controller/my_requests_cubit.dart';
import 'package:shaoni/features/navigation/presentation/controllers/navigation_cubit.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/kafeel_requests_grid_view.dart';
import '../../../home/presentation/widgets/manager_requests_grid_view.dart';
import '../../../home/presentation/widgets/user_requests_grid_view.dart';

class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navController = context.watch<NavigationCubit>();
    final user = navController.state.user;

    final bool isManager = user?.managerId == 1;
    final bool isKafeel = user?.isKafeel ?? false;

    // Determine tab count and build tabs/views dynamically
    final List<Tab> tabs = [
      Tab(text: S.current.myOrders),
      if (isManager) Tab(text: S.current.submittedRequests),
      if (isKafeel) Tab(text: S.current.kafeelRequests),
    ];

    final List<Widget> views = [
      _tabContent(child: const UserRequestsGridView()),
      if (isManager) _tabContent(child: const ManagerRequestsGridView()),
      if (isKafeel) _tabContent(child: const KafeelRequestsGridView()),
    ];

    if (tabs.length == 1) {
      // No extra tabs — just show employee requests directly
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
        child: SizedBox(
          height: AppSizes.fullHeight * 0.79,
          child: BlocBuilder<MyRequestsCubit, MyRequestsState>(
            builder: (context, state) => const UserRequestsGridView(),
          ),
        ),
      );
    }

    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: ColorRes.grey,
            tabs: tabs,
            labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold,fontSize: AppSizes.fontSizeMd*0.7),
          ),
          Expanded(
            child: TabBarView(children: views),
          ),
        ],
      ),
    );
  }

  Widget _tabContent({required Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
      child: SizedBox(
        height: AppSizes.fullHeight * 0.79,
        child: BlocBuilder<MyRequestsCubit, MyRequestsState>(
          builder: (context, state) => child,
        ),
      ),
    );
  }
}
