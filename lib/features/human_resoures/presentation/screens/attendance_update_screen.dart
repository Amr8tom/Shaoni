// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shaoni/common/widgets/appbar/appbar.dart';
// import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
// import 'package:shaoni/core/constants/app_sizes.dart';
// import 'package:shaoni/core/constants/colors.dart';
// import 'package:shaoni/core/extentions/navigation_extension.dart';
// import 'package:shaoni/core/service_locator/service_locator.dart';
// import '../../../../common/widgets/dialogs/custom_dialog_img_title_des.dart';
// import '../../../../core/constants/asset_resoures.dart';
// import '../../../../core/routing/route_names.dart';
// import '../../../../generated/l10n.dart';
// import '../controller/attendance/attendance_cubit.dart';
// import '../widgets/applicant_data_widget.dart';
// import '../widgets/create_delete_buttons.dart';
// import '../widgets/date_data_widget.dart';
// import '../widgets/file_upload_widget.dart';
//
// class AttendanceUpdateScreen extends StatelessWidget {
//   const AttendanceUpdateScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => serviceLocator<AttendanceCubit>(),
//       child: Scaffold(
//         appBar: DAppBar(
//           showMenu: false,
//           showBackArrow: true,
//         ),
//         extendBodyBehindAppBar: true,
//         backgroundColor: ColorRes.grey6,
//         body: Builder(
//           builder: (context) {
//             final controller = context.read<AttendanceCubit>();
//             return BlocConsumer<AttendanceCubit,
//                 AttendanceState>(
//               listener: (context, state) {
//                 if (state.isCreateExitPermissionError) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(state.errorMassage ?? "Error"),
//                       backgroundColor: ColorRes.error.withOpacity(0.5),
//                     ),
//                   );
//                 }
//
//                 if (state.isCreateExitPermissionSuccess) {
//                   CustomDialogImgTitleDes(
//                     button1: S.current.myOrders,
//                     button2: S.current.home,
//                     onTab2: () {
//                       /// navigation screen
//                       context.pushNamedAndRemoveUntil(
//                         DRoutesName.navigationMenuRoute,
//                         predicate: (route) => false,
//                       );
//                     },
//                     onTab1: () {
//                       context.pushNamedAndRemoveUntil(
//                         DRoutesName.navigationMenuRoute,
//                         predicate: (route) => false,
//                       );
//                     },
//                     context: context,
//                     title: S.current.requestSentSuccessfully,
//                     des: S.current.requestSentSuccessfully,
//                     imgPath: AssetRes.doubleCorrect,
//                     isSvg: true,
//                   );
//                 }
//               },
//               builder: (context, state) {
//                 return Form(
//                   key: controller.requestFormKey,
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: AppSizes.padding * 1.5),
//                     child: Stack(
//                       children: [
//                         /// Scrollable content
//                         SingleChildScrollView(
//                           physics: const BouncingScrollPhysics(),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Sizer(height: 220),
//
//                               /// date hijri and birthday
//                               const DateDataWidget(),
//
//                               /// make size
//                               const Sizer(height: 35),
//
//                               /// data for request applicant
//                               const ApplicantDataWidget(),
//
//                               /// request data
//                               const Sizer(height: 35),
//                               Text(
//                                 S.current.requestDetails,
//                                 style:
//                                 Theme.of(context).textTheme.headlineMedium,
//                               ),
//
//                               /// tilte
//                               Center(child: Text("بيانات الطلب")),
//                               Column(
//                                 children: [
//                                   Text('نوع الدراسه'),
//                                   Text('الدراسه المطلوبه '),
//                                   Text('الجهه المقذمه للدراسه المطلوبه '),
//                                   Text('الجهه المقذمه للدراسه المطلوبه '),
//                                 ],
//                               ),
//
//                               /// tilte
//                               Center(child: Text("مببرات الطلب")),
//                               Container(
//                                 child: Text("تكست عن مببرات الطلب"),
//                               ),
//
//                               /// tilte
//                               Center(child: Text("مده الدراسه")),
//                               Column(
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text('من تاريخ ميلادي '),
//                                       Text('ميلادي الي تاريخ '),
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text('من تاريخ هجزي '),
//                                       Text('هجري الي تاريخ '),
//                                     ],
//                                   ),
//                                   Text(
//                                       'مده الدراسه: المده محسوبه بالايام والشهور  بناء علي البدايه والنهاريه'),
//                                 ],
//                               ),
//
//                               /// file upload
//                               const Sizer(height: 35),
//                               const FileUploadWidget(),
//
//                               /// Extra space so content doesn't hide behind the floating buttons
//                               const Sizer(height: 120),
//                             ],
//                           ),
//                         ),
//
//                         /// Floating blur buttons at the bottom
//                         state.isCreateExitPermissionLoading
//                             ? CircularProgressIndicator(
//                           color: ColorRes.primary,
//                         )
//                             : CreateDeleteButtons(
//                           deleteTab: () {
//                             print("test delete button");
//                             controller.deleteExitPermissionRequest();
//                           },
//                           createTab: () {
//                             if (controller.requestFormKey.currentState!
//                                 .validate()) {
//                               controller.createExitPermissionRequest();
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
