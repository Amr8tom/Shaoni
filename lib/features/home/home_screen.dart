import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/asset_resoures.dart';

import '../../core/constants/colors.dart';
import '../../generated/l10n.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: AppSizes.appBarHeight * 3,

      child: Row(
        children: [
          const Sizer(width: 10),
          _homebannerItem(
            context: context,
            color: ColorRes.black,
            count: '22',
            imagePath: AssetRes.rejectedIcon,
          ),
          const Sizer(width: 10),
          Container(
            height: AppSizes.heightcontainer * 1.5,
            width: AppSizes.widthcontainer * 0.85,
            color: ColorRes.yellow,
          ),
          const Sizer(width: 10),
          Container(
            height: AppSizes.heightcontainer * 1.5,
            width: AppSizes.widthcontainer * 0.85,
            color: ColorRes.yellow,
          ),
        ],
      ),
    );
  }

  Widget _homebannerItem({
    Color color = ColorRes.primary,
    required BuildContext context,
    required String count,
    required String imagePath,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: ColorRes.white,
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizes.borderRadiusLg),
        ),
      ),
      // height: AppSizes.heightcontainer * 1.5,
      // width: AppSizes.widthcontainer * 0.85,
      child: Row(
        children: [
          Image.asset(imagePath, color: color, fit: BoxFit.fitWidth,width: 20,height: 20,),
          Column(
            children: [
              Text(
                count,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: color,
                  fontSize: AppSizes.fontSizeXXLg,
                ),
              ),
              Text(
                S.current.deleteAccount,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: color,
                  fontSize: AppSizes.fontSizeSm,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
