import 'package:shaoni/features/leaves/domain/entity/leave_request/leave_employee.dart';

class LeaveEmployeeModel extends LeaveEmployee {
  const LeaveEmployeeModel({required super.id, required super.name});

  factory LeaveEmployeeModel.fromJson(Map<String, dynamic> json) {
    final id = (json['id'] as num?)?.toInt() ?? 0;
    String name = '';
    for (final key in const ['name', 'quad_name', 'eng_Full_name']) {
      final value = json[key];
      if (value is String && value.isNotEmpty) {
        name = value;
        break;
      }
    }
    return LeaveEmployeeModel(id: id, name: name);
  }
}
