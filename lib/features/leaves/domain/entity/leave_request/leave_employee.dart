import 'package:equatable/equatable.dart';

/// A selectable employee for the "الموظف البديل" (alternative employee) field.
/// Source: GET /Integration/sync-employees
class LeaveEmployee extends Equatable {
  final int id;
  final String name;

  const LeaveEmployee({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
