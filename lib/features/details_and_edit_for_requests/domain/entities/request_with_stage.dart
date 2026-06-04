import 'package:equatable/equatable.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/request.dart';
import '../../../services/domain/entity/service.dart';
import 'current_status.dart';
import 'extra_data.dart';
import 'history.dart';

class RequestWithStage extends Equatable {
  final int? odooStageId;
  final ExtraData? extraData;
  final String? requesterFullName;
  final String? managerFullName;
  final Request? request;
  final Service? service;
  final List<History>? histories;
  final CurrentStatus? currentStatus;

  const RequestWithStage({
    required this.odooStageId,
    this.extraData,
    required this.requesterFullName,
    required this.managerFullName,
    this.request,
    this.service,
    this.histories,
    this.currentStatus,
  });

  @override
  List<Object?> get props => [
        odooStageId,
        extraData,
        requesterFullName,
        managerFullName,
        currentStatus,
        request,
        service,
        histories,
      ];
}
