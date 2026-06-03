import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shaoni/core/utils/enums/general_status.dart';
import 'package:shaoni/features/home/presentation/controller/home_cubit.dart';
import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/asset_resoures.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';

class StatisticsListView extends StatelessWidget {
  const StatisticsListView({super.key});

  @override
  Widget build(BuildContext context) {
    // List homeStatisticsList = [
    //   _homeStatisticsIcon(
    //     title: S.current.remainingLeaves,
    //     context: context,
    //     color: ColorRes.grey,
    //     count: '7',
    //     imagePath: AssetRes.reminingIcon,
    //   ),
    //   _homeStatisticsIcon(
    //     title: S.current.approvedRequest,
    //     context: context,
    //     color: ColorRes.staticGreenColor,
    //     count: '11',
    //     imagePath: AssetRes.approvedIcon,
    //   ),
    //   _homeStatisticsIcon(
    //     title: S.current.pendingRequest,
    //     context: context,
    //     color: ColorRes.staticBlueColor,
    //     count: '20',
    //     imagePath: AssetRes.waitingIcon,
    //   ),
    //   _homeStatisticsIcon(
    //     title: S.current.rejectedRequest,
    //     context: context,
    //     color: ColorRes.staticYellowColor,
    //     count: '9',
    //     imagePath: AssetRes.rejectedIcon,
    //   ),
    //   _homeStatisticsIcon(
    //     title: S.current.canceledRequest,
    //     context: context,
    //     color: ColorRes.staticRedColor,
    //     count: '3',
    //     imagePath: AssetRes.deletedIcon,
    //   )
    // ];
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: AppSizes.heightcontainerCategories * 2.05,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: state.requestsStatus?.length ?? 0,
            itemBuilder: (context, index) {
              final entry = state.requestsStatus?.entries.elementAt(index);
              final String title = entry?.key ?? '';
              String statusTitle = S.current.remainingLeaves;
              final String count = entry?.value ?? '0';

              // Map titles to existing assets or use a default one
              String imagePath = AssetRes.waitingIcon; // Default
              Color itemColor = ColorRes.grey; // Default

              if (title.toLowerCase().contains('hr')) {
                imagePath = AssetRes.approvedIcon;
                itemColor = ColorRes.staticYellowColor;
                statusTitle = S.current.humanResources;
              } else if (title.toLowerCase().contains('reject')) {
                imagePath = AssetRes.rejectedIcon;
                itemColor = ColorRes.staticYellowColor;
                statusTitle = S.current.rejectedRequest;
              } else if (title.toLowerCase().contains('cancel')) {
                imagePath = AssetRes.deletedIcon;
                itemColor = ColorRes.staticRedColor;
                statusTitle = S.current.canceledRequest;
              } else if (title.toLowerCase().contains('done')) {
                imagePath = AssetRes.approvedIcon;
                itemColor = ColorRes.staticGreenColor;
                statusTitle = S.current.completed;
              }
              else if (title.toLowerCase().contains('new')) {
                imagePath = AssetRes.waitingIcon;
                itemColor = ColorRes.staticBlueColor;
                statusTitle = S.current.pendingRequest;
              }    else if (title.toLowerCase().contains('id')) {
                imagePath = AssetRes.waitingIcon;
                itemColor = ColorRes.staticVioletColor;
                statusTitle = S.current.localeee=="en"?title:"إضافة وثيقة ثبوتية";
              }  else if (title.toLowerCase().contains('manager')) {
                imagePath = AssetRes.waitingIcon;
                itemColor = ColorRes.staticVioletColor;
                statusTitle = S.current.localeee=="en"?title:"إضافة وثيقة ثبوتية";
              }

              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  duration: const Duration(milliseconds: 300),
                  horizontalOffset: AppSizes.paddingHorizontallyContainer,
                  child: _homeStatisticsIcon(
                      context: context,
                      count: count,
                      title: statusTitle,
                      imagePath: imagePath,
                      color: itemColor),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Sizer(width: 10);
            },
          ),
        );
      },
      listener: (BuildContext context, HomeState state) {
        if (state.status.isSuccess) {
          print("======================================================");
          print("======================================================");
          print("======================================================");
          print("======================================================");
          print(state.requestsStatus?.length);
          print(state.allStatusCounts?.length);
          print(state.allStatusCounts?.length);
          print(state.allStatusCounts?.length);
          print(state.allStatusCounts?.length);
          print(state.allStatusCounts?.length);
          print(state.allStatusCounts?.length);
          print(state.allStatusCounts?.length);
          print(state.allStatusCounts?.length);
          print(state.allStatusCounts?.length);
          print(state.allStatusCounts?.length);
          print(state.allStatusCounts?.length);
          print(state.allStatusCounts?.length);
          print(state.allStatusCounts?.length);
          print(state.allStatusCounts?.length);
          print(state.allStatusCounts?.length);
          print(state.allStatusCounts?.length);
          print(state.allStatusCounts?.length);
          print(state.allStatusCounts?.length);
        }
      },
    );
  }

  Widget _homeStatisticsIcon({
    Color color = ColorRes.primary,
    required BuildContext context,
    required String count,
    title,
    required String imagePath,
  }) {
    return Container(
      height: AppSizes.heightcontainer * 1.15,
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
            padding: EdgeInsets.only(
                left: AppSizes.padding, right: AppSizes.padding),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: AppSizes.iconPadding * 2),
                    child: Text(count,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                                color: color,
                                fontSize: AppSizes.fontSizeXXLg * 1.2)),
                  ),
                  const Spacer(),
                  Image.asset(
                    imagePath,
                    color: color,
                    // fit: BoxFit.fitWidth,
                    width: AppSizes.iconXLarge,
                    height: AppSizes.iconXLarge,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: AppSizes.iconPadding / 8,
            child: Padding(
              padding: EdgeInsets.all(AppSizes.padding / 2.5),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: color,
                      fontSize: AppSizes.fontSizeMd * 0.7,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
