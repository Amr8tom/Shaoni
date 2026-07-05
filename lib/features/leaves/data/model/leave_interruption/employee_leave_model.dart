import 'package:shaoni/features/leaves/domain/entity/leave_interruption/employee_leave.dart';

class EmployeeLeaveModel extends EmployeeLeave {
  const EmployeeLeaveModel({required super.id, required super.name});

  factory EmployeeLeaveModel.fromJson(Map<String, dynamic> json) {
    return EmployeeLeaveModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
    );
  }
}
