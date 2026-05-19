import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/features/details_and_edit_for_requests/presentation/controller/my_requests_cubit.dart';
import 'package:shaoni/features/navigation/presentation/controllers/navigation_cubit.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/manager_requests_grid_view.dart';
import '../../../home/presentation/widgets/user_requests_grid_view.dart';

class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navController = context.watch<NavigationCubit>();
   return navController.state.user?.managerId==0?  DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            indicatorColor: Theme.of(context).primaryColor, // Or ColorRes.primary
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey, // Or ColorRes.grey
            tabs:  [
              Tab(text: S.current.myOrders),
              Tab(text: S.current.submittedRequests),
            ],
          ),
          // Sizer(height: 10,),
          Expanded(child:TabBarView(children:
          [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
              child: SizedBox(
                height: AppSizes.fullHeight * 0.79,
                child: BlocBuilder<MyRequestsCubit, MyRequestsState>(
                  builder: (context, state) {
                    return const UserRequestsGridView();
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
              child: SizedBox(
                height: AppSizes.fullHeight * 0.79,
                child: BlocBuilder<MyRequestsCubit, MyRequestsState>(
                  builder: (context, state) {
                    return const ManagerRequestsGridView();
                  },
                ),
              ),
            ),
          ]) ),

        ],
      ),
    ): Padding(
     padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
     child: SizedBox(
       height: AppSizes.fullHeight * 0.79,
       child: BlocBuilder<MyRequestsCubit, MyRequestsState>(
         builder: (context, state) {
           return const UserRequestsGridView();
         },
       ),
     ),
   );
  }
}
