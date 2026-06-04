import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/extensions/navigation_extension.dart';
import 'package:shaoni/core/service_locator/service_locator.dart';
import 'package:shaoni/features/human_resources/presentation/controller/product_order/product_order_cubit.dart';
import 'package:shaoni/features/human_resources/presentation/product_order/widget/product_order_data_widget.dart';

import '../../../../common/widgets/dialogs/custom_dialog_img_title_des.dart';
import '../../../../core/constants/asset_resources.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../generated/l10n.dart';
import '../widgets/general_request_templates/applicant_data_widget.dart';
import '../widgets/general_request_templates/create_delete_buttons.dart';
import '../widgets/general_request_templates/date_data_widget.dart';

class CreateProductOrderForm extends StatelessWidget {
  final int? requestId;

  const CreateProductOrderForm({super.key, this.requestId});

  bool get _isEditMode => requestId != null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<ProductOrderCubit>(),
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
            final controller = context.read<ProductOrderCubit>();
            return BlocConsumer<ProductOrderCubit, ProductOrderState>(
              listener: (context, state) {
                if (state.status.isError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage ?? S.current.error),
                      backgroundColor: ColorRes.error.withValues(alpha: 0.5),
                    ),
                  );
                }

                if (state.status.isCreateLoaded) {
                  CustomDialogImgTitleDes(
                    button1: S.current.myOrders,
                    button2: S.current.home,
                    orderNumber: _isEditMode ? '' : (state.requestNumber ?? ''),
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

                              /// Applicant info
                              ApplicantDataWidget(
                                onOfficeChanged: (id, officeName) {
                                  controller.officeIdController.text =
                                      id.toString();
                                },
                              ),
                              const Sizer(height: 35),

                              /// Section label
                              Text(
                                S.current.requestDetails,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              const Sizer(height: 16),

                              /// Reason field
                              _LabeledTextArea(
                                label: S.current.reason,
                                hint: S.current.reasonHint,
                                controller: controller.reasonController,
                              ),
                              const Sizer(height: 16),

                              /// General notes field
                              _LabeledTextArea(
                                label: S.current.notes,
                                hint: S.current.notesHint,
                                controller: controller.noteController,
                              ),
                              const Sizer(height: 16),

                              /// Dynamic line items table
                              const ProductOrderDataWidget(),

                              /// Extra space so content clears floating buttons
                              const Sizer(height: 120),
                            ],
                          ),
                        ),

                        /// Loading or submit button
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
                                      controller.updateProductOrder(
                                          requestId: requestId!);
                                    } else {
                                      controller.createProductOrder();
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

// ── Labeled text area ────────────────────────────────────────────────────────

class _LabeledTextArea extends StatelessWidget {
  const _LabeledTextArea({
    required this.label,
    required this.hint,
    required this.controller,
  });

  final String label;
  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const Sizer(height: 6),
        TextFormField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: EdgeInsets.all(AppSizes.padding * 0.75),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              borderSide: BorderSide(color: ColorRes.greyForBorders),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              borderSide: BorderSide(color: ColorRes.greyForBorders),
            ),
            filled: true,
            fillColor: ColorRes.white,
          ),
        ),
      ],
    );
  }
}
