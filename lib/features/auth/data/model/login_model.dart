import 'package:shaoni/features/auth/domain/entities/login.dart';

class LoginModel extends LoginEntity {
  /// LoginModel constructor
  const LoginModel({
    required super.accessToken,
    required super.id,
    required super.success,
    required super.userName,
    required super.role,
    required super.errors,
  });

  /// from json
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      accessToken: json['data']['accessToken'] ?? '',
      success: json['success'] ?? false,
      userName: json['data']['userName'] ?? '',
      role: json['data']['role'] ?? '',
      id: json['data']['id'] as int?,
      errors: json['error'],
    );
  }

  /// to json
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': 'Login successful',
      'data': {
        'accessToken': accessToken,
        'userName': userName,
        'role': role,
        'id': id,
        'success': success,
      },
      'error': errors,
    };
  }

  // {
  // "success": true,
  // "message": "Login successful",
  // "data": {
  // "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjExMDAiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjExMDAiLCJzdWIiOiIyIiwicm9sZSI6IlVTRVIiLCJqdGkiOiJlMzMxZWM5Zi1mNzRjLTRkNWMtYWY2NS03OWRjNzdkYWJmZDAiLCJuYmYiOjE3NzM1NTk5MDcsImV4cCI6MTc3MzU3NzkwNywiaWF0IjoxNzczNTU5OTA3fQ.UBXhsArhliJGB-m17xXgKN32Ig9uH4hfa5RTRzuNffY",
  // "success": true,
  // "errors": null,
  // "userName": "Ali",
  // "role": "USER"
  // },
  // "error": null
  // }
}
