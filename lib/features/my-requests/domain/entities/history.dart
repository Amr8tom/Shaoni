// {
// "id": 100,
// "changedBy": "16",
// "changedAt": "2026-03-26T09:00:39.7104691",
// "comment": null,
// "requestId": 43,
// "request": null,
// "statusId": 13,
// "status": {
// "id": 13,
// "code": "1",
// "nameAr": "جديد",
// "nameEn": "New",
// "techName": "new",
// "isActive": true,
// "updatedAt": "2026-03-18T11:35:38.2681105",
// "isDeleted": false,
// "serviceStatuses": null
// }
// }

import 'package:equatable/equatable.dart';
import 'package:shaoni/features/my-requests/domain/entities/request.dart';
import 'package:shaoni/features/my-requests/domain/entities/status.dart';

class History extends Equatable{
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
    return History(
      id: json['id'],
      changedBy: json['changedBy'],
      changedAt: DateTime.parse(json['changedAt']),
      comment: json['comment'] ?? '',
      requestId: json['requestId'],
      request: json['request'] != null ? Request.fromJson(json['request']) : null,
      statusId: json['statusId'],
      status: Status.fromJson(json['status']),
    );
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