import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/common/widgets/dialogs/custom_dialog_img_title_des.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/asset_resources.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/extensions/navigation_extension.dart';
import 'package:shaoni/core/routing/route_names.dart';
import 'package:shaoni/core/service_locator/service_locator.dart';
import 'package:shaoni/features/booking_managment/presentation/controller/visa_request/visa_request_cubit.dart';
import 'package:shaoni/features/booking_managment/presentation/visa_request/widget/visa_data_widget.dart';
import 'package:shaoni/features/booking_managment/presentation/visa_request/widget/visa_duration_widget.dart';
import 'package:shaoni/features/booking_managment/presentation/visa_request/widget/visa_employees_widget.dart';
import 'package:shaoni/features/human_resources/presentation/widgets/general_request_templates/applicant_data_widget.dart';
import 'package:shaoni/features/human_resources/presentation/widgets/general_request_templates/create_delete_buttons.dart';
import 'package:shaoni/features/human_resources/presentation/widgets/general_request_templates/date_data_widget.dart';
import 'package:shaoni/generated/l10n.dart';

class CreateVisaRequestForm extends StatelessWidget {
  final int? requestId;

  const CreateVisaRequestForm({super.key, this.requestId});

  bool get _isEditMode => requestId != null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<VisaRequestCubit>(),
      child: Scaffold(
        appBar: DAppBar(
          showMenu: false,
          showBackArrow: true,
          title: _isEditMode ? S.current.editRequest : S.current.visaRequest,
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: ColorRes.grey6,
        body: Builder(
          builder: (context) {
            final controller = context.read<VisaRequestCubit>();
            return BlocConsumer<VisaRequestCubit, VisaRequestState>(
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
                  customDialogImgTitleDes(
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
                return Form(
                  key: controller.requestFormKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.padding * 1.5),
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Sizer(height: 220),
                              const DateDataWidget(),
                              const Sizer(height: 35),
                              ApplicantDataWidget(
                                onOfficeChanged: (id, _) {
                                  controller.officeIdController.text =
                                      id.toString();
                                },
                              ),
                              const Sizer(height: 35),
                              const VisaDataWidget(),
                              const Sizer(height: 35),
                              const VisaDurationWidget(),
                              const Sizer(height: 35),
                              const VisaEmployeesWidget(),
                              const Sizer(height: 120),
                            ],
                          ),
                        ),
                        state.status.isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: ColorRes.primary,
                                ),
                              )
                            : CreateDeleteButtons(
                                deleteTab: () => controller.resetForm(),
                                createTab: () => _onSubmit(context, controller),
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

  void _onSubmit(BuildContext context, VisaRequestCubit controller) {
    if (!(controller.requestFormKey.currentState?.validate() ?? false)) {
      return;
    }
    if (controller.state.lines.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.current.selectAtLeastOneEmployee),
          backgroundColor: ColorRes.error.withValues(alpha: 0.5),
        ),
      );
      return;
    }
    if (_isEditMode) {
      controller.updateVisaRequest(requestId: requestId!);
    } else {
      controller.createVisaRequest();
    }
  }
}
