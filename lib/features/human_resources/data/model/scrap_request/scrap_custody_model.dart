import 'package:shaoni/features/human_resources/domain/entity/scrap_request/scrap_custody.dart';

class ScrapCustodyModel extends ScrapCustody {
  const ScrapCustodyModel({
    required super.id,
    required super.name,
    required super.productId,
    required super.productName,
  });

  factory ScrapCustodyModel.fromJson(Map<String, dynamic> json) {
    final productMap = json['product_id'] as Map<String, dynamic>?;
    return ScrapCustodyModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      productId: productMap?['id'] as int? ?? 0,
      productName: productMap?['name'] as String? ?? '',
    );
  }
}
