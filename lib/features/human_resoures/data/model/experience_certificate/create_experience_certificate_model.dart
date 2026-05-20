import 'package:shaoni/features/human_resoures/domain/entity/experience_certificate/create_experience_certificate_response.dart';

class CreateExperienceCertificateModel
    extends CreateExperienceCertificateResponse {
  const CreateExperienceCertificateModel({
    required super.success,
    super.message,
    required super.requestId,
  });

  factory CreateExperienceCertificateModel.fromJson(
      Map<String, dynamic> json) {
    return CreateExperienceCertificateModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      requestId: json['requestId'] ?? 0,
    );
  }
}
