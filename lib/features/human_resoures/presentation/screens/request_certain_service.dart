import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/core/routing/route_names.dart';
import 'package:shaoni/core/service_locator/service_locator.dart';
import '../../../../core/device/device_utility.dart';
import '../../../../generated/l10n.dart';
import '../controller/request_services/request_service_cubit.dart';
import '../widgets/services_information_gridview.dart';

class RequestCertainService extends StatelessWidget {
  const RequestCertainService({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<RequestServiceCubit>(),
      child: Scaffold(
        backgroundColor: ColorRes.grey6,
        extendBodyBehindAppBar: true,
        appBar: DAppBar(
          showBackArrow: true,),
        body: Padding(
          padding: EdgeInsets.only(
            left: AppSizes.padding,
            right: AppSizes.padding,
            top: DDeviceUtils.getAppBarHeight() * 3.1,
          ),
          child: Stack(
            children: [
              /// Scrollable content
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Sizer(height: 20),

                    Text(
                      S.current.exitPermissionRequest,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Sizer(height: 24),
                    const ServicesInformationGridview(),
                    // Extra space so content doesn't hide behind the button
                    Sizer(
                      height: AppSizes.heightcontainer *7,
                    ),
                  ],
                ),
              ),

              /// Blur button floating above the list
              Positioned(
                left: 10,
                right: 10,
                bottom: AppSizes.padding * 5.5,
                child: GestureDetector(
                  onTap: () {
                    context.pushNamed(DRoutesName.requestCreateDetails);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSizes.xxl),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: Container(
                        height: AppSizes.heightcontainer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppSizes.xxl),
                          ),
                          color: ColorRes.primary.withOpacity(0.7),
                        ),
                        child: Center(
                          child: Text(
                            S.current.createRequest,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: ColorRes.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
