import 'package:shaoni/features/human_resoures/domain/entity/id_document/department.dart';

class DepartmentModel extends Department {
  const DepartmentModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      // API returns name_ar / name_en (snake_case)
      nameAr: json['name_ar']?.toString() ??
          json['nameAr']?.toString() ??
          json['name']?.toString() ??
          '',
      nameEn: json['name_en']?.toString() ??
          json['nameEn']?.toString() ??
          json['name']?.toString() ??
          '',
    );
  }
}
