import 'package:equatable/equatable.dart';
import 'package:shaoni/features/auth/domain/entities/department.dart';
import 'package:shaoni/features/auth/domain/entities/office.dart';

class UserEntity extends Equatable {
  final int? id;
  final String? fullName;
  final String? userName;
  final String? email;
  final String? gender;
  final String? role;
  final String? nationality;
  final int? roleId;
  final String? phoneNumber;
  final String? city;
  final bool isActive;
  final int? employeeId;
  final bool isKafeel;
  final int? managerId;
  final String? managerName;
  final int? officeId;
  final List<OfficeEntity>? officeIds;

  final OfficeEntity? office;
  final int? departmentId;

  final DepartmentEntity? department;
  final String? jobNumber;
  final String? jobTitle;
  final String? registrationNumber;

  const UserEntity({
    required this.id,
    required this.nationality,
    required this.fullName,
    required this.userName,
    required this.email,
    required this.isKafeel,
    required this.role,
    required this.roleId,
    required this.phoneNumber,
    required this.city,
    required this.isActive,
    required this.employeeId,
    required this.managerId,
    required this.managerName,
    required this.officeId,
    required this.office,
    required this.officeIds,
    required this.departmentId,
    required this.department,
    required this.gender,
    this.jobNumber,
    this.jobTitle,
    this.registrationNumber,
  });

  @override
  List<Object?> get props => [
        id,
        fullName,
        userName,
        email,
        role,
        roleId,
        phoneNumber,
        gender,
        nationality,
        city,
        isActive,
        isKafeel,
        employeeId,
        managerId,
        managerName,
        officeId,
        officeIds,
        office,
        departmentId,
        department,
        jobNumber,
        jobTitle,
        registrationNumber,
      ];
}
