// {
// "requestId": 58,
// "statusNameAr": "يعتمد",
// "statusNameEn": "Done",
// "statusId": 16,
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
// "comment": "Approved"
// }

import 'package:equatable/equatable.dart';
import 'package:shaoni/features/my-requests/domain/entities/odoo_request.dart';

class ApproveRequest extends Equatable {
  final int requestId;
  final String statusNameAr;
  final String statusNameEn;
  final int statusId;
  final OdooRequest odooResult;
  final String comment;

  const ApproveRequest({
    required this.requestId,
    required this.statusNameAr,
    required this.statusNameEn,
    required this.statusId,
    required this.odooResult,
    required this.comment,
  });

  @override
  List<Object?> get props =>
      [requestId, statusNameAr, statusNameEn, statusId, odooResult, comment];
}
