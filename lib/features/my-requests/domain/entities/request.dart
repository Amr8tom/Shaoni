import 'package:equatable/equatable.dart';
import 'package:shaoni/features/my-services/data/model/service_model.dart';

import '../../../my-services/domain/entity/service.dart';
import 'history.dart';

// {
// "odooStageId": 13,
// "extraData": {
// "attendance": null,
// "study": null,
// "outsideWorking": null,
// "visaRequest": null,
// "exitPermission": {
// "id": 40,
// "exitDate": "2026-03-29T00:00:00",
// "numberOfHours": 1,
// "permissionTimeValue": "med",
// "permissionType": 2,
// "notes": "tejst",
// "leavesAttachment": null
// }
// },
// "requesterFullName": null,
// "managerFullName": null,
// "request": {
// "id": 43,
// "requestNumber": "EP/2026/00161",
// "requesterId": 2,
// "requestId": 161,
// "serviceId": 5,
// "isGift": null,
// "kafeelId": null,
// "need_emp": false,
// "odooStatus": "new",
// "statusId": 13,
// "createdAt": "2026-03-26T09:00:39.6442287",
// "updatedAt": null,
// "service": {
// "id": 5,
// "code": "1957",
// "nameAr": "طلب إذن خروج",
// "nameEn": "hr.exit.permission",
// "isActive": true,
// "updatedAt": "2025-12-22T17:28:39.4205298",
// "isDeleted": false,
// "serviceStatuses": null,
// "roleServices": null,
// "userServices": null
// },
// "statusHistories": null
// },
// "service": {
// "id": 5,
// "code": "1957",
// "nameAr": "طلب إذن خروج",
// "nameEn": "hr.exit.permission",
// "isActive": true,
// "updatedAt": "2025-12-22T17:28:39.4205298",
// "isDeleted": false,
// "serviceStatuses": null,
// "roleServices": null,
// "userServices": null
// },
// "histories": [
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
// ]
// },
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
  List<Object?> get props =>
      [
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
