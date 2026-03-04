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
        title: S.current.remainingLeaves,
        context: context,
        color: ColorRes.grey,
        count: '7',
        imagePath: AssetRes.reminingIcon,
      ),

      _homeStatisticsIcon(
        title: S.current.approvedRequest,
        context: context,
        color: ColorRes.staticGreenColor,
        count: '11',
        imagePath: AssetRes.approvedIcon,
      ),
  _homeStatisticsIcon(
        title: S.current.pendingRequest,
        context: context,
        color: ColorRes.staticBlueColor,
        count: '20',
        imagePath: AssetRes.waitingIcon,
      ),

      _homeStatisticsIcon(
        title: S.current.rejectedRequest,
        context: context,
        color: ColorRes.staticYellowColor,
        count: '9',
        imagePath: AssetRes.rejectedIcon,
      ),
      _homeStatisticsIcon(
        title: S.current.canceledRequest,
        context: context,
        color: ColorRes.staticRedColor,
        count: '3',
        imagePath: AssetRes.deletedIcon,
      )
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
              duration: const Duration(milliseconds: 300),
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
    required String count,title,
    required String imagePath,
  }) {
    return Container(
      height: AppSizes.heightcontainer*1.15,
      width: AppSizes.widthcontainer * 1.10,
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
            padding:  EdgeInsets.only(left:AppSizes.padding,right: AppSizes.padding,top:AppSizes.iconPadding),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    count,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: color,
                        fontSize: AppSizes.fontSizeXXLg*1.5
                    )
                  ),
               const  Spacer(),
                  Image.asset(
                    imagePath,
                    color: color,
                    // fit: BoxFit.fitWidth,
                    width: AppSizes.iconXLarge ,
                    height: AppSizes.iconXLarge,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: AppSizes.iconPadding/2,
            child: Padding(
              padding: EdgeInsets.all(AppSizes.padding / 2.5),
              child: Text(
               title,
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
