import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/asset_resoures.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';

class StatisticsListView extends StatelessWidget {
  const StatisticsListView({super.key});

  @override
  Widget build(BuildContext context) {
    List homeStatisticsList = [
      _homeStatisticsIcon(
        context: context,
        color: ColorRes.error,
        count: '22',
        imagePath: AssetRes.deletedIcon,
      ),

      _homeStatisticsIcon(
        context: context,
        color: ColorRes.yellow,
        count: '22',
        imagePath: AssetRes.rejectedIcon,
      ),
      _homeStatisticsIcon(
        context: context,
        color: ColorRes.blueColor,
        count: '22',
        imagePath: AssetRes.waitingIcon,
      ),
      _homeStatisticsIcon(
        context: context,
        color: ColorRes.error,
        count: '22',
        imagePath: AssetRes.reminingIcon,
      ),
      _homeStatisticsIcon(
        context: context,
        color: ColorRes.green,
        count: '7',
        imagePath: AssetRes.approvedIcon,
      ),
    ];
    return Container(
      width: double.infinity,
      height: AppSizes.heightcontainerCategories * 2.05,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: homeStatisticsList.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            child: SlideAnimation(
              duration: const Duration(milliseconds: 2000),
              horizontalOffset: AppSizes.paddingHorizontallyContainer,
              child: homeStatisticsList[index],
            ),
          );
          // horizontalOffset: AppSizes.paddingHorizontallyContainer,
          // child: SelectedItemWidget(currentIndex: index)));
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Sizer(width: 10);
        },
      ),
    );
  }

  Widget _homeStatisticsIcon({
    Color color = ColorRes.primary,
    required BuildContext context,
    required String count,
    required String imagePath,
  }) {
    return Container(
      height: AppSizes.heightcontainer,
      width: AppSizes.widthcontainer * 1.15,
      decoration: BoxDecoration(
        color: ColorRes.white,
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizes.borderRadiusLg),
        ),
      ),
      // height: AppSizes.heightcontainer * 1.5,
      // width: AppSizes.widthcontainer * 0.85,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(AppSizes.padding / 1.4),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    count,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: color,
                      fontSize: AppSizes.fontSizeXXLg * 1.3,
                    ),
                  ),
                ),
                const Sizer(width: 30),
                Image.asset(
                  imagePath,
                  color: color,
                  fit: BoxFit.fitWidth,
                  width: AppSizes.xxl * 0.9,
                  height: AppSizes.xxl * 0.9,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.all(AppSizes.padding / 2.5),
              child: Text(
                S.current.deleteAccount,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: color,
                  fontSize: AppSizes.fontSizeMd * 0.85,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
