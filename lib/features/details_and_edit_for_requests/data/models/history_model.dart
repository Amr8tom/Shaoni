import 'package:shaoni/features/details_and_edit_for_requests/data/models/request_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/status_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/history.dart';

class HistoryModel extends History {
  const HistoryModel({
    required super.id,
    required super.changedBy,
    required super.changedAt,
    required super.comment,
    required super.requestId,
    required super.request,
    required super.statusId,
    required super.status,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json['id'] ?? 0,
      changedBy: json['changedBy'] ?? '',
      changedAt: json['changedAt'] != null
          ? DateTime.parse(json['changedAt'])
          : DateTime.now(),
      comment: json['comment'] ?? '',
      requestId: json['requestId'] ?? 0,
      request: json['request'] != null
          ? RequestModel.fromJson(json['request'])
          : null,
      statusId: json['statusId'] ?? 0,
      status: json['status'] != null
          ? StatusModel.fromJson(json['status'])
          : StatusModel.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return toJsonFromEntity(this);
  }

  static Map<String, dynamic> toJsonFromEntity(History history) {
    return {
      'id': history.id,
      'changedBy': history.changedBy,
      'changedAt': history.changedAt.toIso8601String(),
      'comment': history.comment,
      'requestId': history.requestId,
      'request': history.request == null
          ? null
          : RequestModel.toJsonFromEntity(history.request!),
      'statusId': history.statusId,
      'status': StatusModel.toJsonFromEntity(history.status),
    };
  }
}
