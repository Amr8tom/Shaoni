import '../../domain/entity/permission_type.dart';

class PermissionTypeModel extends PermissionType {
  PermissionTypeModel({
    required super.id,
    required super.name,
    required super.maxHours,
    required super.maxLimit,
  });

  factory PermissionTypeModel.fromJson(Map<String, dynamic> json) {
    return PermissionTypeModel(
      id: json['id'],
      name: json['name'],
      maxHours: json['max_hours'],
      maxLimit: json['max_limit'],
    );
  }

  /// to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'max_hours': maxHours,
      'max_limit': maxLimit,
    };
  }
}
