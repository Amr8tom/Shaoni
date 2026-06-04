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
  const DepartmentModel(
      {required super.id,
      required super.nameEn,
      required super.nameAr,
      required super.parentDepartmentId,
      required super.parentDepartmentName,
      required super.isActive,
      required super.updatedAt,
      required super.isDeleted});

  /// fromJson
  factory DepartmentModel.fromJson(Map<String, dynamic>? json) {
    return DepartmentModel(
      id: json?['id'] ?? 0,
      nameEn: json?['nameEn'] ?? '',
      nameAr: json?['nameAr'] ?? '',
      parentDepartmentId: json?['parent_department_id'] ?? '',
      parentDepartmentName: json?['parent_department_name'] ?? '',
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
      'parent_department_id': parentDepartmentId,
      'parent_department_name': parentDepartmentName,
      'updatedAt': updatedAt,
      'isActive': isActive,
      'isDeleted': isDeleted,
    };
  }
}
