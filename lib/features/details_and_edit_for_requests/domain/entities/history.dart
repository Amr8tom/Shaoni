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

  @override
  List<Object?> get props => [
        id,
        changedBy,
        changedAt,
        comment,
        requestId,
        request,
        statusId,
        status,
      ];
}
