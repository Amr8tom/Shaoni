import 'package:shaoni/features/auth/domain/entities/new_password.dart';

class NewPasswordModel extends NewPassword {
  const NewPasswordModel(
      {required super.success, required super.message, required super.error});

  /// from json
  factory NewPasswordModel.fromJson(Map<String, dynamic> json) {
    return NewPasswordModel(
      success: json['success'],
      message: json['message'],
      error: json['error'],
    );
  }

  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'error': error,
    };
  }
}
