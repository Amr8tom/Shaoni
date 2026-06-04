import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';

class SplashBackground extends StatelessWidget {
  final Widget child;

  const SplashBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.fullWidth,
      height: AppSizes.fullHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorRes.primary,
            ColorRes.primary.withValues(alpha: 0.8),
            ColorRes.white.withValues(alpha: 0.1),
          ],
        ),
      ),
      child: child,
    );
  }
}
