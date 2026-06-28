import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/scrap_request.dart';

class ScrapRequestLineItemModel extends ScrapRequestLineItemEntity {
  const ScrapRequestLineItemModel({
    required super.productId,
    required super.productName,
    required super.quantity,
    super.lotId,
    super.lotName = '',
    super.reason = '',
  });

  factory ScrapRequestLineItemModel.fromJson(Map<String, dynamic> json) {
    return ScrapRequestLineItemModel(
      productId: json['productId'] as int? ?? 0,
      productName: json['productName'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 0,
      lotId: json['lotId'] as int?,
      lotName: json['lotName'] as String? ?? '',
      reason: json['reason'] as String? ?? '',
    );
  }
}

class ScrapRequestModel extends ScrapRequestEntity {
  const ScrapRequestModel({
    super.custodyId,
    super.custodyName = '',
    super.stockRequestId,
    super.stockRequestName = '',
    super.reasonId,
    super.reasonName = '',
    super.editReasons,
    super.rejectReasons,
    super.lines = const [],
  });

  factory ScrapRequestModel.fromJson(Map<String, dynamic> json) {
    final rawLines = json['lines'];
    final List<ScrapRequestLineItemModel> lineItems = rawLines is List
        ? rawLines
            .map((e) =>
                ScrapRequestLineItemModel.fromJson(e as Map<String, dynamic>))
            .toList()
        : [];

    return ScrapRequestModel(
      custodyId: json['custodyId'] as int?,
      custodyName: json['custodyName'] as String? ?? '',
      stockRequestId: json['stockRequestId'] as int?,
      stockRequestName: json['stockRequestName'] as String? ?? '',
      reasonId: json['reasonId'] as int?,
      reasonName: json['reasonName'] as String? ?? '',
      editReasons: json['editReasons'] as String?,
      rejectReasons: json['rejectReasons'] as String?,
      lines: lineItems,
    );
  }
}
