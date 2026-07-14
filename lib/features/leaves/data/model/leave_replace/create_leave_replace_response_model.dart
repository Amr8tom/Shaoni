import 'package:shaoni/features/leaves/domain/entity/leave_replace/create_leave_replace_response.dart';

class CreateLeaveReplaceResponseModel extends CreateLeaveReplaceResponse {
  const CreateLeaveReplaceResponseModel({
    super.success = false,
    super.message = '',
    super.requestId,
    super.requestName = '',
  });

  factory CreateLeaveReplaceResponseModel.fromJson(Map<String, dynamic> json) {
    // The request name (e.g. "LR000013") lives in data.body.name on success.
    String requestName = '';
    final data = json['data'];
    if (data is Map<String, dynamic>) {
      final body = data['body'];
      if (body is Map<String, dynamic>) {
        requestName = body['name'] as String? ?? '';
      }
    }

    return CreateLeaveReplaceResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      requestId: json['requestId'] as int?,
      requestName: requestName,
    );
  }
}
