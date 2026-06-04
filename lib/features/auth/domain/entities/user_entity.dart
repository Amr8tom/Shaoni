import 'package:equatable/equatable.dart';
import 'package:shaoni/features/auth/data/model/department_model.dart';
import 'package:shaoni/features/auth/data/model/office_model.dart';

import 'department.dart';
import 'office.dart';

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
  final int? managerId;
  final String? managerName;
  final int? officeId;
  final List<OfficeModel>? officeIds;

  final OfficeModel? office;
  final int? departmentId;

  final DepartmentModel? department;

  const UserEntity({
    required this.id,
    required this.nationality,
    required this.fullName,
    required this.userName,
    required this.email,
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
        employeeId,
        managerId,
        managerName,
        officeId,
        officeIds,
        office,
        departmentId,
        department,
      ];
}
