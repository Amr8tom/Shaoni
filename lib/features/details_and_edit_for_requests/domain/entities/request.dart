import 'package:equatable/equatable.dart';
import '../../../services/domain/entity/service.dart';
import 'history.dart';

class Request extends Equatable {
  final int? id;
  final String? requestNumber;
  final int? requesterId;
  final int? requestId;
  final int? serviceId;
  final bool isGift;
  final int? kafeelId;
  final bool needEmp;
  final String? odooStatus;
  final int? statusId;
  final String? createdAt;
  final String? updatedAt;
  final Service? service;
  final List<History> histories;

  const Request({
    required this.id,
    required this.requestNumber,
    required this.requesterId,
    required this.requestId,
    required this.serviceId,
    required this.isGift,
    this.kafeelId,
    required this.needEmp,
    required this.odooStatus,
    required this.statusId,
    required this.createdAt,
    this.updatedAt,
    required this.service,
    required this.histories,
  });

  @override
  List<Object?> get props => [
        id,
        requestNumber,
        requesterId,
        requestId,
        serviceId,
        isGift,
        kafeelId,
        needEmp,
        odooStatus,
        statusId,
        createdAt,
        updatedAt,
        service,
        histories,
      ];
}
