import 'package:shaoni/features/human_resoures/domain/entity/outside_working/outside_working_project.dart';

class OutsideWorkingProjectModel extends OutsideWorkingProject {
  const OutsideWorkingProjectModel({
    required super.id,
    required super.name,
  });

  factory OutsideWorkingProjectModel.fromJson(Map<String, dynamic> json) =>
      OutsideWorkingProjectModel(
        id: json['id'] as int,
        name: json['name'] as String? ?? '',
      );
}
