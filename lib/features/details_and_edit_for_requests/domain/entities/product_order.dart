import 'package:equatable/equatable.dart';

class ProductOrderLineItemEntity extends Equatable {
  final int productId;
  final String productName;
  final int quantity;
  final String note;

  const ProductOrderLineItemEntity({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.note,
  });

  @override
  List<Object?> get props => [productId, productName, quantity, note];
}

class ProductOrderEntity extends Equatable {
  final bool isGift;
  final String? reason;
  final String? note;
  final String? editReasons;
  final String? rejectReasons;
  final List<ProductOrderLineItemEntity> lines;

  const ProductOrderEntity({
    required this.isGift,
    this.reason,
    this.note,
    this.editReasons,
    this.rejectReasons,
    this.lines = const [],
  });

  @override
  List<Object?> get props =>
      [isGift, reason, note, editReasons, rejectReasons, lines];
}
