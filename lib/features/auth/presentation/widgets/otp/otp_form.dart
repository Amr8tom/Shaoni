import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:shaoni/core/extensions/navigation_extension.dart';

import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/routing/route_names.dart';
import '../../../../../core/utils/helpers/arabic_to_english_number_formatter.dart';
import '../../../../../generated/l10n.dart';
import '../../controller/otp/otp_cubit.dart';
import '../auth_button.dart';

class OtpForm extends StatelessWidget {
  const OtpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpState>(
      listenWhen: (prev, curr) =>
          prev.status != curr.status || prev.message != curr.message,
      listener: (context, state) {
        if (state.status.isVerified) {
          context.pushNamedAndRemoveUntil(
            DRoutesName.navigationMenuRoute,
            predicate: (route) => false,
          );
          return;
        }
        if (state.status.isSent && (state.message?.isNotEmpty ?? false)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message!),
              backgroundColor: ColorRes.primary.withValues(alpha: 0.7),
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<OtpCubit>();
        return Container(
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
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
                maxLines: 5,
              ),
              const Sizer(height: 12),

              /// Description — includes the address the code was mailed to
              Flexible(
                child: Text(
                  state.email.isEmpty
                      ? S.current.enterOtp
                      : '${S.current.enterOtp}\n${state.email}',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: ColorRes.darkGrey,
                        height: 1.5,
                      ),
                  maxLines: 7,
                  textAlign: TextAlign.center,
                ),
              ),
              const Sizer(height: 50),

              /// OTP fields — always left-to-right with English digits,
              /// regardless of the app language
              Directionality(
                textDirection: TextDirection.ltr,
                child: OtpTextField(
                  fieldWidth: AppSizes.xl * 1.4,
                  fieldHeight: AppSizes.xxl * 1.4,
                  numberOfFields: OtpCubit.otpLength,
                  borderColor: state.status.isError
                      ? ColorRes.error
                      : ColorRes.darkerGrey,
                  focusedBorderColor: ColorRes.primary,
                  showFieldAsBox: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    ArabicToEnglishNumberFormatter(),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onCodeChanged: cubit.onCodeChanged,
                  onSubmit: (code) {
                    cubit.onCodeChanged(code);
                    cubit.verifyOtp();
                  },
                ),
              ),

              /// Error message
              if (state.status.isError && (state.message?.isNotEmpty ?? false))
                Padding(
                  padding: EdgeInsets.only(top: AppSizes.sm),
                  child: Text(
                    state.message!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: ColorRes.error,
                        ),
                  ),
                ),

              const Sizer(height: 16),

              /// Resend row
              _ResendRow(state: state, onResend: cubit.requestOtp),

              const Sizer(height: 20),

              /// Verify button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.padding * 2),
                child: AuthButton(
                  text: S.current.sendOtp,
                  isLoading: state.status.isVerifying,
                  isEnabled: state.isCodeComplete,
                  onPressed: () => cubit.verifyOtp(),
                  width: double.infinity,
                  height: AppSizes.buttonHeight,
                  textColor: ColorRes.white,
                  backgroundColor: ColorRes.primary,
                ),
              ),
              const Sizer(height: 12),
            ],
          ),
        );
      },
    );
  }
}

class _ResendRow extends StatelessWidget {
  const _ResendRow({required this.state, required this.onResend});

  final OtpState state;
  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.current.didNotReceiveCode,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorRes.darkGrey,
              ),
        ),
        const Sizer(width: 6),
        if (state.resendCooldown > 0)
          Text(
            '${S.current.resendAfter} ${state.resendCooldown} ${S.current.second}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorRes.grey,
                  fontWeight: FontWeight.w600,
                ),
          )
        else if (state.status.isSending)
          SizedBox(
            width: AppSizes.iconSm,
            height: AppSizes.iconSm,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: ColorRes.primary,
            ),
          )
        else
          GestureDetector(
            onTap: state.canResend ? onResend : null,
            child: Text(
              S.current.resend,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorRes.primary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
      ],
    );
  }
}
