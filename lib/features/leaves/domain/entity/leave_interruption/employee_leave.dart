import 'package:equatable/equatable.dart';

/// Domain entity for an approved employee leave returned by
/// GET /Lookup/SearchEmployeeLeaves?leaveTypeId={id}
class EmployeeLeave extends Equatable {
  final int id;
  final String name;

  const EmployeeLeave({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
