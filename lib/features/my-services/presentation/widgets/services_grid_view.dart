import 'package:flutter/material.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/asset_resoures.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/core/routing/route_names.dart';
import 'package:shaoni/features/my-services/presentation/widgets/service_card.dart';
import '../../../../generated/l10n.dart';

class ServicesGridView extends StatelessWidget {
  const ServicesGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GridView.count(
      padding: EdgeInsets.all(AppSizes.padding),
      childAspectRatio: 1.1,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      crossAxisCount: 2,
      children: [
        ServiceCard(img: AssetRes.repositories, onTap: () {
          context.pushNamed(DRoutesName.noDataRoute);
        }, title: S.current.repositories),
        ServiceCard(img: AssetRes.humanResources, onTap: () {
          context.pushNamed(DRoutesName.chooseNewRequestNewService);
        }, title: S.current.humanResources),
        ServiceCard(img: AssetRes.salaries, onTap: () {
          context.pushNamed(DRoutesName.noDataRoute);
        }, title: S.current.salaries),
        ServiceCard(img: AssetRes.registration, onTap: () {
          context.pushNamed(DRoutesName.noDataRoute);
        }, title: S.current.registration),
        ServiceCard(img: AssetRes.study, onTap: () {
          context.pushNamed(DRoutesName.noDataRoute);
        }, title: S.current.study),
      ],

      // physics: const NeverScrollableScrollPhysics(),
      // itemCount: 1,
    );
  }
}
