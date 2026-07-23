import 'package:shaoni/features/auth/domain/entities/otp_response.dart';

class OtpResponseModel extends OtpResponse {
  const OtpResponseModel({
    required super.success,
    required super.message,
    super.errorCode,
  });

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    final error = json['error'];
    return OtpResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      errorCode:
          error is Map<String, dynamic> ? error['code'] as String? : null,
    );
  }
}
