import 'package:equatable/equatable.dart';

// "department": {
// "id": 7,
// "name": "الجودة",
// "parent_department_id": "1",
// "parent_department_name": "الإدارة"
// }
class DepartmentEntity extends Equatable {
  final int id;
  final String name;
  final String parentDepartmentId;
  final String parentDepartmentName;

  DepartmentEntity({
    required this.id,
    required this.name,
    required this.parentDepartmentId,
    required this.parentDepartmentName,
  });

  @override
  List<Object?> get props => [];
}
