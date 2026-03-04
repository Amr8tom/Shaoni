import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/common/widgets/navigationbar/bottom_navigation_bar.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
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
      ],
      child: Builder(
        builder: (context) {
          final controller = context.watch<NavigationCubit>();
          final state = controller.state;
          return UpgradeAlert(
            child: Scaffold(
              appBar:
                  controller.indx == 0
                      ? null
                      : DAppBar(
                        scaffoldKey: scaffoldKey,
                        isHeader: true,
                      ),
              key: scaffoldKey,
              drawer: const CustomSideMenu(),
              // extendBodyBehindAppBar: true,
              backgroundColor: ColorRes.grey6,
              extendBody: true,
              body: Stack(
                children: [
                  controller.indx == 0
                      ? customAppBar(
                        scaffoldKey: scaffoldKey,
                        context: context,
                        isHeader: true,
                        height: AppSizes.appBarHeight * 4.5,
                      )
                      : const Sizer(),
                  controller.indx == 3
                      ? const SizedBox()
                      : Column(
                        children: [
                          controller.indx == 0
                              ? const Sizer(height: 200)
                              : const Sizer(),
                          state.screens[controller.indx],
                        ],
                      ),
                ],
              ),
              // body: state.screens[controller.indx],
              floatingActionButton: Padding(
                padding:  EdgeInsets.all(AppSizes.padding*1.1),
                child: const CustomBottomNavigationBar(),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            ),
          );
        },
      ),
    );
  }
}
