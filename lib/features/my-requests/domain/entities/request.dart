import 'package:equatable/equatable.dart';

import '../../../human_resoures/data/model/service_model.dart';
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
  final ServiceModel? service;
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

  /// from json
  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['id'],
      requestNumber: json['requestNumber'],
      requesterId: json['requesterId'],
      requestId: json['requestId'],
      serviceId: json['serviceId'],
      isGift: json['isGift'] ?? false,
      kafeelId: json['kafeelId'],
      needEmp: json['needEmp'] ?? false,
      odooStatus: json['odooStatus'] ?? '',
      statusId: json['statusId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      service: ServiceModel.fromJson(json['service']),
      histories: json['statusHistories'] != null
          ? List<History>.from(
              json['statusHistories'].map((x) => History.fromJson(x)))
          : [],
    );
  }

  /// to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'requestNumber': requestNumber,
      'requesterId': requesterId,
      'requestId': requestId,
      'serviceId': serviceId,
      'isGift': isGift,
      'kafeelId': kafeelId,
      'needEmp': needEmp,
      'odooStatus': odooStatus,
      'statusId': statusId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'service': service?.toJson(),
      'histories': histories.map((x) => x.toJson()).toList(),
    };
  }

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
