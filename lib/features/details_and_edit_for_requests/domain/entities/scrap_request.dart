import 'package:equatable/equatable.dart';

class ScrapRequestLineItemEntity extends Equatable {
  final int productId;
  final String productName;
  final int quantity;
  final int? lotId;
  final String lotName;
  final String reason;

  const ScrapRequestLineItemEntity({
    required this.productId,
    required this.productName,
    required this.quantity,
    this.lotId,
    this.lotName = '',
    this.reason = '',
  });

  @override
  List<Object?> get props =>
      [productId, productName, quantity, lotId, lotName, reason];
}

class ScrapRequestEntity extends Equatable {
  final int? custodyId;
  final String custodyName;
  final int? stockRequestId;
  final String stockRequestName;
  final int? reasonId;
  final String reasonName;
  final String? editReasons;
  final String? rejectReasons;
  final List<ScrapRequestLineItemEntity> lines;

  const ScrapRequestEntity({
    this.custodyId,
    this.custodyName = '',
    this.stockRequestId,
    this.stockRequestName = '',
    this.reasonId,
    this.reasonName = '',
    this.editReasons,
    this.rejectReasons,
    this.lines = const [],
  });

  @override
  List<Object?> get props => [
        custodyId,
        custodyName,
        stockRequestId,
        stockRequestName,
        reasonId,
        reasonName,
        editReasons,
        rejectReasons,
        lines,
      ];
}
