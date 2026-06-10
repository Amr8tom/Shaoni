import '../../../domain/entity/salary_requests/salary_sub_type.dart';

class SalarySubTypeModel extends SalarySubType {
  const SalarySubTypeModel({
    required super.id,
    required super.code,
    required super.nameAr,
    required super.nameEn,
  });

  factory SalarySubTypeModel.fromJson(Map<String, dynamic> json) {
    return SalarySubTypeModel(
      id: json['id'] as int,
      code: json['code'] as String,
      nameAr: json['nameAr'] as String,
      nameEn: json['nameEn'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return toJsonFromEntity(this);
  }

  static Map<String, dynamic> toJsonFromEntity(SalarySubType entity) {
    return {
      'id': entity.id,
      'code': entity.code,
      'nameAr': entity.nameAr,
      'nameEn': entity.nameEn,
    };
  }
}
