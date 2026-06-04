import 'package:shaoni/features/details_and_edit_for_requests/data/models/request_with_stage_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/all_requests_with_stages.dart';

class AllRequestsWithStagesModel extends AllRequestsWithStages {
  const AllRequestsWithStagesModel({
    required super.pageNumber,
    required super.pageSize,
    required super.totalCount,
    required super.totalPages,
    required super.items,
  });

  factory AllRequestsWithStagesModel.fromJson(Map<String, dynamic> json) {
    return AllRequestsWithStagesModel(
      pageNumber: json['pageNumber'] as int? ?? 0,
      pageSize: json['pageSize'] as int? ?? 0,
      totalCount: json['totalCount'] as int? ?? 0,
      totalPages: json['totalPages'] as int? ?? 0,
      items: (json['items'] as List<dynamic>?)
              ?.map((item) =>
                  RequestWithStageModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pageNumber': pageNumber,
      'pageSize': pageSize,
      'totalCount': totalCount,
      'totalPages': totalPages,
      'items': items.map(RequestWithStageModel.toJsonFromEntity).toList(),
    };
  }
}
