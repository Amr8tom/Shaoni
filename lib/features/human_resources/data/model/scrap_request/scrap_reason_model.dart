import 'package:shaoni/features/human_resources/domain/entity/scrap_request/scrap_reason_entity.dart';

class ScrapReasonModel extends ScrapReasonEntity {
  const ScrapReasonModel({required super.id, required super.name});

  factory ScrapReasonModel.fromJson(Map<String, dynamic> json) {
    return ScrapReasonModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
    );
  }
}
