import '../../../domain/entity/loan/create_loan_response.dart';

class CreateLoanResponseModel extends CreateLoanResponse {
  const CreateLoanResponseModel({
    required super.success,
    required super.message,
    super.requestId,
  });

  factory CreateLoanResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateLoanResponseModel(
      success: json['success'] as bool? ?? false,
      message: (json['message'] ?? '').toString(),
      requestId: json['requestId'] as int?,
    );
  }

  Map<String, dynamic> toJson() => toJsonFromEntity(this);

  static Map<String, dynamic> toJsonFromEntity(CreateLoanResponse entity) {
    return {
      'success': entity.success,
      'message': entity.message,
      'requestId': entity.requestId,
    };
  }
}
