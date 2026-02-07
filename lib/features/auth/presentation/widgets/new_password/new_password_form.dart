import 'package:flutter/material.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import '../../../../../common/widgets/dialogs/show_custom_pop_up.dart';
import '../../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/routing/route_names.dart';
import '../../../../../generated/l10n.dart';
import '../auth_button.dart';
import '../auth_text_filed.dart';

class NewPasswordForm extends StatelessWidget {
  const NewPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      // key: context.read<LoginCubit>().loginFormKey,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// Title
            Text(
              S.current.createNewPassword,
              style: Theme
                  .of(
                context,
              )
                  .textTheme
                  .headlineLarge!
                  .copyWith(letterSpacing: 1.2),
              textAlign: TextAlign.center,
              maxLines: 5,
            ),

            ///
            AuthTextField(
              hint: S.current.newPassword,
              controller: TextEditingController(),
              prefixIcon: Icon(Icons.lock_open_sharp, color: ColorRes.grey),
            ),
            AuthTextField(
              hint: S.current.repeatNewPassword,
              controller: TextEditingController(),
              prefixIcon: Icon(Icons.lock_open_sharp, color: ColorRes.grey),
            ),
            const Sizer(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    showOTPPopUp(context: context, email: 'amr8tom@gmail.com');
                  },
                  child: Text(
                    S.current.forgetPassword,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                      color: ColorRes.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const Sizer(height: 20),
            AuthButton(
              text: S.current.saveNewPassword,
              onPressed: () {
                context.pushNamedAndRemoveUntil(DRoutesName.navigationMenuRoute,
                    predicate: (Route<dynamic> route) {
                      return false;
                    });
              },
              width: double.infinity,
              height: AppSizes.buttonHeight,
              textColor: ColorRes.white,
              backgroundColor: ColorRes.primary,
            ),
          ],
        ),
      ),
    );
  }
}
