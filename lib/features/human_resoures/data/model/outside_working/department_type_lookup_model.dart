import 'package:shaoni/features/human_resoures/domain/entity/outside_working/department_type_lookup.dart';

class DepartmentTypeLookupModel extends DepartmentTypeLookup {
  const DepartmentTypeLookupModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
  });

  factory DepartmentTypeLookupModel.fromJson(Map<String, dynamic> json) =>
      DepartmentTypeLookupModel(
        id: json['id'] as int,
        nameAr: json['nameAr'] as String? ?? '',
        nameEn: json['nameEn'] as String? ?? '',
      );
}
