import '../../../domain/entity/start_work/start_work_type.dart';

class StartWorkTypeModel extends StartWorkType {
  const StartWorkTypeModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
  });

  factory StartWorkTypeModel.fromJson(Map<String, dynamic> json) {
    return StartWorkTypeModel(
      id: json['id'] ?? 0,
      nameAr: json['nameAr'] ?? '',
      nameEn: json['nameEn'] ?? '',
    );
  }
}
