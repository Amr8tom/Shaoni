import 'package:shaoni/features/leaves/domain/entity/leave_interruption/create_leave_interruption_response.dart';

class CreateLeaveInterruptionResponseModel
    extends CreateLeaveInterruptionResponse {
  const CreateLeaveInterruptionResponseModel({
    super.success = false,
    super.message = '',
    super.requestId,
    super.requestName = '',
  });

  factory CreateLeaveInterruptionResponseModel.fromJson(
      Map<String, dynamic> json) {
    // The request name (e.g. "LIR/000013") lives in data.body.name on success.
    String requestName = '';
    final data = json['data'];
    if (data is Map<String, dynamic>) {
      final body = data['body'];
      if (body is Map<String, dynamic>) {
        requestName = body['name'] as String? ?? '';
      }
    }

    return CreateLeaveInterruptionResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      requestId: json['requestId'] as int?,
      requestName: requestName,
    );
  }
}
