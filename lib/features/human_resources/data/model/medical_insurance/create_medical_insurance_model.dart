import 'package:shaoni/features/human_resources/domain/entity/medical_insurance/create_medical_insurance_response.dart';

class CreateMedicalInsuranceModel extends CreateMedicalInsuranceResponse {
  const CreateMedicalInsuranceModel({
    required super.success,
    super.message,
    required super.requestId,
  });

  factory CreateMedicalInsuranceModel.fromJson(Map<String, dynamic> json) {
    return CreateMedicalInsuranceModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      requestId: json['requestId'] ?? 0,
    );
  }
}
