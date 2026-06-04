//
// "odooResult": {
// "success": true,
// "code": "200",
// "status": "success",
// "message": "hr exit permission updated successfully",
// "externalId": null,
// "externalName": null,
// "externalState": null,
// "externalStateId": null
// },

import 'package:equatable/equatable.dart';

class OdooRequest extends Equatable {
  final bool success;
  final String code;
  final String status;
  final String? message;
  final String? externalId;
  final String? externalName;
  final String? externalState;
  final String? externalStateId;

  const OdooRequest({
    required this.success,
    required this.code,
    required this.status,
    required this.message,
    required this.externalId,
    required this.externalName,
    required this.externalState,
    required this.externalStateId,
  });

  /// fromJson
  factory OdooRequest.fromJson(Map<String, dynamic>? json) {
    return OdooRequest(
        success: json?['success'],
        code: json?['code'],
        status: json?['status'],
        message: json?['message'],
        externalId: json?['externalId'],
        externalName: json?['externalName'],
        externalState: json?['externalState'],
        externalStateId: json?['externalStateId']);
  }

  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'code': code,
      'status': status,
      'message': message,
      'externalId': externalId,
      'externalName': externalName,
      'externalState': externalState,
      'externalStateId': externalStateId,
    };
  }

  @override
  List<Object?> get props => [
        success,
        code,
        status,
        message,
        externalId,
        externalName,
        externalState,
        externalStateId
      ];
}
