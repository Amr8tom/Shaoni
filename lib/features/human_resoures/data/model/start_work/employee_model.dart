import '../../../domain/entity/start_work/employee.dart';

class EmployeeModel extends Employee {
  const EmployeeModel({
    required super.id,
    required super.engFullName,
    required super.quadName,
    super.parentId,
    required super.parentName,
    super.departmentId,
    required super.departmentName,
    super.officeId,
    required super.officeName,
    super.jobId,
    required super.jobName,
    required super.isKafeel,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] ?? 0,
      engFullName: json['engFullName'] ?? '',
      quadName: json['quadName'] ?? '',
      parentId: json['parentId'],
      parentName: json['parentName'] ?? '',
      departmentId: json['departmentId'],
      departmentName: json['departmentName'] ?? '',
      officeId: json['officeId'],
      officeName: json['officeName'] ?? '',
      jobId: json['jobId'],
      jobName: json['jobName'] ?? '',
      isKafeel: json['isKafeel'] ?? false,
    );
  }
}
