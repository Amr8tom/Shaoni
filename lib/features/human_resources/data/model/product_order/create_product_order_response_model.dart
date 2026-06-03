import 'package:shaoni/features/human_resources/domain/entity/product_order/create_product_order_response.dart';

class CreateProductOrderResponseModel extends CreateProductOrderResponse {
  const CreateProductOrderResponseModel({
    required super.success,
    required super.message,
    super.requestId,
    super.requestName,
  });

  factory CreateProductOrderResponseModel.fromJson(Map<String, dynamic> json) {
    // Try to extract name from nested data.body
    String? name;
    try {
      final data = json['data'];
      if (data is Map) {
        final body = data['body'];
        if (body is Map) {
          name = body['name']?.toString();
        }
      }
    } catch (_) {}

    return CreateProductOrderResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message']?.toString() ?? '',
      requestId: json['requestId'] as int?,
      requestName: name,
    );
  }
}
