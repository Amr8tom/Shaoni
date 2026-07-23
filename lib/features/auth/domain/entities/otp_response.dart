import 'package:equatable/equatable.dart';

/// Envelope returned by both `User/otp/request` and `User/otp/verify`:
/// `{ "success": bool, "message": String, "error": { code, message }? }`
class OtpResponse extends Equatable {
  final bool success;
  final String message;
  final String? errorCode;

  const OtpResponse({
    required this.success,
    required this.message,
    this.errorCode,
  });

  @override
  List<Object?> get props => [success, message, errorCode];
}
