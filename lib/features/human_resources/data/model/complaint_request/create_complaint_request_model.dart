import '../../../domain/entity/complaint_request/create_complaint_request.dart';

class CreateComplaintRequestModel extends CreateComplaintRequest {
  const CreateComplaintRequestModel({
    required super.success,
    required super.message,
    required super.requestId,
    required super.data,
  });

  /// from json
  factory CreateComplaintRequestModel.fromJson(Map<String, dynamic> json) {
    return CreateComplaintRequestModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      requestId: json['requestId'] ?? 0,
      data: json['data'],
    );
  }

  /// to json
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'requestId': requestId,
      'data': data,
    };
  }
}
