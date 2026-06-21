import 'package:equatable/equatable.dart';

class KafeelEmployee extends Equatable {
  final int id;
  final String engFullName;
  final String quadName;
  final int? parentId;
  final String? parentName;
  final int? departmentId;
  final String? departmentName;
  final int? officeId;
  final String? officeName;
  final int? jobId;
  final String? jobName;
  final bool isKafeel;

  const KafeelEmployee({
    required this.id,
    required this.engFullName,
    required this.quadName,
    this.parentId,
    this.parentName,
    this.departmentId,
    this.departmentName,
    this.officeId,
    this.officeName,
    this.jobId,
    this.jobName,
    required this.isKafeel,
  });

  @override
  List<Object?> get props => [
        id,
        engFullName,
        quadName,
        parentId,
        parentName,
        departmentId,
        departmentName,
        officeId,
        officeName,
        jobId,
        jobName,
        isKafeel,
      ];
}
