import 'package:shaoni/features/human_resoures/domain/entity/product_order/product.dart';

class OdooProductModel extends OdooProduct {
  const OdooProductModel({required super.id, required super.name});

  factory OdooProductModel.fromJson(Map<String, dynamic> json) {
    return OdooProductModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
    );
  }
}
