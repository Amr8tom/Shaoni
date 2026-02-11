import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/navigationbar/bottom_navigation_bar.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/device/device_utility.dart';
import 'package:shaoni/features/navigation/presentation/widgets/custom_navigation_appbar.dart';
import 'package:upgrader/upgrader.dart';
import '../../../../core/connection/check_for_updates.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/helpers/permissions_services.dart';
import '../controllers/navigation_cubit.dart';

class NavigationMenuScreen extends StatelessWidget {
  const NavigationMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PermissionsService.location();
    checkForUpdate(context: context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator<NavigationCubit>()),
      ],
      child: Builder(
        builder: (context) {
          final controller = context.watch<NavigationCubit>();
          final state = controller.state;
          // controller.isGuestMode();
          return UpgradeAlert(
            child: Scaffold(
              backgroundColor: ColorRes.grey6,
              body: Stack(
                children: [
                  controller.indx == 0
                      ? customNavigationAppBars(
                        indx: controller.indx,
                        context: context,
                      )
                      : customNavigationAppBars(
                        indx: controller.indx,
                        context: context,
                        height: DDeviceUtils.getAppBarHeight() * 3,
                      ),
                  state.screens[controller.indx],
                ],
              ),
              // body: state.screens[controller.indx],
              bottomNavigationBar: const CustomBottomNavigationBar(),
            ),
          );
        },
      ),
    );
  }
}
