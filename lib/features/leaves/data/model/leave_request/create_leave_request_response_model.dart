import 'package:shaoni/features/leaves/domain/entity/leave_request/create_leave_request_response.dart';

class CreateLeaveRequestResponseModel extends CreateLeaveRequestResponse {
  const CreateLeaveRequestResponseModel({
    super.success = false,
    super.message = '',
    super.requestId,
    super.requestName = '',
  });

  factory CreateLeaveRequestResponseModel.fromJson(Map<String, dynamic> json) {
    // Success/failure is signalled by `code` ("200" / "400"), not a bool.
    final code = json['code']?.toString() ?? '';

    int? requestId;
    String requestName = '';
    final body = json['body'];
    if (body is Map<String, dynamic>) {
      requestId = (body['id'] as num?)?.toInt();
      requestName = body['sequence_number'] as String? ?? '';
    }

    return CreateLeaveRequestResponseModel(
      success: code == '200',
      message: json['message'] as String? ?? '',
      requestId: requestId,
      requestName: requestName,
    );
  }
}
