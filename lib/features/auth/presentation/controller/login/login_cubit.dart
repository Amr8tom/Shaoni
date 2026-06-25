import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:shaoni/core/extensions/navigation_extension.dart';
import 'package:shaoni/core/local_storage/session_storage/session_storage.dart';
import 'package:shaoni/features/auth/domain/usecases/change_password_use_case.dart';
import 'package:shaoni/features/auth/domain/usecases/login_use_case.dart';

import 'dart:convert';

import '../../../../../core/routing/route_names.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;
  final SessionStorage _sessionStorage;

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
    this._sessionStorage,
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
      if (isClosed) return;
      result.fold(
        (failure) {
          emit(state.copyWith(
            status: LoginStatus.error,
            loginErrorMassage: failure.message,
          ));
        },
        (data) async {
          await _sessionStorage.saveToken(data.accessToken!);

          // Prefer the id field from the response body; if absent, decode the
          // JWT and use the "sub" claim (which carries the numeric user ID).
          final String resolvedId = _resolveUserId(
            bodyId: data.id,
            token: data.accessToken,
          );
          await _sessionStorage.saveUserId(resolvedId);

          if (isClosed) return;
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
          userID: _sessionStorage.userId ?? '',
        ),
      );
      if (isClosed) return;
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

  /// Returns the user ID as a string.
  /// Prefers [bodyId] if present; otherwise decodes the JWT [token] and reads
  /// the "sub" claim, which the backend sets to the numeric user ID.
  String _resolveUserId({required int? bodyId, required String? token}) {
    if (bodyId != null) return bodyId.toString();

    // Fallback: decode JWT payload (second segment, base64url)
    try {
      if (token != null && token.isNotEmpty) {
        final parts = token.split('.');
        if (parts.length == 3) {
          // base64url → base64 padding
          String payload = parts[1];
          payload += '=' * ((4 - payload.length % 4) % 4);
          final decoded = utf8.decode(base64Url.decode(payload));
          final Map<String, dynamic> claims =
              jsonDecode(decoded) as Map<String, dynamic>;
          final sub = claims['sub'];
          if (sub != null) return sub.toString();
        }
      }
    } catch (_) {
      // If decoding fails for any reason, fall through to the empty fallback
    }

    return ''; // NavigationCubit will handle the empty string safely
  }

  void togglePasswordVisibility() {
    emit(
      state.copyWith(
        status: LoginStatus.initialized,
        isPasswordHidden: !state.isPasswordHidden,
      ),
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    passwordController.dispose();
    otpController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
