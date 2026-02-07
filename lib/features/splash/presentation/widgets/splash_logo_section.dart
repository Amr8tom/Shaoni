import 'package:flutter/material.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import '../../../../core/constants/asset_resoures.dart';

class SplashLogoSection extends StatelessWidget {
  const SplashLogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(AssetRes.logoWithName,width: AppSizes.fullWidth*0.8,);
  }
}
