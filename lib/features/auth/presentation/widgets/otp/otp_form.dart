import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import '../../../../../common/widgets/dialogs/show_custom_pop_up.dart';
import '../../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/routing/route_names.dart';
import '../../../../../generated/l10n.dart';
import '../auth_button.dart';
import '../auth_text_filed.dart';

class OtpForm extends StatelessWidget {
  const OtpForm({super.key});

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
              S.current.otp,
              style: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(letterSpacing: 1.2),
              textAlign: TextAlign.center,
              maxLines: 5,
            ),

            /// Description
            Flexible(
              child: Text(
                S.current.enterOtp,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: ColorRes.darkGrey,
                  height: 1.5,
                ),
                maxLines: 7,
                textAlign: TextAlign.center,
              ),
            ),

            /// make size
            const Sizer(height: 20),

            /// OTP fields
            OtpTextField(
              fieldWidth: AppSizes.xl*1.6,
              fieldHeight: AppSizes.xxl*1.1,
              numberOfFields: 5,
              borderColor: ColorRes.darkerGrey,
              showFieldAsBox: true,
              onCodeChanged: (String code) {},
              onSubmit: (String verificationCode) {
                // context.read<LoginCubit>().otpController.text =
                //     verificationCode;
                // context.read<LoginCubit>().checkOtp(otpID: otpId);
              }, // end onSubmit
            ),
            const Sizer(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.padding*2),
              child: AuthButton(
                text: S.current.sendOtp,
                onPressed: () {
                  context.pushNamed(DRoutesName.addNewPasswordRoute);
                  // context.read<LoginCubit>().loginPilgrim();
                  // OtpInput(length: 2, onCompleted: (String ) {  },);
                },
                width: double.infinity,
                height: AppSizes.buttonHeight,
                textColor: ColorRes.white,
                backgroundColor: ColorRes.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
