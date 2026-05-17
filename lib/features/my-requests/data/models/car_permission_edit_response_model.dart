import '../../domain/entities/car_permission/car_permission.dart';
import '../../domain/entities/car_permission/car_permission_edit_response.dart';

class CarPermissionEditResponseModel extends CarPermissionEditResponse {
  const CarPermissionEditResponseModel({
    super.success,
    super.message,
    super.data,
  });

  factory CarPermissionEditResponseModel.fromJson(Map<String, dynamic> json) {
    return CarPermissionEditResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? CarPermission.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}
