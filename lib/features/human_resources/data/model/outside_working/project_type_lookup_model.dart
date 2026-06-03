import 'package:shaoni/features/human_resources/domain/entity/outside_working/project_type_lookup.dart';

class ProjectTypeLookupModel extends ProjectTypeLookup {
  const ProjectTypeLookupModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
  });

  factory ProjectTypeLookupModel.fromJson(Map<String, dynamic> json) =>
      ProjectTypeLookupModel(
        id: json['id'] as int,
        nameAr: json['nameAr'] as String? ?? '',
        nameEn: json['nameEn'] as String? ?? '',
      );
}
