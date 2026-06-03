import 'package:shaoni/features/human_resoures/domain/entity/outside_working/outside_working_employee.dart';

class OutsideWorkingEmployeeModel extends OutsideWorkingEmployee {
  const OutsideWorkingEmployeeModel({
    required super.id,
    required super.name,
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
    return OutsideWorkingEmployeeModel(id: id, name: name);
  }
}
