import 'package:shaoni/features/human_resources/domain/entity/scrap_request/scrap_lot.dart';

class ScrapLotModel extends ScrapLot {
  const ScrapLotModel({required super.id, required super.name});

  factory ScrapLotModel.fromJson(Map<String, dynamic> json) {
    return ScrapLotModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
    );
  }
}
