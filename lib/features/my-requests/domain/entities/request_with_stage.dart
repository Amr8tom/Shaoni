
import 'package:equatable/equatable.dart';
import 'package:shaoni/features/my-requests/domain/entities/request.dart';
import 'package:shaoni/features/my-services/data/model/service_model.dart';
import 'extra_data.dart';
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
class RequestWithStage extends Equatable {
  final int odooStageId;
  final ExtraData? extraData;
  final String requesterFullName;
  final String managerFullName;
  final Request? request;
  final ServiceModel? service;
  final List<History>? histories;

  const RequestWithStage({
    required this.odooStageId,
    this.extraData,
    required this.requesterFullName,
    required this.managerFullName,
    this.request,
    this.service,
    this.histories,
  });

  /// from Json
  factory RequestWithStage.fromJson(Map<String, dynamic> json) {
    return RequestWithStage(
      odooStageId: json['odooStageId'],
      extraData: json['extraData'] != null ? ExtraData.fromJson(json['extraData']) : null,
        requesterFullName: json['requesterFullName'],
        managerFullName: json['managerFullName'],
        request: json['request'] != null ? Request.fromJson(json['request']) : null,
        service: json['service'] != null ? ServiceModel.fromJson(json['service']) : null,
        histories: json['histories'] != null ? List<History>.from(json['histories'].map((x) => History.fromJson(x))) : null,
    );
  }
  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'odooStageId': odooStageId,
      'extraData': extraData?.toJson(),
      'requesterFullName': requesterFullName,
      'managerFullName': managerFullName,
      'request': request?.toJson(),
      'service': service?.toJson(),
      'histories': histories != null ? List<dynamic>.from(histories!.map((x) => x.toJson())) : null,
    };
  }

  @override
  List<Object?> get props => [
    odooStageId,
    extraData,
    requesterFullName,
    managerFullName,
    request,
    service,
    histories,
  ];
}
