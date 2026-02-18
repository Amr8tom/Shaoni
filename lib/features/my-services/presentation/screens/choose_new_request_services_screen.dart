import 'package:flutter/material.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/core/routing/route_names.dart';

import '../../../../core/device/device_utility.dart';
import '../../../../generated/l10n.dart';
import '../../../navigation/presentation/widgets/custom_navigation_appbar.dart';

class ChooseNewRequestServicesScreen extends StatelessWidget {
  const ChooseNewRequestServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DAppBar(
        showBackArrow: true,
      ),
// appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:AppSizes.padding),
        child: Container(
          child: GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 12,
              mainAxisSpacing: 14,
              childAspectRatio: 6,
            ),
            itemCount: requestsCategories.length,
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
                    color: ColorRes.white,
                    borderRadius: BorderRadius.circular(
                      AppSizes.borderRadiusXLg,
                    ),
                  ),
                  child: Text(
                      requestsCategories[index],
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: ColorRes.black
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

List<String> requestsCategories=[

  S.current.leaveRequest,
  S.current.overtimeRequest,
  S.current.fingerprintProofRequest,
  S.current.exitPermissionRequest,
  S.current.schoolPermissionRequest,
  S.current.carPermitRequest,
  S.current.endOfServiceRequest,
  S.current.clearanceRequest,
  S.current.idRenewalRequest

];
