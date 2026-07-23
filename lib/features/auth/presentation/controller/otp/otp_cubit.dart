import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/core/local_storage/session_storage/session_storage.dart';
import 'package:shaoni/features/auth/domain/usecases/request_otp_use_case.dart';
import 'package:shaoni/features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:shaoni/features/navigation/domain/use_cases/get_user_data_use_case.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final RequestOtpUseCase _requestOtpUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  final GetUserDataUseCase _getUserDataUseCase;
  final SessionStorage _sessionStorage;

  /// digits the backend generates (`"code": "545352"`)
  static const int otpLength = 6;

  /// seconds the user has to wait before asking for another code
  static const int resendCooldownSeconds = 60;

  Timer? _cooldownTimer;

  OtpCubit(
    this._requestOtpUseCase,
    this._verifyOtpUseCase,
    this._getUserDataUseCase,
    this._sessionStorage,
  ) : super(const OtpState());

  // ── Bootstrap ──────────────────────────────────────────────────────────────

  /// Resolves the user's e-mail then asks the backend for a first code.
  Future<void> init() async {
    final email = await _resolveEmail();
    if (isClosed) return;
    if (email.isEmpty) {
      // no address to mail the code to — the UI shows its generic error text
      emit(state.copyWith(status: OtpStatus.error, clearMessage: true));
      return;
    }
    emit(state.copyWith(email: email));
    await requestOtp();
  }

  /// The login response carries no e-mail, so fall back to the cached value
  /// and — when that is missing — to the profile endpoint used by navigation.
  Future<String> _resolveEmail() async {
    final cached = _sessionStorage.email;
    if (cached != null && cached.isNotEmpty) return cached;

    emit(state.copyWith(status: OtpStatus.preparing, clearMessage: true));
    final userId = _sessionStorage.userId;
    if (userId == null || userId.isEmpty || userId == 'null') return '';

    final result = await _getUserDataUseCase.call(
      params: GetUserDataParams(id: userId),
    );
    return result.fold(
      (failure) => '',
      (user) {
        final email = user.email ?? '';
        if (email.isNotEmpty) _sessionStorage.saveEmail(email);
        return email;
      },
    );
  }

  // ── Request / resend ───────────────────────────────────────────────────────

  Future<void> requestOtp() async {
    if (state.email.isEmpty) return;
    emit(state.copyWith(status: OtpStatus.sending, clearMessage: true));

    final result = await _requestOtpUseCase.call(
      params: RequestOtpParams(email: state.email),
    );
    if (isClosed) return;

    result.fold(
      (failure) => emit(state.copyWith(
        status: OtpStatus.error,
        message: failure.message,
      )),
      (response) {
        if (response.success) {
          emit(state.copyWith(
            status: OtpStatus.sent,
            message: response.message,
          ));
          _startCooldown();
        } else {
          emit(state.copyWith(
            status: OtpStatus.error,
            message: response.message,
          ));
        }
      },
    );
  }

  // ── Verify ─────────────────────────────────────────────────────────────────

  void onCodeChanged(String code) {
    emit(state.copyWith(
      // the backend only accepts Latin digits, so normalise any Arabic-Indic
      // or Persian numerals that slipped in from a localised keyboard
      code: _toEnglishDigits(code),
      // typing again clears the previous "wrong code" text
      status: state.status.isError ? OtpStatus.sent : state.status,
      clearMessage: state.status.isError,
    ));
  }

  /// Maps Arabic-Indic (٠-٩) and Persian (۰-۹) numerals to `0-9`.
  static String _toEnglishDigits(String input) {
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    const persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    var out = input;
    for (var i = 0; i < 10; i++) {
      out = out.replaceAll(arabic[i], '$i').replaceAll(persian[i], '$i');
    }
    return out;
  }

  Future<void> verifyOtp() async {
    if (!state.isCodeComplete || state.email.isEmpty) return;
    emit(state.copyWith(status: OtpStatus.verifying, clearMessage: true));

    final result = await _verifyOtpUseCase.call(
      params: VerifyOtpParams(email: state.email, code: state.code),
    );
    if (isClosed) return;

    result.fold(
      (failure) => emit(state.copyWith(
        status: OtpStatus.error,
        message: failure.message,
      )),
      (response) => emit(
        response.success
            ? state.copyWith(
                status: OtpStatus.verified,
                message: response.message,
              )
            : state.copyWith(
                status: OtpStatus.error,
                message: response.message,
              ),
      ),
    );
  }

  // ── Cooldown ───────────────────────────────────────────────────────────────

  void _startCooldown() {
    _cooldownTimer?.cancel();
    emit(state.copyWith(resendCooldown: resendCooldownSeconds));
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isClosed) {
        timer.cancel();
        return;
      }
      final remaining = state.resendCooldown - 1;
      if (remaining <= 0) timer.cancel();
      emit(state.copyWith(resendCooldown: remaining < 0 ? 0 : remaining));
    });
  }

  @override
  Future<void> close() {
    _cooldownTimer?.cancel();
    return super.close();
  }
}
