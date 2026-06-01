import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/core/service_locator/service_locator.dart';
import 'package:shaoni/features/human_resoures/presentation/controller/id_document/id_document_cubit.dart';
import 'package:shaoni/features/human_resoures/presentation/id_document/widget/id_document_request_data_widget.dart';
import 'package:shaoni/features/human_resoures/presentation/id_document/widget/id_document_type_dispatcher_widget.dart';
import '../../../../common/widgets/dialogs/custom_dialog_img_title_des.dart';
import '../../../../core/constants/asset_resoures.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../generated/l10n.dart';
import '../widgets/general_request_templates/applicant_data_widget.dart';
import '../widgets/general_request_templates/create_delete_buttons.dart';
import '../widgets/general_request_templates/date_data_widget.dart';
import '../widgets/general_request_templates/file_upload_widget.dart';

class CreateIDDocumentForm extends StatelessWidget {
  final int? requestId;

  const CreateIDDocumentForm({super.key, this.requestId});

  bool get _isEditMode => requestId != null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<IDDocumentCubit>(),
      child: Scaffold(
        appBar: DAppBar(
          showMenu: false,
          showBackArrow: true,
          title: _isEditMode ? S.current.editRequest : S.current.idRenewalDocument,
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: ColorRes.grey6,
        body: Builder(
          builder: (context) {
            final cubit = context.read<IDDocumentCubit>();
            return BlocConsumer<IDDocumentCubit, IDDocumentState>(
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
                final isLookupsLoading =
                    state.status == IDDocumentStatus.lookupsLoading;
                final isSubmitting =
                    state.status == IDDocumentStatus.createLoading;

                return Form(
                  key: cubit.requestFormKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.padding * 1.5),
                    child: Stack(
                      children: [
                        /// Scrollable content — wrapped in Skeletonizer during lookup loading
                        Skeletonizer(
                          enabled: isLookupsLoading,
                          child: SingleChildScrollView(
                            physics: isLookupsLoading
                                ? const NeverScrollableScrollPhysics()
                                : const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Sizer(height: 220),

                                /// Date section
                                const DateDataWidget(),
                                const Sizer(height: 35),

                                /// Applicant section
                                ApplicantDataWidget(
                                  onOfficeChanged: (id, officeName) {
                                    cubit.officeIdController.text =
                                        id.toString();
                                  },
                                ),

                                /// ── بيانات الطلب ──────────────────────────
                                const Sizer(height: 35),
                                Text(
                                  S.current.requestDetails,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                const Sizer(height: 12),
                                const IDDocumentRequestDataWidget(),

                                /// ── بيانات الوثيقة (new mode only) ────
                                if (cubit.isAddNewMode &&
                                    cubit.documentTypeController.text
                                        .isNotEmpty) ...[
                                  const Sizer(height: 35),
                                  Text(
                                    S.current.documentData,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                  const Sizer(height: 12),
                                  const IDDocumentTypeDispatcherWidget(),
                                ],

                                /// File upload (always shown)
                                const Sizer(height: 35),
                                FileUploadWidget(
                                  onPickedFile: (fileName, base64String) {
                                    cubit.attachmentFileNameController.text =
                                        fileName ?? '';
                                    cubit.attachmentFileController.text =
                                        base64String ?? '';
                                  },
                                ),

                                const Sizer(height: 120),
                              ],
                            ),
                          ),
                        ),

                        /// Bottom action buttons — hidden while submitting
                        if (!isLookupsLoading)
                          isSubmitting
                              ? const SizedBox.shrink()
                              : CreateDeleteButtons(
                                  deleteTab: () => cubit.resetForm(),
                                  createTab: () {
                                    if (cubit.requestFormKey.currentState!
                                        .validate()) {
                                      cubit.createIDDocument();
                                    }
                                  },
                                ),

                        /// Submit loading indicator overlay
                        if (isSubmitting)
                          Positioned.fill(
                            child: Container(
                              color: Colors.black12,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: ColorRes.primary,
                                ),
                              ),
                            ),
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
