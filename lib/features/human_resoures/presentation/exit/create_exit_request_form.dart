import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/core/service_locator/service_locator.dart';
import '../../../../common/widgets/dialogs/custom_dialog_img_title_des.dart';
import '../../../../core/constants/asset_resoures.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../generated/l10n.dart';
import '../controller/exit_permission/exit_request_service_cubit.dart';
import '../widgets/general_request_templates/file_upload_widget.dart';
import '../widgets/general_request_templates/applicant_data_widget.dart';
import '../widgets/general_request_templates/create_delete_buttons.dart';
import '../widgets/general_request_templates/date_data_widget.dart';
import 'widgets/request_data_widget.dart';

class ExitRequestDetailsScreen extends StatelessWidget {
  const ExitRequestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<ExitRequestServiceCubit>(),
      child: Scaffold(
        appBar: DAppBar(
          showMenu: false,
          showBackArrow: true,
          title: S.current.exitPermissionRequest,
        ),
        backgroundColor: ColorRes.grey6,
        body: Builder(
          builder: (context) {
            final controller = context.read<ExitRequestServiceCubit>();
            return BlocConsumer<ExitRequestServiceCubit,
                ExitRequestServiceState>(
              listener: (context, state) {
                if (state.isCreateExitPermissionError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMassage ?? "Error"),
                      backgroundColor: ColorRes.error.withOpacity(0.5),
                    ),
                  );
                }

                if (state.isCreateExitPermissionSuccess) {
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
                    // orderNumber: state.successPermission.,
                    imgPath: AssetRes.doubleCorrect,
                    isSvg: true,
                  );
                }
              },
              builder: (context, state) {
                return Form(
                  key: controller.requestFormKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.padding * 1.5),
                    child: Stack(
                      children: [
                        /// Scrollable content
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              const RequestDataWidget(),

                              /// file upload
                              const Sizer(height: 35),
                              FileUploadWidget(
                                onPickedFile: (name, base64) {
                                  controller.attachmentFileController.text =
                                      base64 ?? '';
                                  controller.attachmentFileNameController.text =
                                      name ?? '';
                                },
                              ),

                              /// Extra space so content doesn't hide behind the floating buttons
                              const Sizer(height: 120),
                            ],
                          ),
                        ),

                        /// Floating blur buttons at the bottom
                        state.isCreateExitPermissionLoading
                            ? CircularProgressIndicator(
                                color: ColorRes.primary,
                              )
                            : CreateDeleteButtons(
                                deleteTab: () {
                                  controller.deleteExitPermissionRequest();
                                },
                                createTab: () {
                                  if (controller.requestFormKey.currentState!
                                      .validate()) {
                                    controller.createExitPermissionRequest();
                                  }
                                },
                              ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
