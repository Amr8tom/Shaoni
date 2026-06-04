import 'package:shaoni/features/auth/domain/entities/department.dart';

// "department": {
// "id": 7,
//                "nameEn": "الجودة",
//                "nameAr": "الجودة",
//                "parent_department_id": "1",
//                "parent_department_name": "Administration",
//                "parent_department_name_ar": "الإدارة",
//                "isActive": true,
//                "updatedAt": "2026-03-18T11:32:44.9581155",
//                "isDeleted": false
// }
class DepartmentModel extends DepartmentEntity {
  DepartmentModel(
      {required super.id,
      required super.nameEn,
      required super.nameAr,
      required super.parent_department_id,
      required super.parent_department_name,
      required super.isActive,
      required super.updatedAt,
      required super.isDeleted});

  /// fromJson
  factory DepartmentModel.fromJson(Map<String, dynamic>? json) {
    return DepartmentModel(
      id: json?['id'] ?? 0,
      nameEn: json?['nameEn'] ?? '',
      nameAr: json?['nameAr'] ?? '',
      parent_department_id: json?['parent_department_id'] ?? '',
      parent_department_name: json?['parent_department_name'] ?? '',
      updatedAt: json?['updatedAt'] ?? '',
      isActive: json?['isActive'] ?? '',
      isDeleted: json?['isDeleted'] ?? '',
    );
  }

  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameEn': nameEn,
      'nameAr': nameAr,
      'parent_department_id': parent_department_id,
      'parent_department_name': parent_department_name,
      'updatedAt': updatedAt,
      'isActive': isActive,
      'isDeleted': isDeleted,
    };
  }
}
