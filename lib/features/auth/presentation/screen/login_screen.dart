import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/asset_resoures.dart';
import '../../../../core/constants/colors.dart';
import '../widgets/login/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: ColorRes.error,
      body: Stack(
        children: [
          ///  Background Image - outside SafeArea to extend behind status bar & app bar
          Positioned.fill(
            child: Image.asset(
              AssetRes.backGroundImage,
              width: AppSizes.fullWidth,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),

            Column(
              children: [
                /// Top section with illustration
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.xl,
                      vertical: AppSizes.xl,
                    ),
                    child: Center(
                      child: Image.asset(
                        AssetRes.logoWithName,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                /// Bottom section with text content
                const Expanded(flex: 4, child: LoginForm()),
              ],
            ),

        ],
      ),
    );
  }
}
