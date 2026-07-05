import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/asset_resources.dart';
import 'package:shaoni/core/extensions/navigation_extension.dart';
import 'package:shaoni/core/routing/route_names.dart';
import 'package:shaoni/features/services/presentation/widgets/service_card.dart';

import '../../../../generated/l10n.dart';
import '../controllers/services_cubit.dart';

class ServicesGridView extends StatelessWidget {
  const ServicesGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ServicesCubit>();
    return GridView.count(
      padding: EdgeInsets.all(AppSizes.padding),
      childAspectRatio: 1.1,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      crossAxisCount: 2,
      children: [
        ServiceCard(
            img: AssetRes.repositories,
            onTap: () {
              context.pushNamed(DRoutesName.categoryDetailsRoute, arguments: {
                'title': S.current.repositories,
                'services': controller.state.purchasesServices,
              });
            },
            title: S.current.repositories),
        ServiceCard(
            img: AssetRes.humanResources,
            onTap: () {
              context.pushNamed(DRoutesName.categoryDetailsRoute, arguments: {
                'title': S.current.humanResources,
                'services': controller.state.hrServices,
              });
            },
            title: S.current.humanResources),
        ServiceCard(
            img: AssetRes.salaries,
            onTap: () {
              context.pushNamed(DRoutesName.categoryDetailsRoute, arguments: {
                'title': S.current.salaries,
                'services': controller.state.salariesServices,
              });
            },
            title: S.current.salaries),
        ServiceCard(
            img: AssetRes.registration,
            onTap: () {
              context.pushNamed(DRoutesName.categoryDetailsRoute, arguments: {
                'title': S.current.registration,
                'services': controller.state.reservationsServices,
              });
            },
            title: S.current.registration),
        ServiceCard(
            img: AssetRes.study,
            onTap: () {
              context.pushNamed(DRoutesName.categoryDetailsRoute, arguments: {
                'title': S.current.study,
                'services': controller.state.studyServices,
              });
            },
            title: S.current.study),
        ServiceCard(
            img: AssetRes.leaves,
            onTap: () {
              context.pushNamed(DRoutesName.categoryDetailsRoute, arguments: {
                'title': S.current.leaves,
                'services': controller.state.leavesServices,
              });
            },
            title: S.current.leaves),
      ],

      // physics: const NeverScrollableScrollPhysics(),
      // itemCount: 1,
    );
  }
}
