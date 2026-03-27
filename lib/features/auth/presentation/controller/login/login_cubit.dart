import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:shaoni/core/local_storage/cache_helper.dart';
import 'package:shaoni/core/local_storage/cache_keys.dart';
import 'package:shaoni/features/auth/domain/usecases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  // final SendOtpUseCase _sendOtpUseCase;
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final otpController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final firebaseInstance = FirebaseMessaging.instance;

  LoginCubit(
    this._loginUseCase,
  ) : super(LoginState());

  Future<void> login() async {
    if (loginFormKey.currentState!.validate()) {
      emit(state.copyWith(status: LoginStatus.loginLoading));
      final result = await _loginUseCase.call(
        params: LoginParams(
          userName: nameController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );
      print(result);
      print('================================');
      result.fold(
        (failure) => emit(
          state.copyWith(
            status: LoginStatus.error,
            loginErrorMassage: failure.message,
          ),
        ),
        (data) async {
          await CacheHelper.putString(key: CacheKeys.token, value: data.accessToken!);
          await CacheHelper.putString(key: CacheKeys.userId, value: data.id.toString());
            emit(
            state.copyWith(status: LoginStatus.loggedIn, token: data.accessToken, userID: data.id),
          );
        },
      );
    }
  }

  // Future<void> checkOtp({required String otpID}) async {
  //   emit(state.copyWith(status: LoginStatus.sendingOTP));
  //   String? firebaseToken = await firebaseInstance.getToken();
  //   debugPrint("Firebase Messaging Token: $firebaseToken");
  //   FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
  //     debugPrint("New Token: $newToken");
  //     firebaseToken = newToken;
  //   });
  //   final result = await _sendOtpUseCase.call(
  //     params: SendOtpParams(
  //       otp: otpController.text.trim(),
  //       id: otpID,
  //       firebaseToken: firebaseToken ?? '',
  //     ),
  //   );
  //   result.fold(
  //     (failure) {
  //       emit(
  //         state.copyWith(
  //           status: LoginStatus.error,
  //           loginErrorMassage: failure.message,
  //         ),
  //       );
  //       print(failure.message);
  //     },
  //     (data) {
  //       emit(
  //         state.copyWith(
  //           status: LoginStatus.otpCorrect,
  //           token: data.token,
  //           otpId: otpID,
  //         ),
  //       );
  //       CacheHelper.putString(key: CacheKeys.token, value: data.token);
  //     },
  //   );
  // }

  // Future<void> resendOtp() async {
  //   emit(state.copyWith(status: LoginStatus.reSendingOTP));
  //   final result = await _resendOtpUseCase.call(
  //     params: ResendOTPParams(otpId: state.otpId ?? ''),
  //   );
  //   result.fold(
  //     (failure) => emit(state.copyWith(status: LoginStatus.error)),
  //     (data) => emit(state.copyWith(status: LoginStatus.otpVerified)),
  //   );
  // }

  // bool isTokenValid() {
  //   final token = CacheHelper.getString(key: CacheKeys.token);
  //   if (token == null) return false;
  //
  //   try {
  //     final parts = token.split('.');
  //     if (parts.length != 3) return false;
  //
  //     final payload = json.decode(
  //       utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
  //     );
  //
  //     final expiry = DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
  //     return DateTime.now().isBefore(expiry);
  //   } catch (e) {
  //     return false;
  //   }
  // }

  void togglePasswordVisibility() {
    emit(
      state.copyWith(
        status: LoginStatus.initialized,
        isPasswordHidden: !state.isPasswordHidden,
      ),
    );
  }

  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    otpController.dispose();
    super.close();
  }
}
