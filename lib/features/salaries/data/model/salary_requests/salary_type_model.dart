import '../../../domain/entity/salary_requests/salary_type.dart';

class SalaryTypeModel extends SalaryType {
  const SalaryTypeModel({
    required super.id,
    required super.code,
    required super.nameAr,
    required super.nameEn,
  });

  factory SalaryTypeModel.fromJson(Map<String, dynamic> json) {
    return SalaryTypeModel(
      id: json['id'] as int,
      code: json['code'] as String,
      nameAr: json['nameAr'] as String,
      nameEn: json['nameEn'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return toJsonFromEntity(this);
  }

  static Map<String, dynamic> toJsonFromEntity(SalaryType entity) {
    return {
      'id': entity.id,
      'code': entity.code,
      'nameAr': entity.nameAr,
      'nameEn': entity.nameEn,
    };
  }
}
