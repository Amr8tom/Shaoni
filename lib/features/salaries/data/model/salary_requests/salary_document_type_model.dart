import '../../../domain/entity/salary_requests/salary_document_type.dart';

class SalaryDocumentTypeModel extends SalaryDocumentType {
  const SalaryDocumentTypeModel({
    required super.id,
    required super.code,
    required super.nameAr,
    required super.nameEn,
  });

  factory SalaryDocumentTypeModel.fromJson(Map<String, dynamic> json) {
    return SalaryDocumentTypeModel(
      id: json['id'] as int,
      code: json['code'] as String,
      nameAr: json['nameAr'] as String,
      nameEn: json['nameEn'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return toJsonFromEntity(this);
  }

  static Map<String, dynamic> toJsonFromEntity(SalaryDocumentType entity) {
    return {
      'id': entity.id,
      'code': entity.code,
      'nameAr': entity.nameAr,
      'nameEn': entity.nameEn,
    };
  }
}
