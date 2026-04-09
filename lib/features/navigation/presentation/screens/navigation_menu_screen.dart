import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/common/widgets/navigationbar/bottom_navigation_bar.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/local_storage/cache_helper.dart';
import 'package:shaoni/core/service_locator/my_requests_service_locator.dart';
import 'package:shaoni/core/utils/enums/general_status.dart';
import 'package:shaoni/features/home/presentation/controller/home_cubit.dart';
import 'package:shaoni/features/my-requests/presentation/controller/my_requests_cubit.dart';
import 'package:shaoni/features/navigation/presentation/widgets/custom_navigation_appbar.dart';
import 'package:upgrader/upgrader.dart';
import '../../../../core/connection/check_for_updates.dart';
import '../../../../core/local_storage/cache_keys.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../my-services/presentation/controller/my_services/my_services_cubit.dart';
import '../controllers/navigation_cubit.dart';
import '../widgets/custom_side_menu.dart';

class NavigationMenuScreen extends StatelessWidget {
  NavigationMenuScreen({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    checkForUpdate(context: context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator<NavigationCubit>()),
        BlocProvider(create: (context) => serviceLocator<MyRequestsCubit>()),
        BlocProvider(
          create: (context) => serviceLocator<HomeCubit>()..getAllStatusCounts(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final controller = context.watch<NavigationCubit>();
          final requestController = context.read<MyRequestsCubit>(); // Use read instead of watch for listener logic

          return UpgradeAlert(
            child: Scaffold(
              appBar: controller.indx == 0
                  ? null
                  : DAppBar(scaffoldKey: scaffoldKey, isHeader: true,showMenu: true,),
              key: scaffoldKey,
              drawer: const CustomSideMenu(
              ),
              // extendBodyBehindAppBar: true,
              backgroundColor: ColorRes.grey6,
              extendBody: true,
              body: BlocConsumer<NavigationCubit, NavigationState>(
                listener: (context, state) {
                  if (state.status.isSuccess) {
                    print("employID");
                    print(CacheHelper.getString(key: CacheKeys.employeeId));
                    print(state.user?.employeeId);
                    /// if he is employee
                    requestController.getAllUserRequests(
                        employeeId: int.parse(
                            CacheHelper.getString(key: CacheKeys.employeeId) ??
                                state.user!.employeeId.toString()));
                    if (state.user?.managerId == 0) {
                      /// if he is manager
                      requestController.getAllManagerRequests(
                          managerID: state.user!.id ?? 1);
                    }
                  }
                },
                builder: (context, state) {
                  if (controller.indx == 0) {
                    return Stack(
                      children: [
                        customAppBar(
                          scaffoldKey: scaffoldKey,
                          context: context,
                          isHeader: true,
                          showMenu: true,
                          height: AppSizes.appBarHeight * 4.5,
                        ),
                        Column(
                          children: [
                            const Sizer(height: 200),
                            Expanded(child: state.screens[controller.indx]),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return state.screens[controller.indx];
                  }
                },
              ),
              // body: state.screens[controller.indx],
              floatingActionButton: Padding(
                padding: EdgeInsets.all(AppSizes.padding * 1.1),
                child: const CustomBottomNavigationBar(),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            ),
          );
        },
      ),
    );
  }
}
