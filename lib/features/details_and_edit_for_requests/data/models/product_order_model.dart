import 'package:equatable/equatable.dart';

class ProductOrderLineItem extends Equatable {
  final int productId;
  final String productName;
  final int quantity;
  final String note;

  const ProductOrderLineItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.note,
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

  @override
  List<Object?> get props => [productId, productName, quantity, note];
}

class ProductOrderModel extends Equatable {
  final bool isGift;
  final String? reason;
  final String? note;
  final String? editReasons;
  final String? rejectReasons;
  final List<ProductOrderLineItem> lines;

  const ProductOrderModel({
    required this.isGift,
    this.reason,
    this.note,
    this.editReasons,
    this.rejectReasons,
    this.lines = const [],
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
        'lines': lines.map((l) => l.toJson()).toList(),
      };

  @override
  List<Object?> get props =>
      [isGift, reason, note, editReasons, rejectReasons, lines];
}
