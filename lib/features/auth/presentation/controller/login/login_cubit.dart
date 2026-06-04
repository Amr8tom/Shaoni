import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:shaoni/core/extensions/navigation_extension.dart';
import 'package:shaoni/core/local_storage/cache_helper.dart';
import 'package:shaoni/core/local_storage/cache_keys.dart';
import 'package:shaoni/features/auth/domain/usecases/change_password_use_case.dart';
import 'package:shaoni/features/auth/domain/usecases/login_use_case.dart';

import '../../../../../core/routing/route_names.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;

  /// final SendOtpUseCase _sendOtpUseCase;
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final otpController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final firebaseInstance = FirebaseMessaging.instance;
  final passwordFormKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  LoginCubit(
    this._loginUseCase,
    this._changePasswordUseCase,
  ) : super(LoginState());

  /// login
  Future<void> login() async {
    if (loginFormKey.currentState!.validate()) {
      emit(state.copyWith(status: LoginStatus.loginLoading));
      final result = await _loginUseCase.call(
        params: LoginParams(
          userName: nameController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );
      result.fold(
        (failure) {
          emit(state.copyWith(
            status: LoginStatus.error,
            loginErrorMassage: failure.message,
          ));
        },
        (data) async {
          await CacheHelper.putString(
              key: CacheKeys.token, value: data.accessToken!);
          await CacheHelper.putString(
              key: CacheKeys.userId, value: data.id.toString());
          emit(state.copyWith(
            status: LoginStatus.loggedIn,
            token: data.accessToken,
            userID: data.id,
          ));
        },
      );
    }
  }

  /// change password
  Future<void> changePassword() async {
    if (passwordFormKey.currentState!.validate()) {
      emit(state.copyWith(status: LoginStatus.changePasswordLoading));
      final result = await _changePasswordUseCase.call(
        params: NewPasswordParams(
          newPassword: newPasswordController.text.trim(),
          userID: CacheHelper.getString(key: CacheKeys.userId) ?? '',
        ),
      );
      result.fold(
        (failure) {
          emit(state.copyWith(
            status: LoginStatus.error,
            loginErrorMassage: failure.message,
          ));
        },
        (data) async {
          emit(state.copyWith(
            status: LoginStatus.changePasswordLoaded,
            newPasswordMsg: data.message,
          ));
        },
      );
    }
  }

  void handleSavePassword(BuildContext context) {
    if (passwordFormKey.currentState!.validate()) {
      // Form is valid, proceed with saving password
      context.pushNamedAndRemoveUntil(
        DRoutesName.navigationMenuRoute,
        predicate: (Route<dynamic> route) => false,
      );
    }
  }

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
