import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/features/human_resoures/presentation/car_permission/widget/car_request_data_widget.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/dialogs/custom_dialog_img_title_des.dart';
import '../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/asset_resoures.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/extentions/navigation_extension.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../generated/l10n.dart';
import '../controller/car_permission/car_permission_cubit.dart';
import '../widgets/general_request_templates/applicant_data_widget.dart';
import '../widgets/general_request_templates/create_delete_buttons.dart';
import '../widgets/general_request_templates/date_data_widget.dart';
import '../widgets/general_request_templates/file_upload_widget.dart';

class CreateCarPermissionScreen extends StatelessWidget {
  /// When [requestId] is provided the screen runs in **edit mode** and calls
  /// PUT /CarPermission/update/{requestId} instead of the create endpoint.
  final int? requestId;

  const CreateCarPermissionScreen({super.key, this.requestId});

  bool get _isEditMode => requestId != null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<CarPermissionCubit>(),
      child: Scaffold(
        appBar: DAppBar(
          title:
              _isEditMode ? S.current.editRequest : S.current.carPermitRequest,
          showMenu: false,
          showBackArrow: true,
        ),
        backgroundColor: ColorRes.grey6,
        body: Builder(
          builder: (context) {
            final controller = context.read<CarPermissionCubit>();
            return BlocConsumer<CarPermissionCubit, CarPermissionState>(
              listener: (context, state) {
                /// ── Errors ──────────────────────────────────────────────────
                if (state.isError ||
                    state.isCreateRequestError ||
                    state.isUpdateRequestError ||
                    state.isBrandsError ||
                    state.isColorsError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage ?? S.current.error),
                      backgroundColor: ColorRes.error.withOpacity(0.5),
                    ),
                  );
                }

                /// ── Create success ───────────────────────────────────────────
                if (state.isCreateRequestLoaded) {
                  CustomDialogImgTitleDes(
                    button1: S.current.myOrders,
                    button2: S.current.home,
                    orderNumber: state.requestNumber ?? '',
                    onTab2: () => context.pushNamedAndRemoveUntil(
                      DRoutesName.navigationMenuRoute,
                      predicate: (route) => false,
                    ),
                    onTab1: () => context.pushNamedAndRemoveUntil(
                      DRoutesName.navigationMenuRoute,
                      predicate: (route) => false,
                    ),
                    context: context,
                    title: S.current.requestSentSuccessfully,
                    des: S.current.requestSentSuccessfully,
                    imgPath: AssetRes.doubleCorrect,
                    isSvg: true,
                  );
                }

                /// ── Update success ───────────────────────────────────────────
                if (state.isUpdateRequestLoaded) {
                  CustomDialogImgTitleDes(
                    button1: S.current.myOrders,
                    button2: S.current.home,
                    orderNumber: state.requestNumber ?? '',
                    onTab2: () => context.pushNamedAndRemoveUntil(
                      DRoutesName.navigationMenuRoute,
                      predicate: (route) => false,
                    ),
                    onTab1: () => context.pushNamedAndRemoveUntil(
                      DRoutesName.navigationMenuRoute,
                      predicate: (route) => false,
                    ),
                    context: context,
                    title: S.current.requestUpdatedSuccessfully,
                    des: S.current.requestUpdatedSuccessfully,
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
                      horizontal: AppSizes.padding * 1.5,
                    ),
                    child: Stack(
                      children: [
                        /// Scrollable content
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Date — gregorian + hijri
                              const DateDataWidget(),
                              const Sizer(height: 35),

                              /// Applicant data — name / unit / location
                              ApplicantDataWidget(
                                onOfficeChanged: (id, officeName) {
                                  controller.officeIdController.text =
                                      id.toString();
                                },
                              ),
                              const Sizer(height: 35),

                              /// Request details title
                              Text(
                                S.current.requestDetails,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              const Sizer(height: 16),

                              /// Brand / color / plate number
                              const CarRequestDataWidget(),
                              const Sizer(height: 35),

                              /// File upload — base64 saved to the cubit
                              FileUploadWidget(
                                onPickedFile: (fileName, base64String) {
                                  controller.attachmentFileNameController.text =
                                      fileName ?? '';
                                  controller.attachmentFileController.text =
                                      base64String ?? '';
                                },
                              ),

                              /// Extra space so content doesn't hide
                              /// behind the floating buttons.
                              const Sizer(height: 120),
                            ],
                          ),
                        ),

                        /// Floating create / update / delete buttons
                        state.isSubmitting
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: ColorRes.primary,
                                ),
                              )
                            : CreateDeleteButtons(
                                deleteTab: () =>
                                    controller.deleteCarPermissionRequest(),
                                createTab: () {
                                  if (controller.requestFormKey.currentState!
                                      .validate()) {
                                    if (_isEditMode) {
                                      controller.updateCarPermissionRequest(
                                          requestId: requestId!);
                                    } else {
                                      controller.createCarPermissionRequest();
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
