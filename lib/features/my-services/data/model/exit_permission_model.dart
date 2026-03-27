import 'package:shaoni/features/my-services/domain/entity/exit_permisstion.dart';

class ExitPermissionModel extends ExitPermission {
  const ExitPermissionModel({
    super.hrExitPermissionId,
    super.hrExitPermissionName,
    super.hrExitPermissionState,
    super.hrExitPermissionStateId,
    super.externalId,
    super.externalName,
    super.externalState,
    super.externalStateId,
    super.success,
    super.code,
    super.status,
    super.message,
  });

  /// fromJson
  factory ExitPermissionModel.fromJson(Map<String, dynamic> json) {
    return ExitPermissionModel(
      hrExitPermissionId: json['hrExitPermissionId'],
      hrExitPermissionName: json['hrExitPermissionName'],
      hrExitPermissionState: json['hrExitPermissionState'],
      hrExitPermissionStateId: json['hrExitPermissionStateId'],
      externalId: json['externalId'],
      externalName: json['externalName'],
      externalState: json['externalState'],
      externalStateId: json['externalStateId'],
      success: json['success'],
      code: json['code'],
      status: json['status'],
      message: json['message'],
    );
  }

  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'hrExitPermissionId': hrExitPermissionId,
      'hrExitPermissionName': hrExitPermissionName,
      'hrExitPermissionState': hrExitPermissionState,
      'hrExitPermissionStateId': hrExitPermissionStateId,
      'externalId': externalId,
      'externalName': externalName,
      'externalState': externalState,
      'externalStateId': externalStateId,
      'success': success,
      'code': code,
      'status': status,
      'message': message,
    };
  }
}
