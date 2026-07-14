import 'package:shaoni/features/human_resources/domain/entity/outside_working/outside_working_employee.dart';

class OutsideWorkingEmployeeModel extends OutsideWorkingEmployee {
  const OutsideWorkingEmployeeModel({
    required super.id,
    required super.name,
    super.departmentId,
    super.jobTitle = '',
  });

  factory OutsideWorkingEmployeeModel.fromJson(Map<String, dynamic> json) {
    // sync-employees returns engFullName/quadName; some endpoints return 'name'
    final id = (json['id'] as num?)?.toInt() ?? 0;
    String name = '';
    if ((json['name'] as String?)?.isNotEmpty == true) {
      name = json['name'] as String;
    } else if ((json['engFullName'] as String?)?.isNotEmpty == true) {
      name = json['engFullName'] as String;
    } else if ((json['quadName'] as String?)?.isNotEmpty == true) {
      name = json['quadName'] as String;
    }

    // department_id is a nested { id, name } object; accept snake and camel case.
    final department = json['department_id'] ?? json['departmentId'];
    final departmentId = department is Map
        ? (department['id'] as num?)?.toInt()
        : (department as num?)?.toInt();

    final jobTitle = (json['job_title'] ?? json['jobTitle']) as String? ?? '';

    return OutsideWorkingEmployeeModel(
      id: id,
      name: name,
      departmentId: departmentId,
      jobTitle: jobTitle,
    );
  }
}
