import '../../domain/entities/approve_request.dart';
import 'odoo_request_model.dart';

class ApproveRequestModel extends ApproveRequest {
  const ApproveRequestModel(
      {required super.requestId,
      required super.statusNameAr,
      required super.statusNameEn,
      required super.statusId,
      required super.odooResult,
      required super.comment});

  /// from json
  factory ApproveRequestModel.fromJson(Map<String, dynamic> json) {
    return ApproveRequestModel(
        requestId: json['requestId'],
        statusNameAr: json['statusNameAr'],
        statusNameEn: json['statusNameEn'],
        statusId: json['statusId'],
        odooResult: json['odooResult'] != null
            ? OdooRequestModel.fromJson(json['odooResult'])
            : null,
        comment: json['comment']);
  }

  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'requestId': requestId,
      'statusNameAr': statusNameAr,
      'statusNameEn': statusNameEn,
      'statusId': statusId,
      'odooResult': (odooResult as OdooRequestModel?)?.toJson(),
      'comment': comment,
    };
  }
}
