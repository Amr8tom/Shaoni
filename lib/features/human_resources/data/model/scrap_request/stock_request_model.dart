import 'package:shaoni/features/human_resources/domain/entity/scrap_request/stock_request_entity.dart';

class StockRequestModel extends StockRequestEntity {
  const StockRequestModel({required super.id, required super.name});

  factory StockRequestModel.fromJson(Map<String, dynamic> json) {
    return StockRequestModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
    );
  }
}
