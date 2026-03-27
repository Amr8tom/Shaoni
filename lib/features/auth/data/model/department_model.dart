import 'package:shaoni/features/auth/domain/entities/department.dart';

class DepartmentModel extends DepartmentEntity {
  DepartmentModel({
    required super.id,
    required super.name,
    required super.parentDepartmentId,
    required super.parentDepartmentName,
  });
  /// fromJson
  factory DepartmentModel.fromJson(Map<String, dynamic>? json) {
    return DepartmentModel(
      id: json?['id'] ?? 0,
      name: json?['name'] ?? '',
      parentDepartmentId: json?['parent_department_id'] ?? '',
        parentDepartmentName: json?['parent_department_name'] ?? '',
    );

  }

  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parent_department_id': parentDepartmentId,
      'parent_department_name': parentDepartmentName,
    };
  }
}
