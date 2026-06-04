import '../../../domain/entities/study/create_study_response.dart';

class CreateStudyModel extends CreateStudyResponse {
  const CreateStudyModel({
    required super.success,
    required super.message,
    required super.requestId,
    required super.data,
  });

  factory CreateStudyModel.fromJson(Map<String, dynamic> json) {
    return CreateStudyModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      requestId: json['studyRequestId'] ?? 0,
      data: json['data'],
    );
  }
}
