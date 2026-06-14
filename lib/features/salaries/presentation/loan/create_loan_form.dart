import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/dialogs/custom_dialog_img_title_des.dart';
import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/asset_resources.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/extensions/navigation_extension.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../generated/l10n.dart';
import '../../../human_resources/presentation/widgets/general_request_templates/applicant_data_widget.dart';
import '../../../human_resources/presentation/widgets/general_request_templates/create_delete_buttons.dart';
import '../../../human_resources/presentation/widgets/general_request_templates/date_data_widget.dart';
import '../controller/loan/loan_cubit.dart';
import '../controller/loan/loan_state.dart';
import 'widget/loan_request_data_widget.dart';

class CreateLoanForm extends StatelessWidget {
  final int? requestId;

  const CreateLoanForm({super.key, this.requestId});

  bool get _isEditMode => requestId != null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<LoanCubit>()..fetchLookups(),
      child: Scaffold(
        appBar: DAppBar(
          showMenu: false,
          showBackArrow: true,
          title: _isEditMode ? S.current.editRequest : S.current.loanRequest,
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: ColorRes.grey6,
        body: Builder(
          builder: (context) {
            final controller = context.read<LoanCubit>();
            return BlocConsumer<LoanCubit, LoanState>(
              listener: (context, state) {
                if (state is LoanLookupsError || state is CreateLoanError) {
                  final msg = state is LoanLookupsError
                      ? state.message
                      : (state as CreateLoanError).message;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(msg),
                      backgroundColor: ColorRes.error.withValues(alpha: 0.5),
                    ),
                  );
                }

                if (state is CreateLoanSuccess) {
                  customDialogImgTitleDes(
                    button1: S.current.myOrders,
                    button2: S.current.home,
                    orderNumber: _isEditMode
                        ? ''
                        : (state.response.requestId?.toString() ?? ''),
                    onTab2: () {
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
                final isLookupsLoading = state is LoanLookupsLoading;
                final isSubmitting = state is CreateLoanLoading;

                return Form(
                  key: controller.requestFormKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.padding * 1.5),
                    child: Stack(
                      children: [
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

                                /// date
                                const DateDataWidget(),
                                const Sizer(height: 35),

                                /// applicant
                                ApplicantDataWidget(
                                  onOfficeChanged: (id, officeName) {
                                    controller.officeIdController.text =
                                        id.toString();
                                  },
                                ),

                                /// loan data fields
                                const Sizer(height: 35),
                                Text(
                                  S.current.loanRequestData,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                const Sizer(height: 16),

                                const LoanRequestDataWidget(),

                                /// edit reasons field (only in edit mode)
                                if (_isEditMode) ...[
                                  const Sizer(height: 24),
                                  TextFormField(
                                    controller: controller.noteController,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      hintText: S.current.editReasons,
                                      contentPadding: EdgeInsets.all(
                                          AppSizes.padding * 0.75),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            AppSizes.borderRadiusMd),
                                        borderSide: BorderSide(
                                            color: ColorRes.greyForBorders),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            AppSizes.borderRadiusMd),
                                        borderSide: BorderSide(
                                            color: ColorRes.greyForBorders),
                                      ),
                                      filled: true,
                                      fillColor: ColorRes.white,
                                    ),
                                    validator: (v) =>
                                        (v == null || v.trim().isEmpty)
                                            ? S.current.thisFieldRequired
                                            : null,
                                  ),
                                ],

                                const Sizer(height: 120),
                              ],
                            ),
                          ),
                        ),

                        /// bottom buttons
                        if (!isLookupsLoading)
                          isSubmitting
                              ? const SizedBox.shrink()
                              : CreateDeleteButtons(
                                  deleteTab: () {
                                    controller.clearData();
                                  },
                                  createTab: () {
                                    if (controller.requestFormKey.currentState!
                                        .validate()) {
                                      if (_isEditMode) {
                                        controller
                                            .updateRequestSubmit(requestId!);
                                      } else {
                                        controller.createRequestSubmit();
                                      }
                                    }
                                  },
                                ),

                        /// Submit overlay
                        if (isSubmitting)
                          Positioned.fill(
                            child: Container(
                              color: ColorRes.black.withValues(alpha: 0.12),
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
