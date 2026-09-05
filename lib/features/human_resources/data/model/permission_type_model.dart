import '../../domain/entity/permission_type.dart';

class PermissionTypeModel extends PermissionType {
  const PermissionTypeModel({
    required super.id,
    required super.name,
    super.nameAr,
    super.nameEn,
    required super.maxHours,
    required super.maxLimit,
  });

  factory PermissionTypeModel.fromJson(Map<String, dynamic> json) {
    return PermissionTypeModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String?,
      nameAr: json['nameAr'] as String?,
      nameEn: json['nameEn'] as String?,
      maxHours: json['max_hours'] as int?,
      maxLimit: json['max_limit'] as int?,
    );
  }

  /// to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameAr': nameAr,
      'nameEn': nameEn,
      'max_hours': maxHours,
      'max_limit': maxLimit,
    };
  }
}
