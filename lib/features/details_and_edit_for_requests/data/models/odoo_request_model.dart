import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/odoo_request.dart';

class OdooRequestModel extends OdooRequest {
  const OdooRequestModel({
    required super.success,
    required super.code,
    required super.status,
    required super.message,
    required super.externalId,
    required super.externalName,
    required super.externalState,
    required super.externalStateId,
  });

  factory OdooRequestModel.fromJson(Map<String, dynamic>? json) {
    return OdooRequestModel(
        success: json?['success'] ?? false,
        code: json?['code'] ?? '',
        status: json?['status'] ?? '',
        message: json?['message'],
        externalId: json?['externalId'],
        externalName: json?['externalName'],
        externalState: json?['externalState'],
        externalStateId: json?['externalStateId']);
  }

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
}
