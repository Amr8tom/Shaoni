import '../../../domain/entity/start_work/employee_leave_type.dart';

class EmployeeLeaveTypeModel extends EmployeeLeaveType {
  const EmployeeLeaveTypeModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
  });

  factory EmployeeLeaveTypeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeLeaveTypeModel(
      id: json['id'] as int? ?? 0,
      nameAr: (json['name_ar'] ?? json['name_en'] ?? '').toString(),
      nameEn: (json['name_en'] ?? json['name_ar'] ?? '').toString(),
    );
  }
}
