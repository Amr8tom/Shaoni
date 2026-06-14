import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../controller/salary_requests/salary_requests_cubit.dart';
import '../controller/salary_requests/salary_requests_state.dart';
import 'widget/salary_request_data_widget.dart';

class CreateSalaryRequestForm extends StatelessWidget {
  final int? requestId;

  const CreateSalaryRequestForm({super.key, this.requestId});

  bool get _isEditMode => requestId != null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          serviceLocator<SalaryRequestsCubit>()..fetchLookups(),
      child: Scaffold(
        appBar: DAppBar(
          showMenu: false,
          showBackArrow: true,
          title: _isEditMode
              ? S.current.editRequest
              : S.current.salaryTransferRequest,
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: ColorRes.grey6,
        body: Builder(
          builder: (context) {
            final controller = context.read<SalaryRequestsCubit>();
            return BlocConsumer<SalaryRequestsCubit, SalaryRequestsState>(
              listener: (context, state) {
                if (state is SalaryRequestsError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: ColorRes.error.withValues(alpha: 0.5),
                    ),
                  );
                }

                if (state is CreateSalaryRequestSuccess) {
                  customDialogImgTitleDes(
                    button1: S.current.myOrders,
                    button2: S.current.home,
                    orderNumber: _isEditMode
                        ? ''
                        : (state.response.salaryRequestName ?? ''),
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
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
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

                              /// request data fields
                              const Sizer(height: 35),
                              Text(
                                S.current.requestDetails,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              const Sizer(height: 16),

                              const SalaryRequestDataWidget(),

                              const Sizer(height: 120),
                            ],
                          ),
                        ),

                        /// bottom buttons
                        state is CreateSalaryRequestLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: ColorRes.primary,
                                ),
                              )
                            : CreateDeleteButtons(
                                deleteTab: () {
                                  controller.clearData();
                                },
                                createTab: () {
                                  if (controller.requestFormKey.currentState!
                                      .validate()) {
                                    if (_isEditMode) {
                                      controller.updateRequestSubmit(
                                          requestId: requestId!);
                                    } else {
                                      controller.createRequestSubmit();
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
