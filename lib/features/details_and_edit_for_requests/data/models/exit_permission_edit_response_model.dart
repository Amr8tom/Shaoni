import '../../domain/entities/exit_permission/exit_permission.dart';
import '../../domain/entities/exit_permission/exit_permission_edit_response.dart';

class ExitPermissionEditResponseModel extends ExitPermissionEditResponse {
  const ExitPermissionEditResponseModel({
    super.success,
    super.message,
    super.data,
  });

  factory ExitPermissionEditResponseModel.fromJson(Map<String, dynamic> json) {
    return ExitPermissionEditResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? ExitPermission.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}
