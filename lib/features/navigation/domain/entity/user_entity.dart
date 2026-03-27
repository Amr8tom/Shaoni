import 'package:equatable/equatable.dart';
import '../../../auth/domain/entities/department.dart';
import '../../../auth/domain/entities/office.dart';

class UserEntity extends Equatable {
  final int id;
  final String fullName;
  final String userName;
  final String email;
  final String role;
  final int roleId;
  final String phoneNumber;
  final String city;
  final bool isActive;
  final int employeeId;
  final int managerId;
  final String managerName;
  final int officeId;
  final OfficeEntity office;
  final int departmentId;
  final DepartmentEntity department;
  final String? token;

  const UserEntity({
    required this.id,
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
    required this.departmentId,
    required this.department,
    this.token,
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
    city,
    isActive,
    employeeId,
    managerId,
    managerName,
    officeId,
    office,
    departmentId,
    department,
    token,
  ];
}
