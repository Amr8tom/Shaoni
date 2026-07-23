part of 'otp_cubit.dart';

enum OtpStatus {
  initial,

  /// resolving the e-mail address the code has to be mailed to
  preparing,

  /// `User/otp/request` in flight
  sending,

  /// the backend accepted the request and mailed a code
  sent,

  /// `User/otp/verify` in flight
  verifying,

  /// the typed code was accepted — the user may enter the app
  verified,

  /// something went wrong; [OtpState.message] holds the backend text
  error,
}

extension OtpStatusX on OtpStatus {
  bool get isPreparing => this == OtpStatus.preparing;

  bool get isSending => this == OtpStatus.sending;

  bool get isSent => this == OtpStatus.sent;

  bool get isVerifying => this == OtpStatus.verifying;

  bool get isVerified => this == OtpStatus.verified;

  bool get isError => this == OtpStatus.error;

  /// any in-flight call — used to lock the buttons
  bool get isBusy =>
      this == OtpStatus.preparing ||
      this == OtpStatus.sending ||
      this == OtpStatus.verifying;
}

class OtpState extends Equatable {
  final OtpStatus status;

  /// address the code was mailed to; empty until it has been resolved
  final String email;

  /// digits currently typed into the boxes
  final String code;

  /// backend message — error text when [status] is error, otherwise the
  /// confirmation returned by `otp/request`
  final String? message;

  /// seconds left before "resend" becomes tappable again (0 = tappable)
  final int resendCooldown;

  const OtpState({
    this.status = OtpStatus.initial,
    this.email = '',
    this.code = '',
    this.message,
    this.resendCooldown = 0,
  });

  bool get isCodeComplete => code.length == OtpCubit.otpLength;

  bool get canResend => resendCooldown == 0 && !status.isBusy;

  OtpState copyWith({
    OtpStatus? status,
    String? email,
    String? code,
    String? message,
    bool clearMessage = false,
    int? resendCooldown,
  }) {
    return OtpState(
      status: status ?? this.status,
      email: email ?? this.email,
      code: code ?? this.code,
      message: clearMessage ? null : (message ?? this.message),
      resendCooldown: resendCooldown ?? this.resendCooldown,
    );
  }

  @override
  List<Object?> get props => [status, email, code, message, resendCooldown];
}
