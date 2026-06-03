import '../../../domain/entity/start_work/create_start_work_response.dart';

class CreateStartWorkModel extends CreateStartWorkResponse {
  const CreateStartWorkModel({
    required super.success,
    required super.message,
    required super.requestId,
  });

  factory CreateStartWorkModel.fromJson(Map<String, dynamic> json) {
    return CreateStartWorkModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      requestId: json['startWorkingId'] ?? json['requestId'] ?? 0,
    );
  }
}
