import 'package:shaoni/features/booking_managment/domain/entity/visa_request/create_visa_response.dart';

class CreateVisaResponseModel extends CreateVisaResponse {
  const CreateVisaResponseModel({
    super.code = '',
    super.status = '',
    super.message = '',
    super.visaRequestLocalId,
    super.visaRequestId,
    super.visaRequestName = '',
  });

  factory CreateVisaResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateVisaResponseModel(
      code: json['code']?.toString() ?? '',
      status: json['status'] as String? ?? '',
      message: json['message'] as String? ?? '',
      visaRequestLocalId: json['visaRequestLocalId'] as int?,
      visaRequestId: json['visaRequestId'] as int?,
      visaRequestName: json['visaRequestName'] as String? ?? '',
    );
  }
}
