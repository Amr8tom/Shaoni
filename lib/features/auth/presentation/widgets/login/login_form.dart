import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/features/auth/presentation/controller/login/login_cubit.dart';
import '../../../../../common/widgets/dialogs/show_custom_pop_up.dart';
import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../generated/l10n.dart';
import '../auth_button.dart';
import '../auth_text_filed.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LoginCubit>();
    return Form(
      key: controller.loginFormKey,
      child: Container(
        decoration: BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSizes.borderRadiusXXLg),
            topRight: Radius.circular(AppSizes.borderRadiusXXLg),
          ),
        ),
        width: double.infinity,
        padding: EdgeInsets.only(left: AppSizes.xl, right: AppSizes.xl),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Title
              const Sizer(height: 30),
              Text(
                S.current.login,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
                maxLines: 5,
              ),

              /// make size
              const Sizer(height: 10),

              ///
              AuthTextField(
                validator: Validators.username,
                hint: S.current.userName,
                controller: controller.nameController,
                prefixIcon: const Icon(Icons.person, color: ColorRes.grey),
              ),
              AuthTextField(
                isPassword: true,
                validator: Validators.password,
                hint: S.current.password,
                controller: controller.passwordController,
                prefixIcon: const Icon(
                  Icons.lock_open_sharp,
                  color: ColorRes.grey,
                ),
              ),
              const Sizer(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      showOTPPopUp(
                        context: context,
                        email: 'amr8tom@gmail.com',
                      );
                    },
                    child: Text(
                      S.current.forgetPassword,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(
                            color: ColorRes.black,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
              const Sizer(height: 20),
              controller.state.status.isLoggingIn
                  ? const CircularProgressIndicator(
                      color: ColorRes.primary,
                    )
                  : AuthButton(
                      text: S.current.login,
                      onPressed: () => controller.login(),
                      width: double.infinity,
                      height: AppSizes.buttonHeight,
                      textColor: ColorRes.white,
                      backgroundColor: ColorRes.primary,
                    ),

              const Sizer(height: 24),

              // // ── OR divider ───────────────────────────────────────────────
              // Row(
              //   children: [
              //     Expanded(child: Divider(color: ColorRes.grey.shade300)),
              //     Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 12),
              //       child: Text(
              //         'OR',
              //         style: Theme.of(context).textTheme.bodySmall?.copyWith(
              //               color: ColorRes.grey.shade500,
              //               fontWeight: FontWeight.w500,
              //             ),
              //       ),
              //     ),
              //     Expanded(child: Divider(color: ColorRes.grey.shade300)),
              //   ],
              // ),
              //
              // const Sizer(height: 16),
              //
              // Text(
              //   'or continue with:',
              //   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              //         color: ColorRes.grey.shade700,
              //       ),
              //   textAlign: TextAlign.center,
              // ),
              //
              // const Sizer(height: 20),
              //
              // // ── Social icons ─────────────────────────────────────────────
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     // Google
              //     _SocialLoginButton(
              //       onTap: () {
              //         // TODO: implement Google sign-in
              //       },
              //       child: Image.asset(
              //         'assets/images/pngs/social_images/google-logo.png',
              //         width: 28,
              //         height: 28,
              //       ),
              //     ),
              //     const Sizer(width: 20),
              //     // Apple
              //     _SocialLoginButton(
              //       onTap: () {
              //         // TODO: implement Apple sign-in
              //       },
              //       child: const Icon(
              //         Icons.apple_rounded,
              //         size: 32,
              //         color: ColorRes.black,
              //       ),
              //     ),
              //   ],
              // ),
              //
              // const Sizer(height: 24),

              // ── Don't have an account? Sign Up ───────────────────────────
              GestureDetector(
                onTap: () {
                  // TODO: implement Sign Up navigation
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      const TextSpan(text: "Don't have an account? "),
                      const TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorRes.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Sizer(height: 16),

              // ── Privacy Policy note ───────────────────────────────────────
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: ColorRes.grey),
                  children: [
                    TextSpan(text: S.current.byContinuingYouAgreeToOur),
                    TextSpan(
                      text: S.current.privacyPolicy,
                      style: const TextStyle(
                        color: ColorRes.grey,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),

              const Sizer(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const _SocialLoginButton({required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorRes.grey6,
          border: Border.all(color: ColorRes.grey5),
        ),
        child: Center(child: child),
      ),
    );
  }
}
