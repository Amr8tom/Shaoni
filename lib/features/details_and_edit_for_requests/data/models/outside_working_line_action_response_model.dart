import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/outside_working_line_action_response.dart';

class OutsideWorkingLineActionResponseModel
    extends OutsideWorkingLineActionResponse {
  const OutsideWorkingLineActionResponseModel({
    super.status = '',
    super.message = '',
    super.odooLineId,
    super.localLineId,
    super.action = '',
    super.newState = '',
    super.cancelReason,
  });

  factory OutsideWorkingLineActionResponseModel.fromJson(
      Map<String, dynamic> json) {
    return OutsideWorkingLineActionResponseModel(
      status: json['status'] as String? ?? '',
      message: json['message'] as String? ?? '',
      odooLineId: (json['odooLineId'] as num?)?.toInt(),
      localLineId: (json['localLineId'] as num?)?.toInt(),
      action: json['action'] as String? ?? '',
      newState: json['newState'] as String? ?? '',
      cancelReason: json['cancelReason'] as String?,
    );
  }

  static Map<String, dynamic> toJsonFromEntity(
      OutsideWorkingLineActionResponse e) {
    return {
      'status': e.status,
      'message': e.message,
      'odooLineId': e.odooLineId,
      'localLineId': e.localLineId,
      'action': e.action,
      'newState': e.newState,
      'cancelReason': e.cancelReason,
    };
  }
}
