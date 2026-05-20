import 'package:shaoni/features/human_resoures/domain/entity/id_document/create_id_document_response.dart';

class CreateIDDocumentModel extends CreateIDDocumentResponse {
  const CreateIDDocumentModel({
    required super.success,
    super.message,
    required super.requestId,
  });

  factory CreateIDDocumentModel.fromJson(Map<String, dynamic> json) {
    return CreateIDDocumentModel(
      success: json['success'] as bool? ?? true,
      message: json['message']?.toString(),
      requestId: (json['requestId'] as num?)?.toInt() ??
          (json['id'] as num?)?.toInt() ??
          0,
    );
  }
}
