import 'package:equatable/equatable.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/request.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/status.dart';

class History extends Equatable {
  final int id;
  final String changedBy;
  final DateTime changedAt;
  final String comment;
  final int requestId;
  final Request? request;
  final int statusId;
  final Status status;

  const History({
    required this.id,
    required this.changedBy,
    required this.changedAt,
    required this.comment,
    required this.requestId,
    required this.request,
    required this.statusId,
    required this.status,
  });

  /// fromJson
  factory History.fromJson(Map<String, dynamic> json) {
    try {
      return History(
        id: json['id'] ?? 0,
        changedBy: json['changedBy'] ?? '',
        changedAt: json['changedAt'] != null
            ? DateTime.parse(json['changedAt'])
            : DateTime.now(),
        comment: json['comment'] ?? '',
        requestId: json['requestId'] ?? 0,
        request:
            json['request'] != null ? Request.fromJson(json['request']) : null,
        statusId: json['statusId'] ?? 0,
        status: json['status'] != null
            ? Status.fromJson(json['status'])
            : Status.empty(),
      );
    } catch (_) {
      rethrow;
    }
  }

  /// to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'changedBy': changedBy,
      'changedAt': changedAt.toIso8601String(),
      'comment': comment,
      'requestId': requestId,
      'request': request?.toJson(),
      'statusId': statusId,
      'status': status.toJson(),
    };
  }

  @override
  List<Object?> get props => [];
}
