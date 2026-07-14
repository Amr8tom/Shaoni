import 'package:equatable/equatable.dart';

class OutsideWorkingEmployee extends Equatable {
  final int id;
  final String name;

  /// Department the employee belongs to. Used to filter the list when the
  /// request is raised for "same department" (`related_department`).
  final int? departmentId;
  final String jobTitle;

  const OutsideWorkingEmployee({
    required this.id,
    required this.name,
    this.departmentId,
    this.jobTitle = '',
  });

  @override
  List<Object?> get props => [id, name, departmentId, jobTitle];
}
