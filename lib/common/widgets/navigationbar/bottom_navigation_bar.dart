import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/device/device_utility.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import '../../../core/constants/asset_resoures.dart';
import '../../../core/constants/colors.dart';
import '../../../core/routing/route_names.dart';
import '../../../features/navigation/presentation/controllers/navigation_cubit.dart';
import '../../../generated/l10n.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<NavigationCubit>();

    final items = [
      _NavItem(
        icon: AssetRes.home,
        activeIcon: AssetRes.activeHome,
        label: S.current.home,
      ),
      _NavItem(
        icon: AssetRes.services,
        activeIcon: AssetRes.services,
        label: S.current.services,
      ),
      _NavItem(
        icon: AssetRes.groups,
        activeIcon: AssetRes.activeGroups,
        label: S.current.myOrders,
      ),
      _NavItem(
        icon: AssetRes.profile,
        activeIcon: AssetRes.activeProfile,
        label: S.current.profile,
      ),
    ];

    return ClipRect(
      clipBehavior: Clip.hardEdge,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Container(
          height: DDeviceUtils.getBottomNavigationBarHeight() * 1.3.sp,
          margin: EdgeInsets.only(bottom: 0),
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.padding / 3,
            vertical: AppSizes.padding / 3,
          ),
          decoration: BoxDecoration(
            color: ColorRes.primary.withOpacity(0.79),
            borderRadius: BorderRadius.all(
              Radius.circular(AppSizes.borderRadiusXXLg * 2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              // if (index == 3) {
              //   return _buildNavItem(
              //     context: context,
              //     item: items[index],
              //     isActive: false,
              //     onTap: () {
              //       context.pushNamed(DRoutesName.profileRoute);
              //     },
              //   );
              // } else {
                final isActive = controller.indx == index;
                return _buildNavItem(
                  context: context,
                  item: items[index],
                  isActive: isActive,
                  onTap: () {
                    context.read<NavigationCubit>().changeIndex(index);
                  },
                );
              // }
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required _NavItem item,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          AnimatedContainer(
            width: AppSizes.widthcontainer / 3.2,
            height: AppSizes.heightcontainer * 0.8,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              // vertical: 10.h,
            ),
            decoration: BoxDecoration(
              color: isActive ? ColorRes.white : Colors.transparent,
              borderRadius: BorderRadius.all(
                Radius.circular(AppSizes.borderRadiusXXLg * 4),
              ),
              boxShadow:
                  isActive
                      ? [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                      : null,
            ),
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 500),
              tween: Tween(begin: 1.0, end: isActive ? 1.15 : 1.0),
              builder: (context, scale, child) {
                return SvgPicture.asset(
                  isActive ? item.activeIcon : item.icon,
                  // height: 200.h,
                  // width: 200.w,
                  colorFilter: ColorFilter.mode(
                    isActive
                        ? ColorRes.primary
                        : Colors.white.withValues(alpha: 0.6),
                    BlendMode.srcIn,
                  ),
                );
              },
            ),
          ),
          Text(
            item.label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color:
                  isActive ? ColorRes.white : ColorRes.white.withOpacity(0.6),
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final String icon;
  final String activeIcon;
  final String label;

  _NavItem({required this.icon, required this.activeIcon, required this.label});
}
