import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/features/auth/presentation/controller/login/login_cubit.dart';
import '../../../../../common/widgets/dialogs/show_custom_pop_up.dart';
import '../../../../../common/widgets/sizeboxs/Sizer.dart';
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
                prefixIcon: Icon(Icons.person, color: ColorRes.grey),
              ),
              AuthTextField(
                isPassword: true,
                validator: Validators.password,
                hint: S.current.password,
                controller: controller.passwordController,
                prefixIcon: Icon(
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
                  ? CircularProgressIndicator(
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
            ],
          ),
        ),
      ),
    );
  }
}
