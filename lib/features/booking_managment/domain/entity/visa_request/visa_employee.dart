import 'package:equatable/equatable.dart';

/// Domain entity for an employee returned by
/// GET /Integration/sync-employees
class VisaEmployee extends Equatable {
  final int id;
  final String name;
  final String jobTitle;

  const VisaEmployee({
    required this.id,
    required this.name,
    this.jobTitle = '',
  });

  /// Label shown in the employees list, e.g. "Ahmed - Secretary".
  String get displayName => jobTitle.isEmpty ? name : '$name - $jobTitle';

  @override
  List<Object?> get props => [id, name, jobTitle];
}
