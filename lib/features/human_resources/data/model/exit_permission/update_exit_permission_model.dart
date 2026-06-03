import 'package:shaoni/features/human_resources/domain/entity/exit_permission/update_exit_permission.dart';

class UpdateExitPermissionModel extends UpdateExitPermission {
  const UpdateExitPermissionModel({
    required super.success,
    required super.message,
    required super.requestId,
    required super.data,
  });

  factory UpdateExitPermissionModel.fromJson(Map<String, dynamic> json) {
    return UpdateExitPermissionModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      requestId: json['requestId'] ?? 0,
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'requestId': requestId,
      'data': data,
    };
  }
}
