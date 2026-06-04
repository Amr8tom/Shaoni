import '../../../domain/entities/training_request/create_training_response.dart';

class CreateTrainingResponseModel extends CreateTrainingResponse {
  const CreateTrainingResponseModel({
    required super.code,
    required super.status,
    required super.message,
    super.trainingRequestLocalId,
    super.trainingRequestId,
    super.trainingRequestName,
  });

  factory CreateTrainingResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateTrainingResponseModel(
      code: json['code']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      trainingRequestLocalId: json['trainingRequestLocalId'] as int?,
      trainingRequestId: json['trainingRequestId'] as int?,
      trainingRequestName: json['trainingRequestName']?.toString(),
    );
  }
}
