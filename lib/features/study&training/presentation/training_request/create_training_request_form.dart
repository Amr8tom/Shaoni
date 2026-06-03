import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/core/service_locator/service_locator.dart';
import 'package:shaoni/features/study&training/presentation/controller/training_request/training_request_cubit.dart';
import 'package:shaoni/features/study&training/presentation/training_request/widget/training_request_data_widget.dart';
import '../../../../common/widgets/dialogs/custom_dialog_img_title_des.dart';
import '../../../../core/constants/asset_resoures.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../generated/l10n.dart';
import '../../../human_resources/presentation/widgets/general_request_templates/applicant_data_widget.dart';
import '../../../human_resources/presentation/widgets/general_request_templates/create_delete_buttons.dart';
import '../../../human_resources/presentation/widgets/general_request_templates/date_data_widget.dart';
import '../../../human_resources/presentation/widgets/general_request_templates/file_upload_widget.dart';


class CreateTrainingRequestForm extends StatelessWidget {
  final int? requestId;

  const CreateTrainingRequestForm({super.key, this.requestId});

  bool get _isEditMode => requestId != null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<TrainingRequestCubit>(),
      child: Scaffold(
        appBar: DAppBar(
          showMenu: false,
          showBackArrow: true,
          title: _isEditMode ? S.current.editRequest : null,
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: ColorRes.grey6,
        body: Builder(
          builder: (context) {
            final controller = context.read<TrainingRequestCubit>();
            return BlocConsumer<TrainingRequestCubit, TrainingRequestState>(
              listener: (context, state) {
                if (state.status.isError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage ?? S.current.error),
                      backgroundColor: ColorRes.error.withOpacity(0.5),
                    ),
                  );
                }

                if (state.status.isCreateLoaded) {
                  CustomDialogImgTitleDes(
                    button1: S.current.myOrders,
                    button2: S.current.home,
                    orderNumber:
                        _isEditMode ? '' : (state.requestNumber ?? ''),
                    onTab2: () {
                      context.pushNamedAndRemoveUntil(
                        DRoutesName.navigationMenuRoute,
                        predicate: (route) => false,
                      );
                    },
                    onTab1: () {
                      context.pushNamedAndRemoveUntil(
                        DRoutesName.requestRoutes,
                        predicate: (route) => false,
                      );
                    },
                    context: context,
                    title: _isEditMode
                        ? S.current.requestUpdatedSuccessfully
                        : S.current.requestSentSuccessfully,
                    des: _isEditMode
                        ? S.current.requestUpdatedSuccessfully
                        : S.current.requestSentSuccessfully,
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
                              const Sizer(height: 220),

                              /// Date
                              const DateDataWidget(),
                              const Sizer(height: 35),

                              /// Applicant data
                              ApplicantDataWidget(
                                onOfficeChanged: (id, officeName) {
                                  controller.officeIdController.text =
                                      id.toString();
                                },
                              ),

                              /// Request data
                              const Sizer(height: 35),
                              Text(
                                S.current.requestDetails,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium,
                              ),
                              const TrainingRequestDataWidget(),

                              /// File upload
                              const Sizer(height: 35),
                              FileUploadWidget(
                                onPickedFile: (fileName, base64String) {
                                  controller.attachmentFileNameController
                                      .text = fileName ?? '';
                                  controller.attachmentFileController.text =
                                      base64String ?? '';
                                },
                              ),

                              /// Extra space so content clears floating buttons
                              const Sizer(height: 120),
                            ],
                          ),
                        ),

                        /// Floating action buttons
                        state.status.isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: ColorRes.primary,
                                ),
                              )
                            : CreateDeleteButtons(
                                deleteTab: () => controller.resetForm(),
                                createTab: () {
                                  if (controller.requestFormKey.currentState!
                                      .validate()) {
                                    if (_isEditMode) {
                                      controller.updateTrainingRequest(
                                          requestId: requestId!);
                                    } else {
                                      controller.createTrainingRequest();
                                    }
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
