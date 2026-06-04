import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/core/extensions/navigation_extension.dart';
import 'package:shaoni/features/human_resources/presentation/attendance/widget/attendance_request_data_widget.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/dialogs/custom_dialog_img_title_des.dart';
import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/asset_resources.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/routing/route_names.dart';
import '../../../../../core/service_locator/service_locator.dart';
import '../../../../../generated/l10n.dart';
import '../controller/attendance/attendance_cubit.dart';
import '../widgets/general_request_templates/applicant_data_widget.dart';
import '../widgets/general_request_templates/create_delete_buttons.dart';
import '../widgets/general_request_templates/date_data_widget.dart';
import '../widgets/general_request_templates/file_upload_widget.dart';

class CreateAttendanceRequestForm extends StatelessWidget {
  final String attendanceID;
  final int? requestId;

  const CreateAttendanceRequestForm({
    super.key,
    required this.attendanceID,
    this.requestId,
  });

  bool get _isEditMode => requestId != null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<AttendanceCubit>(),
      child: Scaffold(
        appBar: DAppBar(
          showMenu: false,
          showBackArrow: true,
          title: _isEditMode ? S.current.editRequest : S.current.attendance,
        ),
        backgroundColor: ColorRes.grey6,
        body: Builder(
          builder: (context) {
            final controller = context.read<AttendanceCubit>();
            return BlocConsumer<AttendanceCubit, AttendanceState>(
              listener: (context, state) {
                if (state.isSubmitFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage ?? "Error"),
                      backgroundColor: ColorRes.error.withValues(alpha: 0.5),
                    ),
                  );
                }

                if (state.isSubmitSucceeded) {
                  CustomDialogImgTitleDes(
                    button1: S.current.myOrders,
                    button2: S.current.home,
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
                    orderNumber: _isEditMode ? '' : (state.requestNumber ?? ''),
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
                              ApplicantDataWidget(
                                onOfficeChanged: (id, name) {
                                  controller.officeIDController.text =
                                      id.toString();
                                },
                              ),

                              /// request data
                              const Sizer(height: 35),
                              Text(
                                S.current.requestDetails,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              const Sizer(height: 16),

                              /// request data widget (attendance type, reason, forget reason, duration)
                              AttendanceRequestDataWidget(
                                record:
                                    state.records.cast<dynamic>().firstWhere(
                                          (r) => r.id == attendanceID,
                                          orElse: () => null,
                                        ),
                              ),

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
                        state.isSubmitting
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: ColorRes.primary,
                                ),
                              )
                            : CreateDeleteButtons(
                                deleteTab: () {
                                  controller.deleteAttendanceRequest();
                                },
                                createTab: () {
                                  if (controller.requestFormKey.currentState!
                                      .validate()) {
                                    if (_isEditMode) {
                                      controller.updateAttendanceRequest(
                                          requestId: requestId!);
                                    } else {
                                      controller.createAttendanceRequest();
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
