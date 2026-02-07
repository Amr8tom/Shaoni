// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lottie/lottie.dart';
// import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
// import 'package:shaoni/core/constants/app_sizes.dart';
// import 'package:shaoni/core/constants/asset_resoures.dart';
// import 'package:shaoni/core/device/device_utility.dart';
// import 'package:shaoni/core/extentions/navigation_extension.dart';
// import 'package:shaoni/core/local_storage/cache_helper.dart';
// import 'package:shaoni/core/routing/route_names.dart';
// import '../../../../core/constants/colors.dart';
// import '../../../../generated/l10n.dart';
// import '../../../home/presentation/controller/home_cubit.dart';
//
// class CustomSideMenu extends StatelessWidget {
//   const CustomSideMenu({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: Colors.white,
//       width: DDeviceUtils.getScreenWidth(context) / 1.4,
//       child: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Sizer(height: 50),
//               Center(child: Image.asset(AssetRes.sideMenuLogo)),
//               const Sizer(height: 30),
//               SideMenuItem(
//                 icon: AssetRes.homeIcon,
//                 title: S.current.home,
//                 onTap: () {
//                   context.pop();
//                 },
//               ),
//               const Divider(color: ColorRes.grey5, thickness: 1),
//               SideMenuItem(
//                 icon: AssetRes.qrCodeIcon,
//                 title: S.current.qr,
//                 onTap: () {
//                   context.pushNamed(DRoutesName.QRCodeRoute);
//                 },
//               ),
//               const Divider(color: ColorRes.grey5, thickness: 1),
//               SideMenuItem(
//                 icon: AssetRes.supportIcon,
//                 title: S.current.support,
//                 onTap: () {
//                   context.pushNamed(
//                     DRoutesName.requestRoutes,
//                     arguments: {
//                       "requestId":
//                           context.read<HomeCubit>().state.pilgrim?.id ?? '',
//                     },
//                   );
//                 },
//               ),
//               const Divider(color: ColorRes.grey5, thickness: 1),
//               SideMenuItem(
//                 icon: AssetRes.FAQIcon,
//                 title: S.current.faq,
//                 onTap: () {
//                   context.pushNamed(DRoutesName.FAQRoute);
//                 },
//               ),
//               const Divider(color: ColorRes.grey5, thickness: 1),
//               SideMenuItem(
//                 icon: AssetRes.feedbackIcon,
//                 title: S.current.feed,
//                 onTap: () {
//                   context.pushNamed(
//                     DRoutesName.feedbackRoute,
//                     arguments: {
//                       "previousActivity":
//                           context.read<HomeCubit>().state.previousActivities,
//                     },
//                   );
//                 },
//               ),
//               const Divider(color: ColorRes.grey5, thickness: 1),
//
//               SideMenuItem(
//                 icon: AssetRes.deleteAccountIcon,
//                 title: S.current.deleteAccount,
//                 onTap: () {
//                   context.pushNamed(
//                     DRoutesName.deleteAccountRoute,
//
//                   );
//                 },
//               ),
//               const Divider(color: ColorRes.grey5, thickness: 1),
//               SideMenuItem(
//                 icon: AssetRes.logoutIcon,
//                 title: S.current.logout,
//                 onTap: () {
//                   CacheHelper.clearShared();
//                   context.pushNamedAndRemoveUntil(
//                     DRoutesName.loginRoute,
//                     predicate: (route) => false,
//                   );
//                 },
//               ),
//
//               const Sizer(height: 20),
//               Center(
//                 child: Text(
//                   S.current.designDevelopmentBy,
//                   style: Theme.of(
//                     context,
//                   ).textTheme.bodySmall?.copyWith(color: ColorRes.grey),
//                 ),
//               ),
//               const Sizer(height: 2),
//
//               Center(
//                 child: Text(
//                   S.current.ejadDigitalSolutions,
//                   style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: ColorRes.grey,
//                   ),
//                 ),
//               ),
//               const Sizer(height: 16),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class SideMenuItem extends StatelessWidget {
//   final String icon;
//   final String title;
//   final VoidCallback onTap;
//
//   const SideMenuItem({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: EdgeInsets.all(AppSizes.padding / 2),
//         child: Row(
//           children: [
//             const Sizer(width: 10),
//             Image.asset(
//               icon,
//               color: ColorRes.yellow,
//               width: AppSizes.iconLg,
//               height: AppSizes.iconLg,
//             ),
//             const Sizer(width: 8),
//             Text(
//               title,
//               style: Theme.of(
//                 context,
//               ).textTheme.headlineSmall?.copyWith(color: ColorRes.grey2),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
