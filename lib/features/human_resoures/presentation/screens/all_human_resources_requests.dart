import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shaoni/common/custom_ui.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/core/routing/route_names.dart';
import 'package:shaoni/core/service_locator/service_locator.dart';
import 'package:shaoni/core/utils/enums/general_status.dart';
import 'package:shaoni/features/human_resoures/domain/entity/service.dart';
import 'package:shaoni/features/human_resoures/presentation/controller/human_resources/human_resources_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../generated/l10n.dart';
import '../widgets/all_services/service_grid_card.dart';

class AllHumanResourcesRequests extends StatelessWidget {
  const AllHumanResourcesRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<HumanResourcesCubit>()..getAllServices(),
      child: Scaffold(
        backgroundColor: ColorRes.grey6,
        appBar: DAppBar(
          showBackArrow: true,
          title: S.current.humanResources,
          fontSize: AppSizes.fontSizeMd,
          actions: const [],
        ),
        body: SafeArea(
          child: BlocBuilder<HumanResourcesCubit, HumanResourcesState>(
            builder: (context, state) {
              final services = state.status.isLoading
                  ? List.filled(
                      10,
                      Service(
                          id: 1,
                          nameEn: 'hr.exit.permission',
                          nameAr: 'إذن خروج'))
                  : state.services ?? const [];
              return RefreshIndicator(
                color: ColorRes.primary,
                onRefresh: () =>
                    context.read<HumanResourcesCubit>().getAllServices(),
                child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.padding,
                    ),
                    child: AnimationLimiter(
                      child: GridView.builder(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        padding: EdgeInsets.only(bottom: AppSizes.padding * 2),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1.1,
                        ),
                        itemCount: services.length,
                        itemBuilder: (context, index) {
                          if (services.isEmpty)
                            return CustomUI.emptyData(
                                message: S.current.noData);
                          final service = services[index];
                          return Skeletonizer(
                            enabled: state.status.isLoading,
                            child: AnimationConfiguration.staggeredGrid(
                              position: index,
                              columnCount: 2,
                              duration: const Duration(milliseconds: 400),
                              child: ScaleAnimation(
                                scale: 0.95,
                                child: FadeInAnimation(
                                  child: ServiceGridCard(
                                    service: service,
                                    onTap: () =>
                                        _onServiceTap(context, service),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )),
              );
            },
          ),
        ),
      ),
    );
  }

  static void _onServiceTap(BuildContext context, Service service) {
    final code = service.nameEn ?? '';
    switch (code) {
      case 'hr.exit.permission':
        context.pushNamed(
          DRoutesName.requestCertainService,
        );
        return;
      case 'attendance.update':
        context.pushNamed(DRoutesName.missingAttendanceHistory);
        return;
      case 'study.request':
        context.pushNamed(DRoutesName.createStudyRequestRoute);
        return;
      case 'car.permission':
        context.pushNamed(DRoutesName.createCarPermissionRoute);
        return;
      case 'complaint.request':
        context.pushNamed(DRoutesName.createComplaintRequestRoute);
        return;
      case 'start.work':
        context.pushNamed(DRoutesName.createStartWorkRoute);
        return;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.current.notImplementedYet),
            backgroundColor: ColorRes.grey2,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
    }
  }
}
