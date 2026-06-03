import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/core/service_locator/service_locator.dart';
import 'package:shaoni/features/human_resources/presentation/controller/outside_working/outside_working_cubit.dart';
import 'package:shaoni/features/human_resources/presentation/outside_working/widget/outside_working_duration_widget.dart';
import 'package:shaoni/features/human_resources/presentation/outside_working/widget/outside_working_employees_widget.dart';
import 'package:shaoni/features/human_resources/presentation/outside_working/widget/outside_working_request_data_widget.dart';
import 'package:shaoni/features/human_resources/presentation/outside_working/widget/outside_working_tasks_widget.dart';
import '../../../../common/widgets/dialogs/custom_dialog_img_title_des.dart';
import '../../../../core/constants/asset_resoures.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../generated/l10n.dart';
import '../widgets/general_request_templates/applicant_data_widget.dart';
import '../widgets/general_request_templates/create_delete_buttons.dart';
import '../widgets/general_request_templates/date_data_widget.dart';

class CreateOutsideWorkingForm extends StatelessWidget {
  final int? requestId;

  const CreateOutsideWorkingForm({super.key, this.requestId});

  bool get _isEditMode => requestId != null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<OutsideWorkingCubit>(),
      child: Scaffold(
        appBar: DAppBar(
          showMenu: false,
          showBackArrow: true,
          title: _isEditMode
              ? S.current.editRequest
              : S.current.outsideWorkingRequest,
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: ColorRes.grey6,
        body: Builder(
          builder: (context) {
            final cubit = context.read<OutsideWorkingCubit>();
            return BlocConsumer<OutsideWorkingCubit, OutsideWorkingState>(
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
                    state.status == OutsideWorkingStatus.lookupsLoading;
                final isSubmitting =
                    state.status == OutsideWorkingStatus.createLoading;

                return Form(
                  key: cubit.requestFormKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.padding * 1.5),
                    child: Stack(
                      children: [
                        /// Scrollable content — skeleton during lookup loading
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
                                const Sizer(height: 35),

                                /// ── بيانات الطلب ──────────────────────────
                                Text(
                                  S.current.requestDetails,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                const Sizer(height: 12),
                                const OutsideWorkingRequestDataWidget(),
                                const Sizer(height: 35),

                                /// ── مدة العمل + الحضور ────────────────────
                                Text(
                                  S.current.duration,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                const Sizer(height: 12),
                                const OutsideWorkingDurationWidget(),
                                const Sizer(height: 35),

                                /// ── الموظفون ───────────────────────────────
                                Text(
                                  S.current.employees,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                const Sizer(height: 12),
                                const OutsideWorkingEmployeesWidget(),
                                const Sizer(height: 35),

                                /// ── المهام (لكل موظف) ───────────────────────
                                if (cubit.selectedEmployees.isNotEmpty) ...[
                                  Text(
                                    '${S.current.tasks} (لكل موظف)',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                  const Sizer(height: 12),
                                  const OutsideWorkingTasksWidget(),
                                ],

                                const Sizer(height: 120),
                              ],
                            ),
                          ),
                        ),

                        /// Bottom action buttons
                        if (!isLookupsLoading)
                          isSubmitting
                              ? const SizedBox.shrink()
                              : CreateDeleteButtons(
                                  deleteTab: () => cubit.resetForm(),
                                  createTab: () {
                                    if (cubit.selectedEmployees.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content:
                                            Text(S.current.selectAtLeastOneEmployee),
                                        backgroundColor:
                                            ColorRes.error.withOpacity(0.5),
                                      ));
                                      return;
                                    }
                                    if (cubit.requestFormKey.currentState!
                                        .validate()) {
                                      cubit.createOutsideWorking();
                                    }
                                  },
                                ),

                        /// Submit overlay
                        if (isSubmitting)
                          Positioned.fill(
                            child: Container(
                              color: ColorRes.black.withOpacity(0.12),
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
