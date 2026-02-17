import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/core/routing/route_names.dart';
import 'package:shaoni/core/widgets/buttons/d_button.dart';

import '../../../../core/device/device_utility.dart';
import '../../../../generated/l10n.dart';
import '../../../navigation/presentation/widgets/custom_navigation_appbar.dart';
import '../controller/request_service_cubit.dart';
import '../widgets/services_information_gridview.dart';

class RequestCertainService extends StatelessWidget {
  const RequestCertainService({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RequestServiceCubit(),
      child: Scaffold(
        backgroundColor: ColorRes.grey6,
        extendBodyBehindAppBar: true,
        appBar: customAppBar(
          showBackArrow: true,
          height: DDeviceUtils.getAppBarHeight() * 3,
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: AppSizes.padding,
            right: AppSizes.padding,
            top: DDeviceUtils.getAppBarHeight() * 3.1,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  S.current.exitPermissionRequest,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold
                  ),),
                const Sizer(height: 16),
                const ServicesInformationGridview(),
                DButton(
                  text: S.current.createRequest,
                  onPressed: () {
                    context.pushNamed(DRoutesName.requestCreateDetails);
                  },
                  size: DButtonSize.large,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
