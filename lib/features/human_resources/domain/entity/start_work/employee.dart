import 'package:equatable/equatable.dart';

/// Domain entity for an employee returned by
/// GET /Lookup/GetEmployees
class Employee extends Equatable {
  final int id;
  final String engFullName;
  final String quadName;
  final int? parentId;
  final String parentName;
  final int? departmentId;
  final String departmentName;
  final int? officeId;
  final String officeName;
  final int? jobId;
  final String jobName;
  final bool isKafeel;

  const Employee({
    required this.id,
    required this.engFullName,
    required this.quadName,
    this.parentId,
    required this.parentName,
    this.departmentId,
    required this.departmentName,
    this.officeId,
    required this.officeName,
    this.jobId,
    required this.jobName,
    required this.isKafeel,
  });

  /// Display name shown in dropdown
  String get displayName => engFullName.isNotEmpty ? engFullName : quadName;

  @override
  List<Object?> get props => [id, engFullName, quadName];
}
