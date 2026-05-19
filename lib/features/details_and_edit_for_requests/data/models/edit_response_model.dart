import '../../domain/entities/edit/edit_response.dart';

class EditResponseModel extends EditResponse {
  const EditResponseModel({
    super.success,
    super.message,
    super.requestId,
    super.data,
  });

  factory EditResponseModel.fromJson(Map<String, dynamic> json) {
    return EditResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      requestId: json['requestId'] as int?,
      data: json['data'] as Map<String, dynamic>?,
    );
  }
}
