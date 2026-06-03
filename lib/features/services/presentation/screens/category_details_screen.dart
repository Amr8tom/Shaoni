import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shaoni/common/custom_ui.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import '../../../../core/routing/service_route_resolver.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entity/service.dart';
import '../widgets/all_services/service_grid_card.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final String title;
  final List<Service> services;

  const CategoryDetailsScreen(
      {super.key, required this.title, required this.services});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.grey6,
      appBar: DAppBar(
        showBackArrow: true,
        title: title,
        fontSize: AppSizes.fontSizeMd,
        actions: const [],
      ),
      body: SafeArea(
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
                  if (services.isEmpty) {
                    return CustomUI.emptyData(message: S.current.noData);
                  }
                  final service = services[index];
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    columnCount: 2,
                    duration: const Duration(milliseconds: 400),
                    child: ScaleAnimation(
                      scale: 0.95,
                      child: FadeInAnimation(
                        child: ServiceGridCard(
                          service: service,
                          onTap: () => context.pushNamed(
                            ServiceRouteResolver.catalogRouteFor(
                              service.nameEn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )),
      ),
    );
  }

}
