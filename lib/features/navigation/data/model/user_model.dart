import 'package:shaoni/features/auth/data/model/office_model.dart';
import 'package:shaoni/features/auth/domain/entities/user_entity.dart';
import '../../../auth/data/model/department_model.dart';


class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.fullName,
    required super.userName,
    required super.email,
    required super.role,
    required super.roleId,
    required super.phoneNumber,
    required super.city,
    required super.isActive,
    required super.employeeId,
    required super.managerId,
    required super.managerName,
    required super.officeId,
    required super.office,
    required super.departmentId,
    required super.department,
  });


  /// fromJson
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      fullName: json['fullName'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      roleId: json['roleId'] ?? 0,
      phoneNumber: json['phoneNumber'] ?? '',
      city: json['city'] ?? '',
      isActive: json['isActive'] ?? false,
      employeeId: json['employeeId'] ?? 0,
      managerId: json['managerId'] ?? 0,
      managerName: json['managerName'] ?? '',
      officeId: json['officeId'] ?? 0,
      office: OfficeModel.fromJson(json['office']),
      departmentId: json['departmentId'] ?? 0,
      department: DepartmentModel.fromJson(json['department']),
    );
  }

  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'userName': userName,
      'email': email,
      'role': role,
      'roleId': roleId,
      'phoneNumber': phoneNumber,
      'city': city,
      'isActive': isActive,
      'employeeId': employeeId,
      'managerId': managerId,
      'managerName': managerName,
      'officeId': officeId,
      'office': office?.toJson(),
      'departmentId': departmentId,
      'department': department?.toJson(),
    };
  }

}
