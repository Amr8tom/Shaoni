import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/core/routing/route_names.dart';
import 'package:shaoni/core/service_locator/service_locator.dart';
import 'package:shaoni/core/utils/enums/general_status.dart';
import 'package:shaoni/features/my-services/presentation/controller/my_services/my_services_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../generated/l10n.dart';

class ChooseNewRequestServicesScreen extends StatelessWidget {
  const ChooseNewRequestServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<MyServicesCubit>()..getAllServices(),
      child: Scaffold(
        appBar: DAppBar(showBackArrow: true),
        // appBar: AppBar(),
        body: BlocBuilder<MyServicesCubit, MyServicesState>(
          builder: (context, state) {
            final controllerMyServices = context.watch<MyServicesCubit>();
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
              child: Container(
                child: Skeletonizer(
                  enabled: controllerMyServices.state.status.isLoading?true:false,
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
                          context.pushNamed(DRoutesName.requestCertainService);
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
                                        .state
                                        .services![index]
                                        .nameEn ??
                                    ""
                                : controllerMyServices
                                        .state
                                        .services?[index]
                                        .nameAr ??
                                    "",
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: ColorRes.black),
                          ),
                        ),
                      );
                    },
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
