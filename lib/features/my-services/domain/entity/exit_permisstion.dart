import 'package:equatable/equatable.dart';
class ExitPermission extends Equatable {
  final int? hrExitPermissionId;
  final String? hrExitPermissionName;
  final String? hrExitPermissionState;
  final int? hrExitPermissionStateId;
  final int? externalId;
  final String? externalName;
  final String? externalState;
  final int? externalStateId;
  final bool? success;
  final String? code;
  final String? status;
  final String? message;

  const ExitPermission({
    this.hrExitPermissionId,
    this.hrExitPermissionName,
    this.hrExitPermissionState,
    this.hrExitPermissionStateId,
    this.externalId,
    this.externalName,
    this.externalState,
    this.externalStateId,
    this.success,
    this.code,
    this.status,
    this.message,
  });

  /// from Json
  factory ExitPermission.fromJson(Map<String, dynamic> json) {
    return ExitPermission(
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
  /// to json
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

  @override
  List<Object?> get props => [
    hrExitPermissionId,
    hrExitPermissionName,
    hrExitPermissionState,
    hrExitPermissionStateId,
    externalId,
    externalName,
    externalState,
    externalStateId,
    success,
    code,
    status,
    message,
  ];
}
