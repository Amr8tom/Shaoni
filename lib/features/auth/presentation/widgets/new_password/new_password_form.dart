import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/features/auth/presentation/controller/login/login_cubit.dart';
import 'package:shaoni/features/auth/presentation/controller/login/login_cubit.dart';
import '../../../../../common/widgets/dialogs/show_custom_pop_up.dart';
import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/routing/route_names.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../generated/l10n.dart';
import '../auth_button.dart';
import '../auth_text_filed.dart';

class NewPasswordForm extends StatelessWidget {
  const NewPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<LoginCubit>();

    return BlocConsumer<LoginCubit, LoginState>(builder: (context, state) {
      return SafeArea(
        child: Form(
          key: controller.passwordFormKey,
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
                  const Sizer(height: 30),

                  /// Title
                  Text(
                    S.current.newPassword,
                    style: Theme.of(
                      context,
                    )
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontSize: AppSizes.fontSizeLg),
                    textAlign: TextAlign.center,
                    maxLines: 5,
                  ),

                  /// make size
                  const Sizer(height: 10),

                  ///
                  AuthTextField(
                    isPassword: true,
                    validator: Validators.password,
                    hint: S.current.pleaseEnterPassword,
                    controller: controller.newPasswordController,
                    prefixIcon:
                        Icon(Icons.lock_open_sharp, color: ColorRes.grey),
                  ),
                  AuthTextField(
                    isPassword: true,
                    validator: (value) => Validators.confirmPassword(
                      value,
                      controller.newPasswordController.text,
                    ),
                    hint: S.current.repeatNewPassword,
                    controller: controller.confirmPasswordController,
                    prefixIcon:
                        Icon(Icons.lock_open_sharp, color: ColorRes.grey),
                  ),

                  const Sizer(height: 20),
                  state.status.isChangePasswordLoading
                      ? CircularProgressIndicator(
                          color: ColorRes.primary,
                        )
                      : AuthButton(
                          text: S.current.saveNewPassword,
                          onPressed: () => controller.changePassword(),
                          width: double.infinity,
                          height: AppSizes.buttonHeight,
                          textColor: ColorRes.white,
                          backgroundColor: ColorRes.primary,
                        ),
                ],
              ),
            ),
          ),
        ),
      );
    }, listener: (BuildContext context, LoginState state) {
      if (state.status.isChangePasswordSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.newPasswordMsg ?? ''),
          ),
        );
        context.pushNamedAndRemoveUntil(
          DRoutesName.navigationMenuRoute,
          predicate: (Route<dynamic> route) => false,
        );
      }
      if (state.status.isError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.loginErrorMassage ?? ''),
            backgroundColor: ColorRes.error2.withOpacity(0.5),
          ),
        );
      }
    });
  }
}
