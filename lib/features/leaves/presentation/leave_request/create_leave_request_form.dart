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
import 'package:shaoni/features/human_resources/presentation/widgets/general_request_templates/applicant_data_widget.dart';
import 'package:shaoni/features/human_resources/presentation/widgets/general_request_templates/create_delete_buttons.dart';
import 'package:shaoni/features/human_resources/presentation/widgets/general_request_templates/date_data_widget.dart';
import 'package:shaoni/features/human_resources/presentation/widgets/general_request_templates/file_upload_widget.dart';
import 'package:shaoni/features/leaves/presentation/controller/leave_request/leave_request_cubit.dart';
import 'package:shaoni/features/leaves/presentation/leave_request/widget/leave_request_data_widget.dart';
import 'package:shaoni/generated/l10n.dart';

class CreateLeaveRequestForm extends StatelessWidget {
  final int? requestId;

  const CreateLeaveRequestForm({super.key, this.requestId});

  bool get _isEditMode => requestId != null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          serviceLocator<LeaveRequestCubit>()..init(requestId: requestId),
      child: Scaffold(
        appBar: DAppBar(
          showMenu: false,
          showBackArrow: true,
          title:
              _isEditMode ? S.current.editRequest : S.current.leaveRequestTitle,
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: ColorRes.grey6,
        body: Builder(
          builder: (context) {
            final controller = context.read<LeaveRequestCubit>();
            return BlocConsumer<LeaveRequestCubit, LeaveRequestState>(
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
                    onTab1: () => context.pushNamedAndRemoveUntil(
                      DRoutesName.navigationMenuRoute,
                      predicate: (route) => false,
                    ),
                    onTab2: () => context.pushNamedAndRemoveUntil(
                      DRoutesName.navigationMenuRoute,
                      predicate: (route) => false,
                    ),
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                              const LeaveRequestDataWidget(),
                              const Sizer(height: 35),
                              Text(S.current.attachments,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                              const Sizer(height: 16),
                              FileUploadWidget(
                                title: '',
                                onPickedFile: controller.setAttachment,
                              ),
                              const Sizer(height: 120),
                            ],
                          ),
                        ),
                        state.status.isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                    color: ColorRes.primary),
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

  void _onSubmit(BuildContext context, LeaveRequestCubit controller) {
    if (!(controller.requestFormKey.currentState?.validate() ?? false)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.current.pleaseCompleteRequiredFields),
          backgroundColor: ColorRes.error.withValues(alpha: 0.5),
        ),
      );
      return;
    }
    if (_isEditMode) {
      controller.updateLeaveRequest(requestId: requestId!);
    } else {
      controller.createLeaveRequest();
    }
  }
}
