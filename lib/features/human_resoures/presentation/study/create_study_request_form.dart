import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/core/service_locator/service_locator.dart';
import 'package:shaoni/features/human_resoures/presentation/controller/study/study_cubit.dart';
import 'package:shaoni/features/human_resoures/presentation/study/widget/study_request_data_widget.dart';
import '../../../../common/widgets/dialogs/custom_dialog_img_title_des.dart';
import '../../../../core/constants/asset_resoures.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../generated/l10n.dart';
import '../widgets/general_request_templates/file_upload_widget.dart';
import '../widgets/general_request_templates/applicant_data_widget.dart';
import '../widgets/general_request_templates/create_delete_buttons.dart';
import '../widgets/general_request_templates/date_data_widget.dart';

class CreateStudyRequestForm extends StatelessWidget {
  const CreateStudyRequestForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<StudyCubit>(),
      child: Scaffold(
        appBar: DAppBar(
          showMenu: false,
          showBackArrow: true,
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: ColorRes.grey6,
        body: Builder(
          builder: (context) {
            final controller = context.read<StudyCubit>();
            return BlocConsumer<StudyCubit,
                StudyState>(
              listener: (context, state) {
                if (state.isError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage ?? "Error"),
                      backgroundColor: ColorRes.error.withOpacity(0.5),
                    ),
                  );
                }

                if (state.isCreateStudyRequestLoaded) {
                  CustomDialogImgTitleDes(
                    button1: S.current.myOrders,
                    button2: S.current.home,
                    onTab2: () {
                      /// navigation screen
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
                    title: S.current.requestSentSuccessfully,
                    des: S.current.requestSentSuccessfully,
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

                              /// date hijri and birthday
                              const DateDataWidget(),

                              /// make size
                              const Sizer(height: 35),

                              /// data for request applicant
                              const ApplicantDataWidget(),

                              /// request data
                              const Sizer(height: 35),
                              Text(
                                S.current.requestDetails,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),

                              const StudyRequestDataWidget(),


                              /// file upload
                              const Sizer(height: 35),
                              const FileUploadWidget(),

                              /// Extra space so content doesn't hide behind the floating buttons
                              const Sizer(height: 120),
                            ],
                          ),
                        ),

                        /// Floating blur buttons at the bottom
                        state.isCreateStudyRequestLoading
                            ? Center(
                              child: CircularProgressIndicator(
                                  color: ColorRes.primary,
                                ),
                            )
                            : CreateDeleteButtons(
                                deleteTab: () {
                                  controller.deleteStudyRequest();
                                },
                                createTab: () {
                                  if (controller.requestFormKey.currentState!
                                      .validate()) {
                                    controller.createStudyRequest();
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
