import 'package:shaoni/features/human_resources/domain/entity/medical_insurance/employee_relative.dart';

class EmployeeRelativeModel extends EmployeeRelative {
  const EmployeeRelativeModel({
    required super.id,
    required super.name,
    required super.fullName,
    required super.relationAr,
    required super.relationEn,
  });

  factory EmployeeRelativeModel.fromJson(Map<String, dynamic> json) {
    final relation = json['relation'] as Map<String, dynamic>? ?? {};
    final labels = relation['labels'] as Map<String, dynamic>? ?? {};
    return EmployeeRelativeModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      fullName: json['full_name'] ?? json['fullName'] ?? '',
      relationAr: labels['ar_001'] ?? '',
      relationEn: labels['en_US'] ?? '',
    );
  }
}
