import '../../../domain/entity/car_permission/update_car_permission.dart';

class UpdateCarPermissionModel extends UpdateCarPermission {
  const UpdateCarPermissionModel({
    required super.success,
    required super.message,
    required super.requestId,
    required super.data,
  });

  /// from json
  factory UpdateCarPermissionModel.fromJson(Map<String, dynamic> json) {
    return UpdateCarPermissionModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      requestId: json['requestId'] ?? 0,
      data: json['data'],
    );
  }

  /// to json
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'requestId': requestId,
      'data': data,
    };
  }
}
