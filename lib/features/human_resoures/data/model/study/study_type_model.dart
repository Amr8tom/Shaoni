import '../../../domain/entity/study/study_type.dart';

class StudyTypeModel extends StudyType {
  const StudyTypeModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
    required super.code,
  });

  factory StudyTypeModel.fromJson(Map<String, dynamic> json) {
    return StudyTypeModel(
      id: json['id'] ?? 0,
      nameAr: json['nameAr'] ?? '',
      nameEn: json['nameEn'] ?? '',
      code: json['code'] ?? '',
    );
  }
}
