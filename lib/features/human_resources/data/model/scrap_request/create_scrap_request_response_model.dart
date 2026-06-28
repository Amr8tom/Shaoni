import 'package:shaoni/features/human_resources/domain/entity/scrap_request/create_scrap_request_response.dart';

class CreateScrapRequestResponseModel extends CreateScrapRequestResponse {
  const CreateScrapRequestResponseModel({
    required super.success,
    required super.message,
    super.requestId,
    super.requestName,
  });

  factory CreateScrapRequestResponseModel.fromJson(Map<String, dynamic> json) {
    final body = json['body'];
    final data = body is Map<String, dynamic> ? body : null;
    return CreateScrapRequestResponseModel(
      success: (json['code'] as int? ?? 0) == 200 ||
          (json['code'] as int? ?? 0) == 201,
      message: json['message'] as String? ?? '',
      requestId: data?['id'] as int?,
      requestName: data?['name'] as String?,
    );
  }
}
