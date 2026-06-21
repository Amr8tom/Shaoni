import '../../../domain/entity/loan/kafeel_employee.dart';

class KafeelEmployeeModel extends KafeelEmployee {
  const KafeelEmployeeModel({
    required super.id,
    required super.engFullName,
    required super.quadName,
    super.parentId,
    super.parentName,
    super.departmentId,
    super.departmentName,
    super.officeId,
    super.officeName,
    super.jobId,
    super.jobName,
    required super.isKafeel,
  });

  factory KafeelEmployeeModel.fromJson(Map<String, dynamic> json) {
    return KafeelEmployeeModel(
      id: json['id'] ?? 0,
      engFullName: json['engFullName'] ?? '',
      quadName: json['quadName'] ?? '',
      parentId: json['parentId'],
      parentName: json['parentName'],
      departmentId: json['departmentId'],
      departmentName: json['departmentName'],
      officeId: json['officeId'],
      officeName: json['officeName'],
      jobId: json['jobId'],
      jobName: json['jobName'],
      isKafeel: json['isKafeel'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'engFullName': engFullName,
      'quadName': quadName,
      'parentId': parentId,
      'parentName': parentName,
      'departmentId': departmentId,
      'departmentName': departmentName,
      'officeId': officeId,
      'officeName': officeName,
      'jobId': jobId,
      'jobName': jobName,
      'isKafeel': isKafeel,
    };
  }
}
