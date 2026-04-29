import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/core/routing/route_names.dart';
import 'package:shaoni/core/service_locator/service_locator.dart';
import 'package:shaoni/core/utils/enums/general_status.dart';
import 'package:shaoni/features/human_resoures/presentation/controller/human_resources/human_resources_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../generated/l10n.dart';

class ChooseNewRequestServicesScreen extends StatelessWidget {
  const ChooseNewRequestServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          serviceLocator<HumanResourcesCubit>()..getAllServices(),
      child: Scaffold(
        appBar: DAppBar(showBackArrow: true),
        // appBar: AppBar(),
        body: BlocBuilder<HumanResourcesCubit, HumanResourcesState>(
          builder: (context, state) {
            final controllerMyServices = context.watch<HumanResourcesCubit>();
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
                child: Container(
                  child: Skeletonizer(
                    enabled: controllerMyServices.state.status.isLoading
                        ? true
                        : false,
                    containersColor: ColorRes.black.withOpacity(0.1),
                    child: GridView.builder(
                      padding: EdgeInsets.only(top: AppSizes.padding * 2),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 14,
                        childAspectRatio: 7,
                      ),
                      itemCount: controllerMyServices.state.services?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            /// navigate to hr.exit.permission by its name not id cuz problem in ids and conflict between diffrent partners
                            if (controllerMyServices
                                    .state.services![index].nameEn ==
                                "hr.exit.permission") {
                              context
                                  .pushNamed(DRoutesName.requestCertainService);
                            } else {
                              ///
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text(S.current.notImplementedYet)));
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.padding * 2,
                            ),
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorRes.greyForBorders,
                                width: 1,
                              ),
                              color: ColorRes.white,
                              borderRadius: BorderRadius.circular(
                                AppSizes.borderRadiusMd,
                              ),
                            ),
                            child: Text(
                              S.current.localeee == "en"
                                  ? controllerMyServices
                                          .state.services![index].nameEn ??
                                      ""
                                  : controllerMyServices
                                          .state.services?[index].nameAr ??
                                      "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: ColorRes.black),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
