import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/product_order.dart';

class ProductOrderLineItem extends ProductOrderLineItemEntity {
  const ProductOrderLineItem({
    required super.productId,
    required super.productName,
    required super.quantity,
    required super.note,
  });

  factory ProductOrderLineItem.fromJson(Map<String, dynamic> json) {
    return ProductOrderLineItem(
      productId: json['productId'] as int? ?? 0,
      productName: json['productName'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 0,
      note: json['note'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'productName': productName,
        'quantity': quantity,
        'note': note,
      };

  static Map<String, dynamic> toJsonFromEntity(
    ProductOrderLineItemEntity line,
  ) {
    return {
      'productId': line.productId,
      'productName': line.productName,
      'quantity': line.quantity,
      'note': line.note,
    };
  }
}

class ProductOrderModel extends ProductOrderEntity {
  const ProductOrderModel({
    required super.isGift,
    super.reason,
    super.note,
    super.editReasons,
    super.rejectReasons,
    super.lines = const [],
  });

  factory ProductOrderModel.fromJson(Map<String, dynamic> json) {
    final rawLines = json['lines'];
    final List<ProductOrderLineItem> lineItems = rawLines is List
        ? rawLines
            .map(
                (e) => ProductOrderLineItem.fromJson(e as Map<String, dynamic>))
            .toList()
        : [];

    return ProductOrderModel(
      isGift: json['isGift'] as bool? ?? false,
      reason: json['reason'] as String?,
      note: json['note'] as String?,
      editReasons: json['editReasons'] as String?,
      rejectReasons: json['rejectReasons'] as String?,
      lines: lineItems,
    );
  }

  Map<String, dynamic> toJson() => {
        'isGift': isGift,
        'reason': reason,
        'note': note,
        'editReasons': editReasons,
        'rejectReasons': rejectReasons,
        'lines': lines.map(ProductOrderLineItem.toJsonFromEntity).toList(),
      };
}
