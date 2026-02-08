import 'package:flutter/material.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/features/home/select_list_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Sizer(height: 160),
        Padding(
          padding: EdgeInsets.all(AppSizes.padding/2),
          child: const SelectListView(),
        ),
      ],
    );
    // return Positioned(
    //   top: AppSizes.appBarHeight * 3,

    // child: Row(
    //   children: [
    //     const Sizer(width: 10),
    //     _homeStatisticsIcon(
    //       context: context,
    //       color: ColorRes.black,
    //       count: '22',
    //       imagePath: AssetRes.deletedIcon,
    //     ),
    //     const Sizer(width: 10),
    //     _homeStatisticsIcon(
    //       context: context,
    //       color: ColorRes.black,
    //       count: '22',
    //       imagePath: AssetRes.rejectedIcon,
    //     ),
    //     const Sizer(width: 10),
    //     _homeStatisticsIcon(
    //       context: context,
    //       color: ColorRes.black,
    //       count: '22',
    //       imagePath: AssetRes.waitingIcon,
    //     ),
    //     const Sizer(width: 10),
    //     _homeStatisticsIcon(
    //       context: context,
    //       color: ColorRes.black,
    //       count: '22',
    //       imagePath: AssetRes.reminingIcon,
    //     ),  const Sizer(width: 10),
    //     _homeStatisticsIcon(
    //       context: context,
    //       color: ColorRes.black,
    //       count: '22',
    //       imagePath: AssetRes.approvedIcon,
    //     ),
    //   ],
    // ),
    // );
  }

  // Widget _homeStatisticsIcon({
  //   Color color = ColorRes.primary,
  //   required BuildContext context,
  //   required String count,
  //   required String imagePath,
  // }) {
  //   return Container(
  //     height: AppSizes.heightcontainer * 1.5,
  //     width: AppSizes.widthcontainer * 0.85,
  //     decoration: BoxDecoration(
  //       color: ColorRes.white,
  //       borderRadius: BorderRadius.all(
  //         Radius.circular(AppSizes.borderRadiusLg),
  //       ),
  //     ),
  //     // height: AppSizes.heightcontainer * 1.5,
  //     // width: AppSizes.widthcontainer * 0.85,
  //     child: Stack(
  //       children: [
  //         Row(
  //           children: [
  //             Image.asset(
  //               imagePath,
  //               color: color,
  //               fit: BoxFit.fitWidth,
  //               width: AppSizes.xxl * 0.9,
  //               height: AppSizes.xxl * 0.9,
  //             ),
  //             const Sizer(width: 15),
  //             Text(
  //               count,
  //               style: Theme.of(context).textTheme.headlineLarge?.copyWith(
  //                 color: color,
  //                 fontSize: AppSizes.fontSizeXXLg,
  //               ),
  //             ),
  //           ],
  //         ),
  //         Positioned(
  //           bottom: 0,
  //           child: Padding(
  //             padding:  EdgeInsets.all(AppSizes.padding/2.5),
  //             child: Text(
  //               S.current.deleteAccount,
  //               style: Theme.of(context).textTheme.headlineLarge?.copyWith(
  //                 color: color,
  //                 fontSize: AppSizes.fontSizeSm*0.7,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
