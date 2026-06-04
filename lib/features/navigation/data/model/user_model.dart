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
    required super.nationality,
    required super.isActive,
    required super.employeeId,
    required super.managerId,
    required super.managerName,
    required super.officeId,
    required super.officeIds,
    required super.office,
    required super.departmentId,
    required super.department,
    required super.gender,
  });

  /// fromJson
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['data']['id'] ?? 0,
      fullName: json['data']['fullName'] ?? '',
      userName: json['data']['userName'] ?? '',
      email: json['data']['email'] ?? '',
      role: json['data']['role'] ?? '',
      nationality: json['data']['nationality'] ?? '',
      gender: json['data']['gender'] ?? '',
      roleId: json['data']['roleId'] ?? 0,
      phoneNumber: json['data']['phoneNumber'] ?? '',
      city: json['data']['city'] ?? '',
      isActive: json['data']['isActive'] ?? false,
      employeeId: json['data']['employeeId'] ?? 0,
      managerId: json['data']['managerId'] ?? 0,
      managerName: json['data']['managerName'] ?? '',
      officeId: json['data']['officeId'] ?? 0,
      office: OfficeModel.fromJson(json['data']['office']),
      officeIds: (json['data']['office_ids'] as List<dynamic>?)
          ?.map((officeJson) => OfficeModel.fromJson(officeJson))
          .toList(),
      departmentId: json['data']['departmentId'] ?? 0,
      department: DepartmentModel.fromJson(json['data']['department']),
    );
  }

  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'nationality': nationality,
      'userName': userName,
      'email': email,
      'role': role,
      'roleId': roleId,
      'phoneNumber': phoneNumber,
      'city': city,
      'isActive': isActive,
      'gender': gender,
      'employeeId': employeeId,
      'managerId': managerId,
      'managerName': managerName,
      'officeId': officeId,
      'office_ids': officeIds?.map((office) => office.toJson()).toList(),
      'office': office?.toJson(),
      'departmentId': departmentId,
      'department': department?.toJson(),
    };
  }
}
