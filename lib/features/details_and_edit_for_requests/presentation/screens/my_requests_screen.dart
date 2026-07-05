import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/features/details_and_edit_for_requests/presentation/controller/my_requests_cubit.dart';
import 'package:shaoni/features/details_and_edit_for_requests/presentation/widgets/filter_bottom_sheet.dart';
import 'package:shaoni/common/widgets/sheets/default_bottom_sheet/default_bottom_sheet_widget.dart';
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

    final bool isManager = user?.jobTitle?.toLowerCase() == 'manager';
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
          Padding(
            padding: EdgeInsets.only(right: AppSizes.padding * 0.5),
            child: Row(
              children: [
                Expanded(
                  child: TabBar(
                    indicatorColor: Theme.of(context).primaryColor,
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: ColorRes.grey,
                    dividerColor: Colors.transparent,
                    tabs: tabs,
                    labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.fontSizeMd * 0.7),
                  ),
                ),
                BlocBuilder<MyRequestsCubit, MyRequestsState>(
                  builder: (context, state) {
                    final isFiltered = state.selectedServiceCode != null;
                    return IconButton(
                      onPressed: () {
                        final cubit = context.read<MyRequestsCubit>();
                        showDBottomSheet(
                          context: context,
                          body: BlocProvider.value(
                            value: cubit,
                            child: const FilterBottomSheet(),
                          ),
                        );
                      },
                      icon: Stack(
                        children: [
                          Icon(
                            Icons.filter_list_alt,
                            color: isFiltered ? ColorRes.primary : ColorRes.green,
                            size: AppSizes.iconLg,
                          ),
                          if (isFiltered)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: ColorRes.primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 1.5),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
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
