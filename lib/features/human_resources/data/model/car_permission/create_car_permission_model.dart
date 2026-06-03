import '../../../domain/entity/car_permission/create_car_permission.dart';

class CreateCarPermissionModel extends CreateCarPermission {
  const CreateCarPermissionModel({
    required super.success,
    required super.message,
    required super.requestId,
    required super.data,
  });
  /// from json
  factory CreateCarPermissionModel.fromJson(Map<String, dynamic> json) {
    return CreateCarPermissionModel(
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