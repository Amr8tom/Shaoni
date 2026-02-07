import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shaoni/core/device/device_utility.dart';
import '../../../core/constants/asset_resoures.dart';
import '../../../core/constants/colors.dart';
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

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        height: DDeviceUtils.getAppBarHeight()*1.4.sp,
        margin: EdgeInsets.only(bottom: 0),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: ColorRes.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(33.r),
            topRight: Radius.circular(33.r),
          ),
          boxShadow: [
            BoxShadow(
              color: ColorRes.primary.withValues(alpha: 0.4),
              blurRadius: 25,
              offset: const Offset(0, 12),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final isActive = controller.indx == index;
            return _buildNavItem(
              context: context,
              item: items[index],
              isActive: isActive,
              onTap: () => context.read<NavigationCubit>().chnageIndx(index),
            );
          }),
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 18.w : 14.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 300),
              tween: Tween(begin: 1.0, end: isActive ? 1.15 : 1.0),
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: SvgPicture.asset(
                    isActive ? item.activeIcon : item.icon,
                    height: 22.h,
                    colorFilter: ColorFilter.mode(
                      isActive ? ColorRes.primary : Colors.white.withValues(alpha: 0.85),
                      BlendMode.srcIn,
                    ),
                  ),
                );
              },
            ),
            ClipRect(
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                child: isActive
                    ? Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Text(
                          item.label,
                          style: TextStyle(
                            color: ColorRes.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 13.sp,
                            letterSpacing: 0.3,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final String icon;
  final String activeIcon;
  final String label;

  _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

