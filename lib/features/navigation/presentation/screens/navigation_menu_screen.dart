import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/navigationbar/bottom_navigation_bar.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/features/home/presentation/controller/home_cubit.dart';
import 'package:shaoni/features/details_and_edit_for_requests/presentation/controller/my_requests_cubit.dart';
import 'package:shaoni/features/navigation/presentation/widgets/custom_navigation_appbar.dart';
import 'package:upgrader/upgrader.dart';
import '../../../../core/connection/check_for_updates.dart';
import '../../../../core/service_locator/service_locator.dart';
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
          create: (context) => serviceLocator<HomeCubit>(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final controller = context.watch<NavigationCubit>();
          final requestController = context.read<
              MyRequestsCubit>(); // Use read instead of watch for listener logic

          return UpgradeAlert(
            child: Scaffold(
              appBar: controller.indx == 0
                  ? null
                  : customAppBar(
                      scaffoldKey: scaffoldKey,
                      context: context,
                      isHeader: true,
                      showMenu: true,
                      height: AppSizes.appBarHeight * 1.8,
                    ),
              // DAppBar(
              //         scaffoldKey: scaffoldKey,
              //         isHeader: true,
              //         showMenu: true,
              // ),
              key: scaffoldKey,
              drawer: const CustomSideMenu(),
              // extendBodyBehindAppBar: true,
              backgroundColor: ColorRes.grey6,
              extendBody: true,
              body: BlocConsumer<NavigationCubit, NavigationState>(
                listener: (context, state) {
                  if (state.status.isSuccess) {
                    /// employee requests (always)
                    requestController.getAllUserRequests(
                        employeeId: state.user!.employeeId ?? 1);

                    /// manager requests (only for managers)
                    if (state.user?.managerId == 0) {
                      requestController.getAllManagerRequests(
                          managerID: state.user!.id ?? 1);
                    }

                    /// kafeel requests (only for kafeel)
                    if (state.user?.isKafeel == true) {
                      requestController.getAllKafeelRequests(
                          userId: state.user!.employeeId ?? 1);
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
                          height: AppSizes.appBarHeight * 3.5,
                        ),
                        Column(
                          children: [
                            const Sizer(height: 144),
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
