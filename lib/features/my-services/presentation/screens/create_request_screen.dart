import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/device/device_utility.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/core/service_locator/service_locator.dart';
import 'package:shaoni/features/my-services/presentation/widgets/create_delete_buttons.dart';
import 'package:shaoni/features/my-services/presentation/widgets/date_data_widget.dart';
import 'package:shaoni/features/my-services/presentation/widgets/request_data_widget.dart';
import '../../../../common/widgets/dialogs/custom_dialog_img_title_des.dart';
import '../../../../core/constants/asset_resoures.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../generated/l10n.dart';
import '../../../navigation/presentation/widgets/custom_navigation_appbar.dart';
import '../controller/request_services/request_service_cubit.dart';
import '../widgets/applicant_data_widget.dart';

class RequestCreateDetailsScreen extends StatelessWidget {
  const RequestCreateDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<RequestServiceCubit>(),
      child: Scaffold(
        appBar: customAppBar(
          showBackArrow: true,
          height: DDeviceUtils.getAppBarHeight() * 3,
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: ColorRes.grey6,
        body: Builder(
          builder: (context) {
            final controller = context.read<RequestServiceCubit>();
            return Form(
              key: controller.requestFormKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.padding * 1.5),
                child: Stack(
                  children: [
                    /// Scrollable content
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Sizer(height: 220),
              
                          /// date hijri and birthday
                          const DateDataWidget(),
              
                          /// make size
                          const Sizer(height: 35),
              
                          /// data for request applicant
                          const ApplicantDataWidget(),
              
                          /// request data
                          const Sizer(height: 35),
                          Text(
                            S.current.requestDetails,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
              
                          const RequestDataWidget(),
              
                          /// Extra space so content doesn't hide behind the floating buttons
                          const Sizer(height: 120),
                        ],
                      ),
                    ),
              
                    /// Floating blur buttons at the bottom
                      CreateDeleteButtons(
                      deleteTab: () {
                        print("test delete button");
                      },
                      createTab: () {
                        if(controller.requestFormKey.currentState!.validate()){
                          controller.createExitPermissionRequest();
                          CustomDialogImgTitleDes(
                            button1: S.current.myOrders,
                            button2: S.current.home,
                            onTab2: () {
                              /// navigation screen
                              context.pushNamedAndRemoveUntil(
                                DRoutesName.navigationMenuRoute,
                                predicate: (route) => false,
                              );
                            },
                            onTab1: () {
                              context.pushNamedAndRemoveUntil(
                                DRoutesName.navigationMenuRoute,
                                predicate: (route) => false,
                              );
                            },
                            context: context,
                            title: S.current.requestSentSuccessfully,
                            des: S.current.requestSentSuccessfully,
                            imgPath: AssetRes.doubleCorrect,
                            isSvg: true,
                          );
                        }

                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
