import '../../domain/entity/permission_time.dart';

class PermissionTimeModel extends PermissionTime {
  const PermissionTimeModel({
    required super.id,
    super.value,
    super.nameAr,
    super.nameEn,
  });

  /// from json
  factory PermissionTimeModel.fromJson(Map<String, dynamic> json) {
    return PermissionTimeModel(
      id: json['id'] as int? ?? 0,
      value: json['value'] as String?,
      nameAr: json['nameAr'] as String?,
      nameEn: json['nameEn'] as String?,
    );
  }

  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'nameAr': nameAr,
      'nameEn': nameEn,
    };
  }
}
