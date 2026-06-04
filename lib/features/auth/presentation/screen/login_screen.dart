import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/core/extensions/navigation_extension.dart';
import 'package:shaoni/features/auth/presentation/controller/login/login_cubit.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/asset_resources.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../generated/l10n.dart';
import '../widgets/login/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status.isLoggedIn) {
            context.pushNamed(DRoutesName.otpRoute);
          }
          if (state.status.isError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.current.authenticationError),
                backgroundColor: ColorRes.error2.withValues(alpha: 0.5),
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
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
        },
      ),
    );
  }
}
